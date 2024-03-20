#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String                           | Run in Terminal | Directory |
# | -------------------------- | ------------------------------------------ | --------------- | --------- |
# | 9999_MISC - METASPLOIT     | THIS_FILE ${fetcher.ip} ${fetcher.comment} | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : METASPLOIT.sh
# | Description       : Script for brute force hydra
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 29, 2023
# ------------------------------------------------------------------------------      :

# Assign the IP address to the variable
fetcher_ip=$1  # Replace with the actual IP address
comment=$2

# Define colour variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Colour

# Create and change directory
mkdir -p ~/Documents/BOXES/$comment
cd ~/Documents/BOXES/$comment || { echo "${RED}Failed to change directory.${NC}"; exit 1; }

# Define file name
file_name="nmap_all_port_scan.xml"
full_path="~/Documents/BOXES/$comment/$file_name"

# Run the NMAP script
echo "${YELLOW}Running NMAP scan...${NC}"
~/CYBER_TOOLS/SCRIPTS/NMAP_ALL_PORTS.sh $fetcher_ip $comment

# Import to Metasploit
echo "${YELLOW}Importing scan result to Metasploit...${NC}"
msfconsole -x "db_import $full_path; set rhost $fetcher_ip; services"

echo "${GREEN}Process completed.${NC}"

exit 0