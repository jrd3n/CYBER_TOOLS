#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 9999_MISC - METASPLOIT | THIS_FILE ${fetcher.ip}  | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : METASPLOIT.sh
# | Description       : Script for brute force hydra
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 29, 2023
# ------------------------------------------------------------------------------      :

address=$1

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

msfconsole -x set rhost $address
# ...

# echo -e "${RED}Hydra attack finished.${NC}"