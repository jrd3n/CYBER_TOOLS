#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 0_RECON - NMAP_DEEP             | THIS_FILE ${fetcher.ip} ${fetcher.comment}| TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : NMAP.sh
# | Description       : Script for scaning ports using nmap
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : Sept 1, 2023
# ------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------

# Define colour variables
HEADER1=$(tput setaf 5; tput bold)
HEADER2=$(tput setaf 4; tput bold)
HEADER3=$(tput setaf 2; tput bold)
IMPORTANT_INFO=$(tput setaf 1; tput bold)
EXPECTED_INPUT=$(tput setaf 3; tput setab 0; tput bold)
GENERAL_INFO=$(tput setaf 6)
SUCCESS=$(tput setaf 2)
WARNING=$(tput setaf 3)
ERROR=$(tput setaf 1)
SCRIPT_EXAMPLE=$(tput setaf 7; tput setab 2)
NC=$(tput sgr0) # No Colour

# -----------------------------------------------------------------------------------------------------

# Tool name https://manytools.org/hacker-tools/ascii-banner/ font banner3
echo -e "${HEADER1}"  # Set colour to green and make it bold
echo "##    ## ##     ##    ###    ########     ########  ######## ######## ########  
###   ## ###   ###   ## ##   ##     ##    ##     ## ##       ##       ##     ## 
####  ## #### ####  ##   ##  ##     ##    ##     ## ##       ##       ##     ## 
## ## ## ## ### ## ##     ## ########     ##     ## ######   ######   ########  
##  #### ##     ## ######### ##           ##     ## ##       ##       ##        
##   ### ##     ## ##     ## ##           ##     ## ##       ##       ##        
##    ## ##     ## ##     ## ##           ########  ######## ######## ##        "
echo -e "${NC}"  # Reset colour and bold

# -----------------------------------------------------------------------------------------------------

#description
echo -e "${HEADER2}Description${NC}"

echo -e "\nThis is a deep nmap scan that uses scripts\n"

# -----------------------------------------------------------------------------------------------------

# Variable table
echo -e "${HEADER2}Preloaded variables${NC}"  # Set title colour to blue and make it bold

# Assign the IP address to the variable
ip=$1  # Replace with the actual IP address
#fetcher_ip="10.81.252.14"  # Replace with the actual IP address
comment=$2

dir=~/Documents/BOXES/$comment

mkdir $dir -p
cd $dir

## Print the header
printf "\n%-20s | %-15s\n" "${HEADER3}Variable" "Value${NC}"
printf "%-38s\n" "--------------------------------------"

# #Print the variable and its value
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$ip${NC}" "$ip"

echo ""

# Tell the user we are running the script
echo -e "${HEADER2}Script${NC}"  # Set title colour to cyan and make it bold

# -----------------------------------------------------------------------------------------------------

while true; do
    # Function to perform Nmap scan

    # -----------------------------------------------------------------------------------------------------

    # Example string
    echo -e "${HEADER2}Example String${NC}"  # Set title colour to cyan and make it bold

    echo -e "${SCRIPT_EXAMPLE}\nsudo nmap -p- -O -Pn -oA nmap_all $ip -v${NC}\n"

    sudo nmap -p- -O -Pn -oA nmap_all $ip -v

# -----------------------------------------------------------------------------------------------------

    # Check if the scan was successful
    if [ $? -eq 0 ]; then
        echo "Nmap scan completed successfully. Output saved to nmap_all.gnmap"
        # Extract and loop through open port numbers
        break  # Exit the loop since the scan was successful
    else
        echo -e "${ERROR}Nmap scan failed.${NC}"
        read -p -e "${EXPECTED_INPUT}Do you want to rescan? (y/n): ${NC}" -i "y" rescan_choice
        if [ "$rescan_choice" == "n" ]; then
            echo "Exiting."
            exit
        fi
    fi
done

xsltproc "$dir/nmap_all.xml" -o "$dir/nmap_all.html"

# Extract and list open port numbers
open_ports=($(grep -oP '(\d+)\/open' $dir/nmap_all.gnmap | cut -d'/' -f1))

function nmap_scan_function() {

    # -----------------------------------------------------------------------------------------------------

    # Example string
    echo -e "${HEADER2}Example String${NC}"  # Set title colour to cyan and make it bold

    echo -e "${SCRIPT_EXAMPLE}\nsudo nmap "$1" -p "$2" $3 -oX "$dir/$2/nmap/xmls/$4.xml" -v${NC}\n"

    sudo nmap "$1" -p "$2" $3 -oX "$dir/$2/nmap/xmls/$4.xml" -v

    # -----------------------------------------------------------------------------------------------------

    if [ $? -eq 0 ]; then
    # Extract and loop through open port numbers
    xsltproc "$dir/$2/nmap/xmls/$4.xml" -o "$dir/$2/nmap/$4.html"
    fi

}

if [ ${#open_ports[@]} -eq 0 ]; then
    echo -e "${ERROR}No open ports found.${NC}"
else
    for port in "${open_ports[@]}"; do

        mkdir -p "$dir/$port"

        mkdir -p "$dir/$port/nmap"

        mkdir -p "$dir/$port/nmap/xmls"

        nmap_scan_function "$ip" "$port" "-Pn -A --script banner,version,discovery,auth,fuzzer,vuln --reason" "nmap_aggressive_disco_scripts"

    done

    echo "ALL SCANS COMPLETE"
fi

# for port in "${open_ports[@]}"; do

#     # nmap_scan_function "$target" "$port" "-Pn --script brute --reason" "nmap_brute_scripts"

#     echo ""

# done

# for port in "${open_ports[@]}"; do

#     nmap_scan_function "$target" "$port" "-Pn --script vuln --reason" "nmap_vuln_scripts"

# done

exit