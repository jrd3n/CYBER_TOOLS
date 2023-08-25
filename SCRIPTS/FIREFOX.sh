#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 80_HTTP - FIREFOX [HOSTNAME] | THIS_FILE ${fetcher.hostname} 80| FALSE            |           |
# | 80_HTTP - FIREFOX [IP]       | THIS_FILE ${fetcher.IP} 80     | FALSE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : FIREFOX.sh
# | Description       : Script for opening firefox
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : August 24, 2023
# ------------------------------------------------------------------------------

# Assign the IP address to the variable
fetcher_ip=$1  # Replace with the actual IP address
port=$2
#fetcher_ip="10.81.252.14"  # Replace with the actual IP address

firefox $fetcher_ip:$port