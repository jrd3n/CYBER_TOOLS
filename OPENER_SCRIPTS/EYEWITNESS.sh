#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 0_ALL - EyeWitness         | THIS_FILE ${fetcher.ip} ${fetcher.comment}| TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : EYEWITNESS.sh
# | Description       : Script for scaning ports using nmap
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : Apr 29 2024
# ------------------------------------------------------------------------------

# Load Variables

fetcher_ip=$1  # Get the IP from the first argument
comment=$2

# Load colours
source ~/CYBER_TOOLS/OPENER_SCRIPTS/SUB_SCRIPTS/COLOURS.sh
source ~/CYBER_TOOLS/OPENER_SCRIPTS/SUB_SCRIPTS/FOLDER.sh

# Display Header

# Tool name https://manytools.org/hacker-tools/ascii-banner/ font banner3
echo -e "${HEADER1}"  # Set colour to green and make it bold

echo "######## ##    ## ######## ##      ## #### ######## ##    ## ########  ######   ######  
##        ##  ##  ##       ##  ##  ##  ##     ##    ###   ## ##       ##    ## ##    ## 
##         ####   ##       ##  ##  ##  ##     ##    ####  ## ##       ##       ##       
######      ##    ######   ##  ##  ##  ##     ##    ## ## ## ######    ######   ######  
##          ##    ##       ##  ##  ##  ##     ##    ##  #### ##             ##       ## 
##          ##    ##       ##  ##  ##  ##     ##    ##   ### ##       ##    ## ##    ## 
########    ##    ########  ###  ###  ####    ##    ##    ## ########  ######   ######  "

echo -e "${NC}"  # Reset colour and bold

#description
# echo -e "${HEADER2}Description${NC}"
# echo -e "NMAP Scan that uses the output from the all port scan and performs a deep scan into the ports.\n"
# echo -e "${NC}---------------------------------------------------------------------\n"

# -----------------------------------------------------------------------------------------------------

file_name="NMAP_ALL_PORT_(${comment})"
full_path="./$file_name"  # Since we've changed directory, we can use ./ to represent the current directory

# Check if the file exists
if [ -f "$file_name.gnmap" ]; then

    echo "$file_name.gnmap found!"

    else

    clear

    echo "${WARNING}The file '$file_name.gnmap' does not exist, running the all port scan${NC}"

    source ~/CYBER_TOOLS/OPENER_SCRIPTS/NMAP_ALL_PORTS.sh

    clear

fi
# -----------------------------------------------------------------------------------------------------

eyewitness --web -x $file_name.xml -d eyewitness