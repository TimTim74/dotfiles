#!/bin/bash
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# Website 	: 	http://www.erikdubois.be
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -

echo "deb https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skypeforlinux.list

sudo sudo apt update

sudo sudo apt install skypeforlinux


echo "################################################################"
echo "###################    Skype installed    ######################"
echo "################################################################"
