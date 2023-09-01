#!/bin/bash

mkdir -p ~/DEL

# Download the zip archive using wget
wget https://github.com/jrd3n/CYBER_TOOLS/archive/refs/heads/main.zip -P ~/DEL

# Extract the downloaded archive using unzip
unzip  ~/main.zip ~/DEL

# Create the installation directory if it doesn't exist
mkdir -p ~/CYBER_TOOLS

mv ~/DEL/CYBER_TOOLS-main/* ~/CYBER_TOOLS

cp -r ~/CYBER_TOOLS/CYBER_TOOLS-main/* ~/CYBER_TOOLS/

# House keeping
rm ~/DEL -d

chmod +x ~/CYBER_TOOLS/SCRIPTS/*