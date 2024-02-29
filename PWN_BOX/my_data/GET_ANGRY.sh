#!/bin/bash

cd ~/

wget https://github.com/angryip/ipscan/releases/download/3.7.6/ipscan_3.7.6_all.deb
sudo apt install default-jre
# sudo apt install openjdk-8-jre gdebi
sudo gdebi ipscan_3.7.6_all.deb

ipscan

cp ~/CYBER_TOOLS/OPENER_TOOL/prefs.xml ~/.java/.userPrefs/ipscan/prefs.xml

ipscan