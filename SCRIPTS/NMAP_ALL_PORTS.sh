#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 0_RECON - NMAP [all Ports] | THIS_FILE ${fetcher.hostname} ${fetcher.comment} | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : NMAP_ALL_PORTS.sh
# | Description       : Script for scaning ports using nmap
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

# Assign the IP address to the variable
fetcher_ip=$1  # Replace with the actual IP address
#fetcher_ip="10.81.252.14"  # Replace with the actual IP address
comment=$2

mkdir ~/Documents/BOXES/$comment
cd ~/Documents/BOXES/$comment

# Run Nmap scan and save XML output
sudo nmap $fetcher_ip -p- -sV --stats-every=5s --max-parallelism 16 -T3 --min-rate=1000 -oX "nmap_all_port_scan.xml"

# Convert XML to HTML using xsltproc
xsltproc "$output_dir/nmap_all_port_scan.xml" -o "nmap_all_port_scan.html"

# Open the HTML report in Firefox
firefox "nmap_all_port_scan.html"