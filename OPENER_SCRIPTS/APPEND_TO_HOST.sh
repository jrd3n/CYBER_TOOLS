#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | MISC - APPEND_TO_HOST      | THIS_FILE ${fetcher.ip}       | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : APPEND_TO_HOST.sh
# | Description       : Script for appending this to the host list
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

# Load Variables

fetcher_ip=$1  # Get the IP from the first argument
# comment=$2

# Load colours
source ~/CYBER_TOOLS/OPENER_SCRIPTS/SUB_SCRIPTS/COLOURS.sh
# source ~/CYBER_TOOLS/OPENER_SCRIPTS/SUB_SCRIPTS/FOLDER.sh

# Display Header

# Tool name https://manytools.org/hacker-tools/ascii-banner/ font ANSI SHADDOW
echo -e "${HEADER1}"  # Set colour to green and make it bold

echo "    ██╗███████╗████████╗ ██████╗    ██╗██╗  ██╗ ██████╗ ███████╗████████╗███████╗
   ██╔╝██╔════╝╚══██╔══╝██╔════╝   ██╔╝██║  ██║██╔═══██╗██╔════╝╚══██╔══╝██╔════╝
  ██╔╝ █████╗     ██║   ██║       ██╔╝ ███████║██║   ██║███████╗   ██║   ███████╗
 ██╔╝  ██╔══╝     ██║   ██║      ██╔╝  ██╔══██║██║   ██║╚════██║   ██║   ╚════██║
██╔╝   ███████╗   ██║   ╚██████╗██╔╝   ██║  ██║╚██████╔╝███████║   ██║   ███████║
╚═╝    ╚══════╝   ╚═╝    ╚═════╝╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝
                                                                                 "

echo -e "${NC}"  # Reset colour and bold

#description
echo -e "${HEADER2}Description${NC}"
echo -e "A script to quickly add the host name to /etc/hosts.\n"
echo -e "${NC}---------------------------------------------------------------------\n"

# -----------------------------------------------------------------------------------------------------

# Ask the user for the level of attack
read -e -p "${EXPECTED_INPUT}What would you like the hostname to be: ${NC}" fetcher_comment

echo $fetcher_ip $fetcher_comment | sudo tee -a /etc/hosts

sudo nano /etc/hosts