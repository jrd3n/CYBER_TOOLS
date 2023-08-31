#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 80_HTTP - GOBUSTER [HOSTNAME]       | THIS_FILE ${fetcher.hostname}       | TRUE            |           |
# | 80_HTTP - GOBUSTER [IP]             | THIS_FILE ${fetcher.ip}       | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : GOBUSTER.sh
# | Description       : Script for brute force hydra
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------      :

address=$1

# Ask the user for the level of attack
read -e -p "${YELLOW}Which port number: ${NC}" -i "80" port

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Define username and password lists
dir_list_1="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/directory_scanner/most_common.txt"
dir_list_2="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/directory_scanner/common.txt"
dir_list_3="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/directory_scanner/big.txt"
dir_list_4="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/directory_scanner/directory_list_2.3_medium.txt"

# Ask the user for the level of attack
read -e -p "${YELLOW}Choose the level of attack (1/2/3/4): ${NC}" -i "1" attack_level

case $attack_level in
    1)
        dir_list=$dir_list_1
        ;;
    2)
        dir_list=$dir_list_2
        ;;
    3)
        dir_list=$dir_list_3
        ;;
    4)
        dir_list=$dir_list_4
        ;;
    *)
        echo "Invalid attack level. Defaulting to level 1."
        dir_list=$user_name_list_1
        ;;
esac

gobuster dir -r -e -w $dir_list -u http://$address:$port

echo -e "${RED}gobuster attack finished.${NC}"