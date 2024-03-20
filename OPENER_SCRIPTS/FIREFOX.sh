#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                    | Execution String                  | Run in Terminal | Directory |
# | ----------------------------- | --------------------------------- | --------------- | --------- |
# | 80_HTTP - FIREFOX [HOSTNAME]  | THIS_FILE ${fetcher.hostname} 80| FALSE            |           |
# | 80_HTTP - FIREFOX [IP]        | THIS_FILE ${fetcher.ip} 80      | FALSE            |           |
# | ANY_HTTP - FIREFOX [HOSTNAME] | THIS_FILE ${fetcher.hostname} ask| TRUE            |           |
# | ANY_HTTP - FIREFOX [IP]       | THIS_FILE ${fetcher.ip} ask     | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : FIREFOX.sh
# | Description       : Script for opening firefox
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
echo "######## #### ########  ######## ########  #######  ##     ## 
##        ##  ##     ## ##       ##       ##     ##  ##   ##  
##        ##  ##     ## ##       ##       ##     ##   ## ##   
######    ##  ########  ######   ######   ##     ##    ###    
##        ##  ##   ##   ##       ##       ##     ##   ## ##   
##        ##  ##    ##  ##       ##       ##     ##  ##   ##  
##       #### ##     ## ######## ##        #######  ##     ## "
echo -e "${NC}"  # Reset colour and bold

# -----------------------------------------------------------------------------------------------------

#description
echo -e "${HEADER2}Description${NC}"

echo -e "\nFirefox openers\n"

# -----------------------------------------------------------------------------------------------------

# Variable table
echo -e "${HEADER2}Preloaded variables${NC}"  # Set title colour to blue and make it bold

## Define the variable
target=$1
port=$2

## Print the header
printf "\n%-20s | %-15s\n" "${HEADER3}Variable" "Value${NC}"
printf "%-38s\n" "--------------------------------------"

# #Print the variable and its value
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$target${NC}" "$target"

echo ""

# -----------------------------------------------------------------------------------------------------

# Example string
echo -e "${HEADER2}Example String${NC}"  # Set title colour to cyan and make it bold

echo -e "${SCRIPT_EXAMPLE}\nfirefox $target:80${NC}\n"

# -----------------------------------------------------------------------------------------------------

# Tell the user we are running the script
echo -e "${HEADER2}Script${NC}"  # Set title colour to cyan and make it bold

# -----------------------------------------------------------------------------------------------------

#fetcher_ip="10.81.252.14"  # Replace with the actual IP address

if [[ $port == "ask" ]]; then
    read -e -p "${EXPECTED_INPUT}What port Number: ${NC}" -i "80" port
fi

# firefox 

firefox $target:$port