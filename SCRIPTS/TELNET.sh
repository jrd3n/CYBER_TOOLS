#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 23_TELNET - TELNET | THIS_FILE ${fetcher.ip} 23 | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : TELNET.sh
# | Description       : Script for opening ssh
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

# Assign the IP address to the variable
fetcher_ip=$1  # Replace with the actual IP address
port=$2

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Ask the user if they know the username
# read -e -p "${YELLOW}What username? : ${NC}" -i "root" username

telnet $fetcher_ip $port