#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 9999_MISC - APPEND_TO_HOST | THIS_FILE ${fetcher.ip}       | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : APPEND_TO_HOST.sh
# | Description       : Script for appending this to the host list
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

# Assign the IP address to the variable
fetcher_ip=$1  # Replace with the actual IP address

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Ask the user for the level of attack
read -e -p "${YELLOW}What would you like the hostname to be: ${NC}" fetcher_comment

echo $fetcher_ip $fetcher_comment | sudo tee -a /etc/hosts
sudo nano /etc/hosts