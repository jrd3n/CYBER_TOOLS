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
echo "######## ######## ########  
##          ##    ##     ## 
##          ##    ##     ## 
######      ##    ########  
##          ##    ##        
##          ##    ##        
##          ##    ##        "
echo -e "${NC}"  # Reset colour and bold

# -----------------------------------------------------------------------------------------------------

#description
echo -e "${HEADER2}Description${NC}"

echo -e "\nThis is a quick opener to open ftp\n"

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

echo -e "${SCRIPT_EXAMPLE}\nftp anonymous@$ip${NC}\n"

# -----------------------------------------------------------------------------------------------------

# Tell the user we are running the script
echo -e "${HEADER2}Script${NC}"  # Set title colour to cyan and make it bold

# -----------------------------------------------------------------------------------------------------

comment=$2

mkdir ~/Documents/BOXES/$comment -p
cd ~/Documents/BOXES/$comment

# Ask the user if they know the username
read -e -p "${EXPECTED_INPUT}What username? : ${NC}" -i "anonymous" username

# Tell the user we are running the script
echo -e "${HEADER2}Script used${NC}"  # Set title colour to cyan and make it bold

echo -e "\n${SCRIPT_EXAMPLE}ftp $username@$ip${NC}"

ftp $username@$ip