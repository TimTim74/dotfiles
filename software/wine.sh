#!/bin/bash
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Tim Eichmann
# Website 	: 	http://www.741231.com
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

sudo dpkg --add-architecture i386

wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -

sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main'

sudo apt-get update
sudo apt-get install --install-recommends winehq-stable

echo "################################################################"
echo "######################## Wine installed ########################"
echo "################################################################"