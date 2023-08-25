#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 0_RECON - NMAP [all Ports] | THIS_FILE ${fetcher.hostname} | TRUE            |           |

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

# Define the directory for storing scan results
output_dir="$HOME/Documents"

# Run Nmap scan and save XML output
nmap "$fetcher_ip" -p- --reason -A -sT --stats-every=5s -oX "$output_dir/nmap_all_port_scan.xml"

# Convert XML to HTML using xsltproc
xsltproc "$output_dir/nmap_100_port_scan.xml" -o "$output_dir/nmap_100_port_scan.html"

# Open the HTML report in Firefox
firefox "$output_dir/nmap_100_port_scan.html"

nmap  ${fetcher.ip} -p- --reason -A -sT --stats-every=5s -oX nmap_scan.xml 
xsltproc nmap_scan.xml -o nmap_scan.html 
firefox nmap_scan.html