#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String                          | Run in Terminal | Directory |
# | -------------------------- | ----------------------------------------- | --------------- | --------- |
# | 0_RECON - NMAP [ALL PORTS] | THIS_FILE ${fetcher.ip} ${fetcher.comment}| TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : NMAP.sh
# | Description       : Script for scaning ports using nmap
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : March 20 2024
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

echo "███╗   ██╗███╗   ███╗ █████╗ ██████╗           ██████╗       
████╗  ██║████╗ ████║██╔══██╗██╔══██╗          ██╔══██╗      
██╔██╗ ██║██╔████╔██║███████║██████╔╝    █████╗██████╔╝█████╗
██║╚██╗██║██║╚██╔╝██║██╔══██║██╔═══╝     ╚════╝██╔═══╝ ╚════╝
██║ ╚████║██║ ╚═╝ ██║██║  ██║██║               ██║           
╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝               ╚═╝           
                                                             "

echo -e "${NC}"  # Reset colour and bold

#description
echo -e "${HEADER2}Description${NC}"
echo -e "NMAP Scan that scanns all ports, then converts to html\n"
echo -e "${NC}---------------------------------------------------------------------\n"

# -----------------------------------------------------------------------------------------------------

file_name="NMAP_ALL_PORT_(${comment})"
full_path="./$file_name"  # Since we've changed directory, we can use ./ to represent the current directory

# Check if the file exists
if [ -f "$file_name.xml" ]; then
    echo "${WARNING}The file '$file_name.xml' already exists in the folder.${NC}"

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

    nmap $fetcher_ip -p- -Pn -sV --stats-every=5s --max-parallelism 255 -T3 --min-rate=3000 -oA $file_name

    # Convert XML to HTML
    xsltproc $file_name.xml -o $file_name.html
fi

# Open the HTML report in Firefox
nohup firefox $file_name.html &> /dev/null

exit 0  # Successfully exit script