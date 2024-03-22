#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String                           | Run in Terminal        | Directory |
# | -------------------------- | ------------------------------------------ | ---------------------- | --------- |
# | MISC - CHECK CYPHERS       | THIS_FILE ${fetcher.ip} ${fetcher.comment} | TRUE                   |           |  

# Script information -----------------------------------------------------------
# | Script Name       : CHECK_CIPHERS.sh
# | Description       : A script to check the hello
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/HYDRA_WEB.sh
# | Author            : Jordon Archer
# | Date              : March 21, 2024
# ------------------------------------------------------------------------------

# Load Variables

fetcher_ip=$1  # Get the IP from the first argument
comment=$2

# Load colours
source ~/CYBER_TOOLS/OPENER_SCRIPTS/SUB_SCRIPTS/COLOURS.sh
source ~/CYBER_TOOLS/OPENER_SCRIPTS/SUB_SCRIPTS/FOLDER.sh

# Display Header

# Tool name https://manytools.org/hacker-tools/ascii-banner/ font ANSI SHADDOW
echo -e "${HEADER1}"  # Set colour to green and make it bold

echo " ██████╗██╗   ██╗██████╗ ██╗  ██╗███████╗██████╗ 
██╔════╝╚██╗ ██╔╝██╔══██╗██║  ██║██╔════╝██╔══██╗
██║      ╚████╔╝ ██████╔╝███████║█████╗  ██████╔╝
██║       ╚██╔╝  ██╔═══╝ ██╔══██║██╔══╝  ██╔══██╗
╚██████╗   ██║   ██║     ██║  ██║███████╗██║  ██║
 ╚═════╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                                                 "

echo -e "${NC}"  # Reset colour and bold

#description
echo -e "${HEADER2}Description${NC}"
echo -e "A Script that checks the hello ciphers in a wireshake file.\n"
echo -e "${NC}---------------------------------------------------------------------\n"

# -----------------------------------------------------------------------------------------------------

# Directory where the .pcap and .pcapng files are located
pcap_directory="./" # Adjust this to the directory you want to search in

# Find all .pcap and .pcapng files in the specified directory
pcap_files=($(find "$pcap_directory" -type f \( -iname "*.pcap" -o -iname "*.pcapng" \)))

# Check if any .pcap or .pcapng files were found
if [ ${#pcap_files[@]} -eq 0 ]; then
    echo "No .pcap or .pcapng files found in the directory."
    exit 1
elif [ ${#pcap_files[@]} -eq 1 ]; then
    # If only one file is found, use it
    pcap_file="${pcap_files[0]}"
    echo "Using the found file: $pcap_file"
else
    # If multiple files are found, prompt the user to choose one
    echo "Multiple .pcap or .pcapng files found. Please select one to use:"
    for i in "${!pcap_files[@]}"; do
        echo "$((i+1))) ${pcap_files[i]}"
    done

    read -p "${WARNING}Enter the number of the file you want to use: ${NC}" file_choice
    file_choice=$((file_choice-1))

    # Validate user selection
    if [ $file_choice -ge 0 ] && [ $file_choice -lt ${#pcap_files[@]} ]; then
        pcap_file="${pcap_files[$file_choice]}"
        echo "Using selected file: $pcap_file"
    else
        echo "Invalid selection. Exiting."
        exit 1
    fi
fi

#--------------------------------------------------------------------------------

file_owner=$(stat -c '%U' "$pcap_file")
if [ "$file_owner" != "$USER" ]; then
    echo "Changing file ownership to $USER for $pcap_file"
    sudo chown "$USER" "$pcap_file"
else
    echo "${SUCCESS}File $pcap_file is already owned by $USER${NC}"
    echo ""
fi

#--------------------------------------------------------------------------------

# Extract IP addresses involved in handshakes
ip_pairs=$(tshark -r "${pcap_file}" -Y "tls.handshake.type == 1" -T fields -e ip.src -e ip.dst | sort | uniq)

# Convert IP pairs to array
IFS=$'\n' read -rd '' -a ip_pair_array <<< "$ip_pairs"

# Prompt user to select an IP pair
echo "Select an IP pair:"
for i in "${!ip_pair_array[@]}"; do
  printf "%d) %s\n" "$((i+1))" "${ip_pair_array[i]}"
done
read -p "${WARNING}Enter the number of your selection: ${NC}" selection
selected_pair=${ip_pair_array[$((selection-1))]}
IFS=$'\t' read -r selected_src selected_dst <<< "$selected_pair"

# Extract and display the ClientHello details for the selected IP pair
client_hello=$(tshark -r "${pcap_file}" -Y "tls.handshake.type == 1 && ip.src == $selected_src && ip.dst == $selected_dst" -T fields -e tls.handshake.ciphersuite)

# Create a new CSV file
# echo "Cipher,Name,Protocol,security,Enc,hash_algorithm,tls_version" > ciphers.csv

# Display table header
# printf "\n%-10s %-50s %-10s %-10s %-10s %-10s %-10s %-10s\n" "$cipher" "$name" "$protocol" "$security" "$enc" "$hash_algorithm" "$tls_version"

# Process the client_hello string
IFS=',' read -ra ciphers <<< "$client_hello"

# Get the cipher details from ciphersuite.info
cipher_details=$(wget -qO- "https://ciphersuite.info/api/cs")

# Convert hex_byte_1 and hex_byte_2 entries in JSON data to uppercase
cipher_details=$(echo "$cipher_details" | jq 'walk(if type == "object" then with_entries(if .key == "hex_byte_1" or .key == "hex_byte_2" then .value |= ascii_upcase else . end) else . end)')

# Show the result in the console using jq to pretty-print the JSON
# echo "$cipher_details" | jq

# Initialize the strings for tables
all_ciphers_table=""
filtered_ciphers_table=""

# Header for tables
table_header=$(printf "|_. %-50s |_. %-10s |_. %-10s |\r\n" "Name" "Protocol" "Security")

printf "%-50s %-10s %-10s \r\n" "Name" "Protocol" "Security"

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
    This_cipher=$(echo "$cipher_details" | jq --arg hex1 "$hex_byte_1" --arg hex2 "$hex_byte_2" '.ciphersuites[] | to_entries[] | select(.value.hex_byte_1 == $hex1 and .value.hex_byte_2 == $hex2)')

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
    name=$(echo "$This_cipher" | jq -r '.key')
    protocol=$(echo "$This_cipher" | jq -r '.value.protocol_version')
    security=$(echo "$This_cipher" | jq -r '.value.security')
    security="${security^^}"
    enc=$(echo "$This_cipher" | jq -r '.value.enc_algorithm')
    hash_algorithm=$(echo "$This_cipher" | jq -r '.value.hash_algorithm')
    tls_version=$(echo "$This_cipher" | jq -r '.value.tls_version')
    tls_version=$(echo "$This_cipher" | tr -d '\n') # remove newlines from this string
    tls_version=$(echo "$This_cipher" | tr ',' ';')

    # Display the cipher details in the console
    printf "%-50s %-10s %-10s\r\n" "$name" "$protocol" "$security"

    # Append to all ciphers string
    all_ciphers_table+=$(printf "| %-50s  | %-10s  | %-10s  | \r\n" "$name" "$protocol" "$security")

        # Example filter: Add to filtered table if protocol is TLS1.3
    if [[ "$security" == "WEAK" || "$security" == "INSECURE" ]]; then
        filtered_ciphers_table+=$(printf "| %-50s  | %-10s  | %-10s  |\r\n" "$name" "$protocol" "$security")
    fi

    # Write the cipher details to the CSV
    # echo "$cipher,$name,$protocol,$security,$enc,$hash_algorithm,$tls_version" >> ciphers.csv

    fi
    done

    # Path for the output file

# Extract the base name of the .pcap file (without extension)
pcap_base_name=$(basename "$pcap_file" .pcap)

# If the file is .pcapng, adjust accordingly
pcap_base_name=$(basename "$pcap_base_name" .pcapng)

output_file="cipher_analysis_${pcap_base_name}.txt"

# Generate the output file
{
echo "Cipher Analysis Report"
echo "----------------------"
echo "The following file was analysed $pcap_file."
echo "The target key pair is $selected_pair."
datestamp=$(date +%Y-%m-%d)
echo "Analysis was conducted on $datestamp"
echo "----------------------"
echo "This report outlines the findings of the cipher analysis. It includes a complete list of ciphers followed by a filtered list based on predefined criteria."
echo ""
echo "Complete List of Ciphers:"
echo ""
echo "$table_header"
echo "$all_ciphers_table"
} > "$output_file"

# Check if the filtered_ciphers_table string is not empty
if [ -n "$filtered_ciphers_table" ]; then
    {
    echo ""
    echo "The Following ciphers were identified as weak or insecure:"
    echo "-----------------------------------------------------------"
    echo "$table_header"
    echo "$filtered_ciphers_table"
    echo ""
    echo "*TL Assessment*" 
    echo "Weak or insecure ciphers were identified in the client hello."
    } >> "$output_file"
fi

# Notify the user
echo "${SUCCESS}Cipher analysis report has been generated: $output_file${NC}"

xdg-open "$output_file"