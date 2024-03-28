# Tools for Cyber

Tools I use for cyber security, and the install notes to easily set up.

<!-- TOC -->

- [Tools for Cyber](#tools-for-cyber)
  - [Angry IP Scanner Install and custom openers](#angry-ip-scanner-install-and-custom-openers)
    - [Install](#install)
      - [Apply my config to angry ip](#apply-my-config-to-angry-ip)
  - [Word lists](#word-lists)

<!-- /TOC -->

## Angry IP Scanner Install and custom openers

A place to store my custom scripts openers and such.

### Install

To install angry IP scanner

On your Linux machine, open a terminal window and enter the following command:

```bash
wget https://github.com/angryip/ipscan/releases/download/3.7.6/ipscan_3.7.6_all.deb
sudo apt install default-jre
sudo apt install openjdk-8-jre gdebi
sudo gdebi ipscan_3.7.6_all.deb
```

#### Apply my config to angry ip

if you want to use these openers and set up Angry IP using my config.

```bash

mkdir -p ~/DEL

wget https://github.com/jrd3n/CYBER_TOOLS/archive/refs/heads/feb_24.zip -P ~/DEL

cd ~/DEL
# Extract the downloaded archive using unzip
unzip  ~/DEL/feb_24.zip

# Create the installation directory if it doesn't exist
mkdir -p ~/CYBER_TOOLS

mv ~/DEL/CYBER_TOOLS-feb_24/* ~/CYBER_TOOLS

# cp -r ~/CYBER_TOOLS/CYBER_TOOLS-main/* ~/CYBER_TOOLS/

cd ~/CYBER_TOOLS

# House keeping
rm ~/DEL -d -r

chmod +x ~/CYBER_TOOLS/SCRIPTS/*

```

Now install the actual tools

```bash

# Install the actual tools

sudo apt install hping3 -y
sudo apt-get install hydra-gtk -y
sudo apt install nmap -y
sudo apt install xsltproc -y
sudo apt install ssh -y
sudo apt install gobuster -y
sudo apt install redis-tools -y
sudo snap install searchsploit

sudo snap install metasploit-framework
# CP the config to angry IP

cp ~/CYBER_TOOLS/OPENER_TOOL/prefs.xml ~/.java/.userPrefs/ipscan/prefs.xml 
```

## Word lists

this guy has some really good word lists:

https://github.com/kkrypt0nn/wordlists

```bash

# Create the installation directory if it doesn't exist

mkdir -p ~/DEL

# Download the zip archive using wget
wget https://github.com/kkrypt0nn/wordlists/archive/refs/heads/main.zip -P ~/DEL

# Extract the downloaded archive using unzip

unzip  ~/DEL/main.zip -d ~/DEL
mkdir ~/WORDLISTS -p
mv ~/DEL/wordlists-main/* ~/WORDLISTS

# House keeping
rm ~/DEL -dr

```