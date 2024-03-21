#!/bin/bash

# Angry IP information -----------------------------------------------------------
# | Angry Name                 | Execution String              | Run in Terminal | Directory |
# | -------------------------- | ----------------------------- | --------------- | --------- |
# | 0_RECON - NMAP A_1_2       | THIS_FILE ${fetcher.hostname} ${fetcher.mac}| TRUE            |           |

# Script information -----------------------------------------------------------
# | Script Name       : SCRIPTS/A_1_2_Scan.sh
# | Description       : Script for scaning ports using nmap
# | Directory         : ~/CYBER_TOOLS/SCRIPTS/
# | Author            : Jordon Archer
# | Date              : Feb 5 2024
# ------------------------------------------------------------------------------

# Define color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # No Color
    echo -e  "\n███╗   ██╗███╗   ███╗ █████╗ ██████╗      █████╗    ██╗   ██████╗     ███████╗ ██████╗ █████╗ ███╗   ██╗
████╗  ██║████╗ ████║██╔══██╗██╔══██╗    ██╔══██╗  ███║   ╚════██╗    ██╔════╝██╔════╝██╔══██╗████╗  ██║
██╔██╗ ██║██╔████╔██║███████║██████╔╝    ███████║  ╚██║    █████╔╝    ███████╗██║     ███████║██╔██╗ ██║
██║╚██╗██║██║╚██╔╝██║██╔══██║██╔═══╝     ██╔══██║   ██║   ██╔═══╝     ╚════██║██║     ██╔══██║██║╚██╗██║
██║ ╚████║██║ ╚═╝ ██║██║  ██║██║         ██║  ██║██╗██║██╗███████╗    ███████║╚██████╗██║  ██║██║ ╚████║
╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝         ╚═╝  ╚═╝╚═╝╚═╝╚═╝╚══════╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝\n"

## Create with human readable names

    IP_add=$1 # Ip address
    Description=$2 # Devices description ie 'Camera_10198234759'

    Description=$(echo $Description | tr -d ':')

    #   echo $Description

## Mount Fileserver so that results can be moved

    FileDir=~/Documents/NMAP_RESULTS

    #echo -e "\nMounting the Hemel file server"

    #sudo ~/Scripts/Fileserver/mount_fileserver.sh

# CD to the file system

    cd $FileDir

# create a directory for the file output

    #sudo mkdir "A.1.2" -p

    #cd "A.1.2"

    echo -e "${On_Red}${BIWhite}"

    mkdir $Description -p

    echo -e "${Color_Off}"

## General scan
    echo -e "\n${Green}Conducting nmap general scan of ${BGreen}$IP_add${Color_Off}"

    # create a file name for the output

        general_filepath=./${Description}/${Description}_scan

    sudo nmap -n -v -Pn -p- --reason -oA $general_filepath $IP_add

    xsltproc "${general_filepath}.xml" -o "${general_filepath}.html"

## Scan for SSL / TLS certificates
    echo -e "\n${Green}Conducting SSL certificates scan for ${BGreen}$IP_add${Color_Off}"

    # create a file name for the outputd
        #certs_filepath="./$Decription/$Decription_certificates"

        certs_filepath=./${Description}/${Description}_certificates

    sudo nmap --script ssl-cert -Pn -p 443 -oA $certs_filepath $IP_add

    xsltproc "${certs_filepath}.xml" -o "${certs_filepath}.html"

# ## Scan for SSL / TLS Ciphers
    echo -e "\n${Green}Conducting SSL ciphers scan for ${BGreen}$IP_add${Color_Off}"

    # create a file name for the output

        ciphers_filepath=./${Description}/${Description}_ciphers

    sudo nmap --script ssl-enum-ciphers -Pn -p 443 -oA $ciphers_filepath $IP_add

    xsltproc "${ciphers_filepath}.xml" -o "${ciphers_filepath}.html"

#Open file location in Thunar

sudo chown iot -R $FileDir

dolphin $FileDir

#Exit from terninal

exit