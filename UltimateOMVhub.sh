#!/bin/bash

##################################################################################################
# The Ultimate Homekit Hub.                                                                      #
# Copyright (C) 2022 Eddie dSuZa                                                                 #
#                                                                                                #
# This program is free software: you can redistribute it and/or modify                           #
# it under the terms of the GNU General Public License as published by                           #
# the Free Software Foundation, either version 3 of the License, or                              #
# (at your option) any later version.                                                            #
#                                                                                                #
# This program is distributed in the hope that it will be useful,                                #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                                 #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                                  #
# GNU General Public License for more details.                                                   #
#                                                                                                #
# You should have received a copy of the GNU General Public License                              #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.                          #
##################################################################################################
echo " "
echo " "
echo " "
# System Upgrade
echo "----------------------------------------------------------------"
echo "Commence System Upgrade"
echo "----------------------------------------------------------------"
sudo apt-get update && sudo apt-get upgrade -y
echo "----------------------------------------------------------------"
echo "System Upgrade Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Watch Tower setup
echo "----------------------------------------------------------------"
echo "Commence Watch Tower Setup"
echo "----------------------------------------------------------------"
sudo docker run --name="watchtower" -d --restart unless-stopped -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
echo "----------------------------------------------------------------"
echo "Watch Tower Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Homebridge Install
echo "----------------------------------------------------------------"
echo "Commence Homebridge Setup"
echo "----------------------------------------------------------------"
sudo docker run --name homebridge --network host -d --restart unless-stopped -v /srv/conf/homebridge:/server/volume -e PGID=1000 -e PUID=1000 -e HOMEBRIDGE_CONFIG_UI=1 -e HOMEBRIDGE_CONFIG_UI_PORT=8581 oznu/homebridge
echo "----------------------------------------------------------------"
echo "Homebridge Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# MQTT Install
#echo "----------------------------------------------------------------"
#echo "Commence MQTT Setup"
#echo "----------------------------------------------------------------"
#sudo mkdir mosquitto
#sudo mkdir mosquitto/config/
#sudo mkdir mosquitto/data/
#sudo wget https://raw.githubusercontent.com/EddieDSuza/maxilife/main/mosquitto.conf -P /home/pi/mosquitto/config/
#sudo docker run -it --name MQTT --restart unless-stopped --net=host -tid -p 1883:1883 -v $(pwd)/mosquitto:/mosquitto/ eclipse-mosquitto
#echo "----------------------------------------------------------------"
#echo "MQTT Setup Completed"
#echo "----------------------------------------------------------------"
#echo " "
#echo " "
#echo " "
# Z2M setup
#echo "----------------------------------------------------------------"
#echo "Commence Zigbee2MQTT Setup"
#echo "----------------------------------------------------------------"
#wget https://raw.githubusercontent.com/EddieDSuza/techwitheddie/main/configuration.yaml -P data
#echo " "
#sudo docker run --name zigbee2mqtt --device=/dev/ttyACM0 --net host --restart unless-stopped -v $(pwd)/data:/app/data -v /run/udev:/run/udev:ro -e TZ=Asia/Dubai koenkk/zigbee2mqtt
#echo "----------------------------------------------------------------"
#echo "Z2M Interface is reachable at homebridge.local:8081"
#echo "----------------------------------------------------------------"
#echo " "
#echo " "
#echo " "
# scrypted setup
echo "----------------------------------------------------------------"
echo "Commence Scrypted Setup"
echo "----------------------------------------------------------------"
sudo docker run --name="scrypted" --network host -d --restart unless-stopped -v /srv/conf/scrypted/volume:/server/volume koush/scrypted
echo "----------------------------------------------------------------"
echo "Scrypted Interface is reachable at homebridge.local:10443"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# HEIMDALL setup
echo "----------------------------------------------------------------"
echo "Commence HEIMDALL Setup"
echo "----------------------------------------------------------------"
sudo docker run --name=heimdall -d --restart unless-stopped -v /srv/conf/heimdall:/config -e PGID=1000 -e PUID=1000 -p 8201:80 -p 8200:443 linuxserver/heimdall
echo " "
echo "----------------------------------------------------------------"
echo "HEIMDALL Interface is reachable at homebridge.local:8201"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "ALL PACKAGES INSTALLED WITH NO ERRORS"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "Need Rebooting Now"
#sudo reboot
