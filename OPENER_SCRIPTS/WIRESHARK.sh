#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                  | Execution String                   | Run in Terminal | Directory |
# | --------------------------  | ---------------------------------- | --------------- | --------- |
# | 0_RECON - WIRESHARK [HELLO] | THIS_FILE ${fetcher.comment} HELLO | TRUE            |           |
# | 0_RECON - WIRESHARK [UPDATE]| THIS_FILE ${fetcher.comment} HELLO | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : WIRESHARK.sh
# | Description       : Creates a wireshark capture and saves it in the correct DIR
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : March 8, 2024
# ------------------------------------------------------------------------------      :

# -----------------------------------------------------------------------------------------------------

# Directory and file variables
comment=$1
FILE_SUFFIX=$2

mkdir -p ~/Documents/BOXES/$comment -p  # The -p flag ensures the directory is created if it doesn't exist

cd ~/Documents/BOXES/$comment

# sudo wireshark -w "WIRESHARK_FILE_$SUFFIX.pcap"

sudo wireshark

# I would like to save the file with a specific file name
# i would like to chown the file to $USER