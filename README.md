# DIY HTPC
A hacked together Do It Yourself Home Theatre PC

This is mostly uploaded for my personal use, but if you find it helpful, enjoy!

The idea behind the script is to have a Amazon Fire Stick like environemnt running of a computer.

It is recommend that the latest stable Ubuntu is installed as the install script heavily uses apt packet manager. However, if you want to install and configure this manually, any distro should work fine.

## Warning
The install script is rough as and is more a mental map for myself for when I upgrade the computer running my HTPC, as well as assisting in automating some of the work. Nothing should go too bad if you run it, but don't blame me if something goes wrong!

## Install 
`curl -sSL https://raw.githubusercontent.com/steveharsant/htpc/master/install.sh | sudo bash`

## Packages and Dependancies
budgie-core budgie-showtime-applet gcc google-chrome-stable kodi libimlib2-dev libx11-dev make samba spotify-client

## Hints and Tips
Budgie was the selected desktop environment to use because of personal preference but also because of the Show tell applet that allows you to place a clock on the desktop. 

You can configure the clock placement to fit in the gap of buttons in the top right corner from the Budgie settings menu. You can also hide the taskbar there too.

Set the main user to auto login when the computer boots

Run the install script as sudo with the logged in user that will auto log in when booted. Also, don't run the script over a ssh session, some settings will not set.

## Credits
Credits to Tomas-M and the hard work that went into xlunch (https://github.com/Tomas-M)

## Disclaimer
I did not create, nor own any of the logo's or trademarks used in the GUI.
