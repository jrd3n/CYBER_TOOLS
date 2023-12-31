#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 0_RECON - NMAP             | THIS_FILE ${fetcher.hostname} ${fetcher.comment}| TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : NMAP.sh
# | Description       : Script for scaning ports using nmap
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

# Assign the IP address to the variable
fetcher_ip=$1  # Replace with the actual IP address
#fetcher_ip="10.81.252.14"  # Replace with the actual IP address
comment=$2

mkdir ~/Documents/BOXES/$comment -p
cd ~/Documents/BOXES/$comment

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Ask the user if they know the username
read -e -p "${YELLOW}How many ports do you want to scan: ${NC}" -i "100" number_of_ports

# Run Nmap scan and save XML output
sudo nmap "$fetcher_ip" -v --top-ports=$number_of_ports --reason -Pn -A --script vuln,version,fuzzer,malware,auth,discovery -oX "nmap_${number_of_ports}_port_scan.xml"

# Convert XML to HTML using xsltproc
xsltproc "nmap_${number_of_ports}_port_scan.xml" -o "nmap_${number_of_ports}_port_scan.html"

# Open the HTML report in Firefox
# firefox  & disown && exit
# firefox $fetcher_ip:$port & disown && exit

nohup firefox "nmap_${number_of_ports}_port_scan.html" &> /dev/null

# bash -c "firefox "nmap_${number_of_ports}_port_scan.html" &> /dev/null &"; exit