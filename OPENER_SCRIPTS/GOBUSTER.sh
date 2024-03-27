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

# -----------------------------------------------------------------------------------------------------

# Define colour variables
HEADER1=$(tput setaf 5; tput bold)
HEADER2=$(tput setaf 4; tput bold)
HEADER3=$(tput setaf 2; tput bold)
IMPORTANT_INFO=$(tput setaf 1; tput bold)
EXPECTED_INPUT=$(tput setaf 3; tput setab 0; tput bold)
GENERAL_INFO=$(tput setaf 6)
SUCCESS=$(tput setaf 2)
WARNING=$(tput setaf 3)
ERROR=$(tput setaf 1)
SCRIPT_EXAMPLE=$(tput setaf 7; tput setab 2)
NC=$(tput sgr0) # No Colour

# -----------------------------------------------------------------------------------------------------

# Tool name https://manytools.org/hacker-tools/ascii-banner/ font banner3
echo -e "${HEADER1}"  # Set colour to green and make it bold
echo " ######    #######  ########  ##     ##  ######  ######## ######## ########  
##    ##  ##     ## ##     ## ##     ## ##    ##    ##    ##       ##     ## 
##        ##     ## ##     ## ##     ## ##          ##    ##       ##     ## 
##   #### ##     ## ########  ##     ##  ######     ##    ######   ########  
##    ##  ##     ## ##     ## ##     ##       ##    ##    ##       ##   ##   
##    ##  ##     ## ##     ## ##     ## ##    ##    ##    ##       ##    ##  
 ######    #######  ########   #######   ######     ##    ######## ##     ## "
echo -e "${NC}"  # Reset colour and bold

# -----------------------------------------------------------------------------------------------------

#description
echo -e "${HEADER2}Description${NC}"

echo -e "\nGOBUSTER opener.\n"

# -----------------------------------------------------------------------------------------------------

# Variable table
echo -e "${HEADER2}Preloaded variables${NC}"  # Set title colour to blue and make it bold

## Define the variable
ip=$1
# Define username and password lists
dir_list_1=$HOME/WORDLISTS/discovery/most_common.txt 
dir_list_2=$HOME/WORDLISTS/discovery/common.txt
dir_list_3=$HOME/WORDLISTS/discovery/big.txt
dir_list_4=$HOME/WORDLISTS/discovery/directory_list_2.3_medium.txt
## Print the header
printf "\n%-20s | %-15s\n" "${HEADER3}Variable" "Value${NC}"
printf "%-38s\n" "--------------------------------------"

# #Print the variable and its value
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$ip${NC}" "$ip"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$dir_list_1${NC}" "$dir_list_1"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$dir_list_2${NC}" "$dir_list_2"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$dir_list_3${NC}" "$dir_list_3"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$dir_list_4${NC}" "$dir_list_4"

echo ""

# -----------------------------------------------------------------------------------------------------

# Example string
echo -e "${HEADER2}Example String${NC}"  # Set title colour to cyan and make it bold

echo -e "${SCRIPT_EXAMPLE}\ngobuster dir -r -e -w \$dir_list_1 -u http://$ip:80${NC}\n"

# -----------------------------------------------------------------------------------------------------

# Tell the user we are running the script
echo -e "${HEADER2}Script${NC}"  # Set title colour to cyan and make it bold

# -----------------------------------------------------------------------------------------------------

# Ask the user for the level of attack
read -e -p "${EXPECTED_INPUT}Which port number: ${NC}" -i "80" port

# Ask the user for the level of attack
read -e -p "${EXPECTED_INPUT}Choose the level of attack (1/2/3/4): ${NC}" -i "1" attack_level

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
        dir_list=$dir_list_1
        ;;
esac

# Tell the user we are running the script
echo -e "${HEADER2}Script used${NC}"  # Set title colour to cyan and make it bold

echo -e "\ngobuster dir -r -e -w $dir_list -u http://$ip:$port${NC}"

gobuster dir -r -e -w $dir_list -u http://$ip:$port