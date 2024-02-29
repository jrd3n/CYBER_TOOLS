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
echo "      ## ######## ########  ######        ## ##     ##  #######   ######  ########  ######  
     ##  ##          ##    ##    ##      ##  ##     ## ##     ## ##    ##    ##    ##    ## 
    ##   ##          ##    ##           ##   ##     ## ##     ## ##          ##    ##       
   ##    ######      ##    ##          ##    ######### ##     ##  ######     ##     ######  
  ##     ##          ##    ##         ##     ##     ## ##     ##       ##    ##          ## 
 ##      ##          ##    ##    ##  ##      ##     ## ##     ## ##    ##    ##    ##    ## 
##       ########    ##     ######  ##       ##     ##  #######   ######     ##     ######  "
echo -e "${NC}"  # Reset colour and bold

# -----------------------------------------------------------------------------------------------------

#description
echo -e "${HEADER2}Description${NC}"

echo -e "\nA script to quickly add the host name to /etc/hosts.\n"

# -----------------------------------------------------------------------------------------------------

# Variable table
echo -e "${HEADER2}Preloaded variables${NC}"  # Set title colour to blue and make it bold

## Define the variable
ip=$1

## Print the header
printf "\n%-20s | %-15s\n" "${HEADER3}Variable" "Value${NC}"
printf "%-38s\n" "--------------------------------------"

# #Print the variable and its value
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$ip${NC}" "$ip"

echo ""

# -----------------------------------------------------------------------------------------------------

# Example string
echo -e "${HEADER2}Example String${NC}"  # Set title colour to cyan and make it bold

echo -e "${SCRIPT_EXAMPLE}\necho $ip host_name | sudo tee -a /etc/hosts${NC}\n"

# -----------------------------------------------------------------------------------------------------

# Tell the user we are running the script
echo -e "${HEADER2}Script${NC}"  # Set title colour to cyan and make it bold

# -----------------------------------------------------------------------------------------------------

# Ask the user for the level of attack
read -e -p "${EXPECTED_INPUT}What would you like the hostname to be: ${NC}" fetcher_comment

echo $ip $fetcher_comment | sudo tee -a /etc/hosts

sudo nano /etc/hosts