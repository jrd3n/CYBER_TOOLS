#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                    | Execution String                  | Run in Terminal | Directory |
# | ----------------------------- | --------------------------------- | --------------- | --------- |
# | 80_HTTP - FIREFOX [HOSTNAME]  | THIS_FILE ${fetcher.hostname} 80  | FALSE           |           |
# | 80_HTTP - FIREFOX [IP]        | THIS_FILE ${fetcher.ip} 80        | FALSE           |           |
# | 443_HTTPS - FIREFOX [HOSTNAME]| THIS_FILE ${fetcher.hostname} 443 | FALSE           |           |
# | 443_HTTPS - FIREFOX [IP]      | THIS_FILE ${fetcher.ip} 443       | FALSE           |           |
# | 5000_HTTP - FIREFOX [HOSTNAME]| THIS_FILE ${fetcher.hostname} 5000| FALSE           |           |
# | 5000_HTTP - FIREFOX [IP]      | THIS_FILE ${fetcher.ip} 5000      | FALSE           |           |
# | 8000_HTTP - FIREFOX [HOSTNAME]| THIS_FILE ${fetcher.hostname} 8000| FALSE           |           |
# | 8000_HTTP - FIREFOX [IP]      | THIS_FILE ${fetcher.ip} 8000      | FALSE           |           |
# | 0_HTTP - FIREFOX [HOSTNAME] | THIS_FILE ${fetcher.hostname} ask | TRUE            |           |
# | 0_HTTP - FIREFOX [IP]       | THIS_FILE ${fetcher.ip} ask       | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : FIREFOX.sh
# | Description       : Script for opening firefox
# | Directory         : ~/CYBER_TOOLS/OPENER_SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

# Load Variables

fetcher_ip=$1  # Get the IP from the first argument
port=$2

# Load colours
source ~/CYBER_TOOLS/OPENER_SCRIPTS/SUB_SCRIPTS/COLOURS.sh
# source ~/CYBER_TOOLS/OPENER_SCRIPTS/SUB_SCRIPTS/FOLDER.sh

# Display Header

# Tool name https://manytools.org/hacker-tools/ascii-banner/ font ANSI SHADDOW
echo -e "${HEADER1}"  # Set colour to green and make it bold

echo "███████╗██╗██████╗ ███████╗███████╗ ██████╗ ██╗  ██╗
██╔════╝██║██╔══██╗██╔════╝██╔════╝██╔═══██╗╚██╗██╔╝
█████╗  ██║██████╔╝█████╗  █████╗  ██║   ██║ ╚███╔╝ 
██╔══╝  ██║██╔══██╗██╔══╝  ██╔══╝  ██║   ██║ ██╔██╗ 
██║     ██║██║  ██║███████╗██║     ╚██████╔╝██╔╝ ██╗
╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝
                                                    "

echo -e "${NC}"  # Reset colour and bold

#description
echo -e "${HEADER2}Description${NC}"
echo -e "An opener for firefox.\n"
echo -e "${NC}---------------------------------------------------------------------\n"


# -----------------------------------------------------------------------------------------------------

if [[ $port == "ask" ]]; then
    read -e -p "${EXPECTED_INPUT}What port Number: ${NC}" -i "80" port
fi

# firefox

firefox $fetcher_ip:$port