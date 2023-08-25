#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 0_RECON - NMAP             | THIS_FILE ${fetcher.hostname} | TRUE            |           |

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

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Define the directory for storing scan results
output_dir="$HOME/Documents"

# Ask the user if they know the username
read -e -p "${YELLOW}How many ports do you want to scan: ${NC}" -i "100" number_of_ports

# Run Nmap scan and save XML output
sudo nmap "$fetcher_ip" --top-ports=$number_of_ports --reason -A -O -sC -sT --stats-every=5s -oX "$output_dir/nmap_${number_of_ports}_port_scan.xml"

# Convert XML to HTML using xsltproc
xsltproc "$output_dir/nmap_${number_of_ports}_port_scan.xml" -o "$output_dir/nmap_${number_of_ports}_port_scan.html"

# Open the HTML report in Firefox
firefox "$output_dir/nmap_${number_of_ports}_port_scan.html"
