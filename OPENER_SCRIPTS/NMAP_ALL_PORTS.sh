#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 0_RECON - NMAP [ALL PORTS] | THIS_FILE ${fetcher.ip} ${fetcher.comment}| TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : NMAP.sh
# | Description       : Script for scaning ports using nmap
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

# Directory and file variables
fetcher_ip=$1  # Get the IP from the first argument
comment=$2
mkdir -p ~/Documents/BOXES/$comment -p  # The -p flag ensures the directory is created if it doesn't exist
cd ~/Documents/BOXES/$comment || exit 1  # Exit the script if cd fails

file_name="NMAP_ALL_PORT_(${comment})"
full_path="./$file_name"  # Since we've changed directory, we can use ./ to represent the current directory

# Check if the file exists
if [ -f "$file_name.xml" ]; then
    echo "The file '$file_name.xml' already exists in the folder."

    # Ask the user if they want to perform the scan again
    read -p "Would you like to perform the scan again? (y/n): " user_input

    if [ "$user_input" == "y" ] || [ "$user_input" == "Y" ]; then
        echo "Performing a new scan."

        # nmap $fetcher_ip -p- -Pn -sV --stats-every=5s --max-retries 1000 --min-rate 50 -T2 --host-timeout 60s -oX $file_name.xml

        nmap $fetcher_ip -p- -Pn -sV --stats-every=5s -oX $file_name.xml

        # Convert XML to HTML
        xsltproc $file_name.xml -o $file_name.html
    else
        echo "Skipping the scan."
    fi

else
    echo "The file '$file_name.xml' does not exist. Performing a new scan."

    # Run Nmap scan and save XML output

    nmap $fetcher_ip -p- -Pn -sV --stats-every=5s --max-parallelism 255 -T3 --min-rate=3000 -oX $file_name.xml

    # Convert XML to HTML
    xsltproc $file_name.xml -o $file_name.html
fi

# Open the HTML report in Firefox
nohup firefox $file_name.html &> /dev/null

exit 0  # Successfully exit script