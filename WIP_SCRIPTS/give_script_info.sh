#!/bin/bash

# Tool name
echo -e "\e[1m\e[34m"  # Set colour to green and make it bold
echo "::::::::::: ::::::::   ::::::::  :::        
    :+:    :+:    :+: :+:    :+: :+:        
    +:+    +:+    +:+ +:+    +:+ +:+        
    +#+    +#+    +:+ +#+    +:+ +#+        
    +#+    +#+    +#+ +#+    +#+ +#+        
    #+#    #+#    #+# #+#    #+# #+#        
    ###     ########   ########  ##########"
echo -e "\e[0m"  # Reset colour and bold

# Variable table
echo -e "\e[1m\e[34mPreloaded variables\e[0m"  # Set title colour to blue and make it bold

# Define the variable
ip="192.168.1.1"

# Print the header
printf "\n%-20s | %-15s\n" "Variable" "Value"
printf "%-38s\n" "--------------------------------------"

# Print the variable and its value
printf "%-20s | %-15s\n" "\$ip" "$ip"

echo ""

# Example string
echo -e "\e[1m\e[34mExample String\e[0m"  # Set title colour to cyan and make it bold
