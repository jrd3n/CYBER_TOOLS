#!/bin/bash

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