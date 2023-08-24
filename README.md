# Tools for Cyber

Tool i use for cyber and the install notes to easily set up.

<!-- TOC -->

- [Tools for Cyber](#tools-for-cyber)
  - [Angry IP Scanner Install and custom openers](#angry-ip-scanner-install-and-custom-openers)
    - [Install](#install)
      - [Apply my config to angry ip](#apply-my-config-to-angry-ip)
      - [Install tools for my config](#install-tools-for-my-config)
    - [Install my tool for updating the openers](#install-my-tool-for-updating-the-openers)
  - [Word lists](#word-lists)

<!-- /TOC -->

## Angry IP Scanner Install and custom openers

A place to store my custom scripts openers and such.

### Install

On your Linux machine, open a terminal window and enter the following command:

```bash
wget https://github.com/angryip/ipscan/releases/download/3.7.6/ipscan_3.7.6_all.deb
#sudo apt install default-jre
sudo apt install openjdk-8-jre gdebi
sudo gdebi ipscan_3.7.6_all.deb
```

#### Apply my config to angry ip

if you want to use these openers and set up Angry IP using my config.

```bash

wget https://raw.githubusercontent.com/jrd3n/CYBER_TOOLS/main/OPENER_TOOL/prefs.xml -O ~/.java/.userPrefs/ipscan/prefs.xml

```

#### Install tools for my config

```bash

sudo apt install hping3
sudo apt-get install hydra-gtk
sudo apt install nmap
sudo apt install xsltproc

```

### Install my tool for updating the openers

```bash

cd OPENER_TOOL

sudo apt install python3-pip
sudo apt install python3-venv
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

```

## Word lists

this guy has some really good word lists:

https://github.com/kkrypt0nn/wordlists

```bash

# Create the installation directory if it doesn't exist
mkdir -p ~/CYBER_TOOLS

# Download the zip archive using wget
wget https://github.com/kkrypt0nn/wordlists/archive/refs/heads/main.zip -P ~/Tools

# Extract the downloaded archive using unzip
unzip  ~/CYBER_TOOLS/main.zip -d ~/CYBER_TOOLS/Wordlists

# House keeping
rm ~/CYBER_TOOLS/main.zip

```
