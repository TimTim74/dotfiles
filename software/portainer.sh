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

# Create volume
docker volume create portainer_data

#Start container
docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data --name portainer --restart=always portainer/portainer

echo "################################################################"
echo "###################   Portainer installed   ####################"
echo "################################################################"