#!/bin/bash

#===================================================#
#                  DIY HTPC Installer               #
#               Author: Steven Harsant              #
#                  Date: 25/04/2019                 #
#                   Version: 0.1                    #
#===================================================#
#                                                   #
#      Rough and raw installer script to setup      #
#       your very own DIY HTPC based on Xlunch      #
#      and Ubuntu. Extra packages include kodi,     #
#     Chrome, Budgie Desktop Environment, Spotfy    #
# and a bunch of other bits to glue it all together #
#                                                   #
#   Credits to Tomas-M and the hard work that went  #
#     into xlunch (https://github.com/Tomas-M)      #
#                                                   #
#===================================================#

#################
# Set Variables #
#################
WHITE='\033[1;37m'
RED='\033[0;91m'
GREEN='\33[92m'
YELLOW='\033[93m'
BLUE='\033[1;34m'

FAIL=${RED}'FAIL:'${WHITE} #FAIL MESSAGES
PASS=${GREEN}'PASS:'${WHITE} #PASS MESSAGES
INFO=${YELLOW}'INFO:'${WHITE} #INFO MESSAGES
HINT=${BLUE}'HINT:'${WHITE} #HINT MESSAGES

# Get logged in username
USERNAME=`awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd | head -n 1` #Logged in username

printf "Welcome to the ${GREEN}DIY HTPC${WHITE} setup script\n"
printf "Credits to ${BLUE}Tomas-M${WHITE} and the hard work that went into ${BLUE}xlunch (https://github.com/Tomas-M)${WHITE} \n"
printf "All and any logos and trademarks are owned by the respective companies. \n"
printf "${RED}WARNING:${WHITE} This script is in the earliest of early stages and may be unpredicable. No real testing has taken place yet and may not ever. \n"
printf "It was intended to make my life a little easier, so I hope it makes your life easier too! \n"
printf " \n"
printf "${HINT} Run this script as the user that will be logged when using our HTPC with sudo \n"


###############################
# Check Script Is Run As root #
###############################
if [ "$EUID" -ne 0 ]
  then
    printf "${FAIL} Permission Denied \n"
    printf "${INFO} Run with the sudo command \n"
    printf "${HINT} Try the command: ${YELLOW}sudo !! ${WHITE}\n"
    exit
  else
    printf "${PASS} Script running with super user rights \n"
fi

########################
# Install Dependancies #
########################
# Add repositories
printf "${INFO} Adding Budgie Desktop Environment repository \n"
add-apt-repository -y ppa:ubuntubudgie/backports > /dev/null 2>&1  #Budgie Backports Repo For Applets
printf "${INFO} Adding Google Chrome repository \n"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - > /dev/null 2>&1 #chrome Web Browser
printf "${INFO} Adding Spotify repository \n"
echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list > /dev/null 2>&1 #Spotify Music Player
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90

printf "${INFO} Running apt update \n"
apt-get update -qq

printf "${INFO} Installing dependancies and packages \n"
apt install -qq budgie-core budgie-showtime-applet gcc google-chrome-stable kodi libimlib2-dev libx11-dev make samba spotify-client -y > /dev/null 2>&1

##################
# Install Xlunch #
##################
mkdir /home/${USERNAME}/xlunch
cd /home/${USERNAME}/xlunch
printf "${INFO} Downloading xlunch \n"
wget https://github.com/Tomas-M/xlunch/archive/v4.4.0.tar.gz
tar -xzvf v4.4.0.tar.gz
rm v4.4.0.tar.gz
cd xlunch-4.4.0
printf "${INFO} installing xlunch \n"
make install
cd /home/${USERNAME}/xlunch
rm -rf xlunch-4.4.0/

####################
# Configure Xlunch #
####################
printf "${INFO} Downloading xlunch HTPC configuration and resources \n"
wget https://github.com/steveharsant/htpc/archive/master.zip
unzip master.zip
cp -r ./htpc-master/* .
rm master.zip
chmod +x run.sh

printf "${INFO} Setting default background \n"
gsettings set org.gnome.desktop.background picture-uri "file:///home/${USERNAME}/xlunch/images/wallpapers/wallpaper.png"

printf "${INFO} Creating autostart entry for xlunch \n"
mkdir -p /home/${USERNAME}/.config/autostart
cat > /home/${USERNAME}/.config/autostart/xlunch.desktop << EOL
[Desktop Entry]
Type=Application
Name=xlunch launcher
Description=xlunch launcher
Exec=/home/${USERNAME}/xlunch/run.sh
EOL

chown -R ${USERNAME} /home/${USERNAME}/xlunch/
printf "${GREEN} Complete! ${WHITE} Restart your computer and enjoy. Look at the readme for extra steps to polish the look! \n"
