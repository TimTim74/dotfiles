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

sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/selmf/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/yacreader.list"

cd /tmp; wget http://download.opensuse.org/repositories/home:selmf/xUbuntu_16.04/Release.key

sudo apt-key add - < Release.key

sudo apt-get update

sudo apt-get install -y yacreader

echo "################################################################"
echo "###################   YAC Reader installed   ###################"
echo "################################################################"