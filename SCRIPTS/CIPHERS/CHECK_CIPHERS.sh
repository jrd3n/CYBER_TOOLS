#!/bin/bash

# pcap file
pcap_file=$1

# Extract IP addresses involved in handshakes
ip_pairs=$(tshark -r "${pcap_file}" -Y "tls.handshake.type == 1" -T fields -e ip.src -e ip.dst | sort | uniq)

# Convert IP pairs to array
IFS=$'\n' read -rd '' -a ip_pair_array <<< "$ip_pairs"

# Prompt user to select an IP pair
echo "Select an IP pair:"
for i in "${!ip_pair_array[@]}"; do
  printf "%d) %s\n" "$((i+1))" "${ip_pair_array[i]}"
done
read -p "Enter the number of your selection: " selection
selected_pair=${ip_pair_array[$((selection-1))]}
IFS=$'\t' read -r selected_src selected_dst <<< "$selected_pair"

# Extract and display the ClientHello details for the selected IP pair
client_hello=$(tshark -r "${pcap_file}" -Y "tls.handshake.type == 1 && ip.src == $selected_src && ip.dst == $selected_dst" -T fields -e tls.handshake.ciphersuite)

# Create a new CSV file
echo "Cipher,Name,Protocol,security,Enc,hash_algorithm,tls_version" > ciphers.csv

# Display table header
printf "\n%-10s %-50s %-10s %-10s %-10s %-10s %-10s %-10s\n" "$cipher" "$name" "$protocol" "$security" "$enc" "$hash_algorithm" "$tls_version"

# Process the client_hello string
IFS=',' read -ra ciphers <<< "$client_hello"

# Get the cipher details from ciphersuite.info
cipher_details=$(wget -qO- "https://ciphersuite.info/api/cs")

# Convert hex_byte_1 and hex_byte_2 entries in JSON data to uppercase
cipher_details=$(echo "$cipher_details" | jq 'walk(if type == "object" then with_entries(if .key == "hex_byte_1" or .key == "hex_byte_2" then .value |= ascii_upcase else . end) else . end)')

# Show the result in the console using jq to pretty-print the JSON
# echo "$cipher_details" | jq

# Loop over each cipher and append it to the CSV
for cipher in "${ciphers[@]}"
do
  # Check if the cipher is not empty
  if [ ! -z "$cipher" ] 
  then

    # Convert the cipher string to hexadecimal (remove the leading "0x")
    hex_cipher="${cipher#0x}"

    # Extract the first byte (hex_byte_1) and the second byte (hex_byte_2)
    hex_byte_1="0x${hex_cipher:0:2}"
    hex_byte_1=$(echo "$hex_byte_1" | tr '[:lower:]' '[:upper:]')

    hex_byte_2="0x${hex_cipher:2:2}"
    hex_byte_2=$(echo "$hex_byte_2" | tr '[:lower:]' '[:upper:]')

    # Search for the specific cipher in the JSON data based on hex_byte_1 and hex_byte_2 using jq
    filtered_ciphersuites=$(echo "$cipher_details" | jq --arg hex1 "$hex_byte_1" --arg hex2 "$hex_byte_2" '.ciphersuites[] | to_entries[] | select(.value.hex_byte_1 == $hex1 and .value.hex_byte_2 == $hex2)')

    # example

            #     "TLS_DH_anon_WITH_AES_256_CBC_SHA256": {
            #     "gnutls_name": "TLS_DH_ANON_AES_256_CBC_SHA256",
            #     "openssl_name": "ADH-AES256-SHA256",
            #     "hex_byte_1": "0x00",
            #     "hex_byte_2": "0x6D",
            #     "protocol_version": "TLS",
            #     "kex_algorithm": "DH",
            #     "auth_algorithm": "anon",
            #     "enc_algorithm": "AES 256 CBC",
            #     "hash_algorithm": "SHA256",
            #     "security": "insecure",
            #     "tls_version": ["TLS1.2", "TLS1.3"]
            # }

    # echo $filtered_ciphersuites | jq
    # # Extract the specific fields from the cipher_info
    name=$(echo "$filtered_ciphersuites" | jq -r '.key')
    protocol=$(echo "$filtered_ciphersuites" | jq -r '.value.protocol_version')
    security=$(echo "$filtered_ciphersuites" | jq -r '.value.security')
    enc=$(echo "$filtered_ciphersuites" | jq -r '.value.enc_algorithm')
    hash_algorithm=$(echo "$filtered_ciphersuites" | jq -r '.value.hash_algorithm')
    tls_version=$(echo "$filtered_ciphersuites" | jq -r '.value.tls_version')
    tls_version=$(echo "$tls_version" | tr -d '\n') # remove newlines from this string
    tls_version=$(echo "$tls_version" | tr ',' ';')

    # Write the cipher details to the CSV
    echo "$cipher,$name,$protocol,$security,$enc,$hash_algorithm,$tls_version" >> ciphers.csv

    # Display the cipher details in the console
    printf "%-10s %-50s %-10s %-10s %-10s %-10s %-10s %-10s\n" "$cipher" "$name" "$protocol" "$security" "$enc" "$hash_algorithm" "$tls_version"
    fi
    done