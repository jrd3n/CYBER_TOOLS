#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | MISC OPEN FOLDER      | THIS_FILE ${fetcher.comment}       | FALSE           |           |

# Script information -----------------------------------------------------------
# | Script Name       : OPEN_FOLDER.sh
# | Description       : Opens the folder in which the tests have been stored
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : March 6, 2024
# ------------------------------------------------------------------------------      :

# -----------------------------------------------------------------------------------------------------

# Directory and file variables
comment=$1

mkdir -p ~/Documents/BOXES/$comment -p  # The -p flag ensures the directory is created if it doesn't exist

dolphin ~/Documents/BOXES/$comment