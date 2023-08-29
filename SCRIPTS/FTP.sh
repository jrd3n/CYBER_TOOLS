#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 21_FTP - FTP | THIS_FILE ${fetcher.ip} ${fetcher.comment} | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : FTP.sh
# | Description       : Script for opening ssh
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

# Assign the IP address to the variable
fetcher_ip=$1  # Replace with the actual IP address
comment=$2

mkdir ~/Documents/BOXES/$comment
cd ~/Documents/BOXES/$comment

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Ask the user if they know the username
# read -e -p "${YELLOW}What username? : ${NC}" -i "root" username

ftp $fetcher_ip