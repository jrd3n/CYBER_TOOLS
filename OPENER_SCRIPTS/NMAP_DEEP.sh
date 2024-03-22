#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 0_ALL - NMAP [DEEP]        | THIS_FILE ${fetcher.ip} ${fetcher.comment}| TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : NMAP.sh
# | Description       : Script for scaning ports using nmap
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : Sept 1, 2023
# ------------------------------------------------------------------------------

# Load Variables

fetcher_ip=$1  # Get the IP from the first argument
comment=$2

# Load colours
source ~/CYBER_TOOLS/OPENER_SCRIPTS/SUB_SCRIPTS/COLOURS.sh
source ~/CYBER_TOOLS/OPENER_SCRIPTS/SUB_SCRIPTS/FOLDER.sh

# Display Header

# Tool name https://manytools.org/hacker-tools/ascii-banner/ font banner3
echo -e "${HEADER1}"  # Set colour to green and make it bold

echo "███╗   ██╗███╗   ███╗ █████╗ ██████╗     ██████╗ ███████╗███████╗██████╗ 
████╗  ██║████╗ ████║██╔══██╗██╔══██╗    ██╔══██╗██╔════╝██╔════╝██╔══██╗
██╔██╗ ██║██╔████╔██║███████║██████╔╝    ██║  ██║█████╗  █████╗  ██████╔╝
██║╚██╗██║██║╚██╔╝██║██╔══██║██╔═══╝     ██║  ██║██╔══╝  ██╔══╝  ██╔═══╝ 
██║ ╚████║██║ ╚═╝ ██║██║  ██║██║         ██████╔╝███████╗███████╗██║     
╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝         ╚═════╝ ╚══════╝╚══════╝╚═╝     
                                                                         "

echo -e "${NC}"  # Reset colour and bold

#description
echo -e "${HEADER2}Description${NC}"
echo -e "NMAP Scan that uses the output from the all port scan and performs a deep scan into the ports.\n"
echo -e "${NC}---------------------------------------------------------------------\n"

# -----------------------------------------------------------------------------------------------------

file_name="NMAP_ALL_PORT_(${comment})"
full_path="./$file_name"  # Since we've changed directory, we can use ./ to represent the current directory

# Check if the file exists
if [ -f "$file_name.gnmap" ]; then

    echo "$file_name.gnmap found!"

    else

    clear

    echo "${WARNING}The file '$file_name.gnmap' does not exist, running the all port scan${NC}"

    source ~/CYBER_TOOLS/OPENER_SCRIPTS/NMAP_ALL_PORTS.sh

fi
# -----------------------------------------------------------------------------------------------------

# Extract and list open port numbers
open_ports=($(grep -oP '(\d+)\/open' $file_name.gnmap | cut -d'/' -f1))

function nmap_scan_function() {

    sudo nmap $1 -p "$2" $3 -oA "$dir/$2/$4" -v

    # -----------------------------------------------------------------------------------------------------

    if [ $? -eq 0 ]; then
    # Extract and loop through open port numbers
    xsltproc "$dir/$2/$4.xml" -o "$dir/$2/$4.html"
    fi

}

if [ ${#open_ports[@]} -eq 0 ]; then
    echo -e "${ERROR}No open ports found.${NC}"
else
    for port in "${open_ports[@]}"; do

        echo -e "\n${SUCCESS}Scanning port $port${NC}\n"

        mkdir -p "$dir/$port"

        nmap_scan_function "$ip" "$port" "-Pn -A --script banner,version,discovery,auth,fuzzer,vuln,ssl-enum-ciphers --reason" "nmap_aggressive_($comment)"

    done

fi

dolphin ./