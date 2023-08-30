#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 80_HTTP - FIREFOX [HOSTNAME] | THIS_FILE ${fetcher.hostname} 80| FALSE            |           |
# | 80_HTTP - FIREFOX [IP]       | THIS_FILE ${fetcher.ip} 80     | FALSE            |           |
# | ANY_HTTP - FIREFOX [HOSTNAME] | THIS_FILE ${fetcher.hostname} ask| TRUE            |           |
# | ANY_HTTP - FIREFOX [IP]       | THIS_FILE ${fetcher.ip} ask     | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : FIREFOX.sh
# | Description       : Script for opening firefox
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

# Assign the IP address to the variable
fetcher_ip=$1  # Replace with the actual IP address
port=$2
#fetcher_ip="10.81.252.14"  # Replace with the actual IP address

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

if [[ $port == "ask" ]]; then
    read -e -p "${YELLOW}What port Number: ${NC}" -i "" port
fi

# firefox 

firefox $fetcher_ip:$port