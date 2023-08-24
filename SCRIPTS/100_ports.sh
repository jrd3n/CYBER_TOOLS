#!/bin/bash

# Angry IP openers lines (do not change the following 6 lines)
#   Name                :MISC_NMAP_100_PORTS
#   Execution_string    :THIS_FILE ${fetcher.ip}
#   Run_in_Terminal     :TRUE
#   Directory           :

# Assign the IP address to the variable
#fetcher_ip=$1  # Replace with the actual IP address
fetcher_ip="10.81.252.14"  # Replace with the actual IP address

# Define the directory for storing scan results
output_dir="$HOME/Documents"

# Run Nmap scan and save XML output
nmap "$fetcher_ip" --top-ports=100 --reason -A -sT --stats-every=5s -oX "$output_dir/nmap_100_port_scan.xml"

# Convert XML to HTML using xsltproc
xsltproc "$output_dir/nmap_100_port_scan.xml" -o "$output_dir/nmap_100_port_scan.html"

# Open the HTML report in Firefox
firefox "$output_dir/nmap_100_port_scan.html"
