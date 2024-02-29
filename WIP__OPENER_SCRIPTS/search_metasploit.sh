#!/bin/bash

# Link to banner tool https://manytools.org/hacker-tools/ascii-banner/

echo "::::::::::: ::::::::   ::::::::  :::        
    :+:    :+:    :+: :+:    :+: :+:        
    +:+    +:+    +:+ +:+    +:+ +:+        
    +#+    +#+    +:+ +#+    +:+ +#+        
    +#+    +#+    +#+ +#+    +#+ +#+        
    #+#    #+#    #+# #+#    #+# #+#        
    ###     ########   ########  ########## "

# Check if the search term is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <search_term>"
  exit 1
fi

# Search for the exploit using msfconsole
# exploit_info=$(msfconsole -x "search $1; exit" | grep 'exploit/' | awk '{print $1}')

exploit_info=$(msfconsole -x "search $1")

# Check if any exploit found
if [ -z "$exploit_info" ]; then
  echo "No exploits found for the search term '$1'."
else
  echo "Exploits found:"
  echo "$exploit_info"
fi
