#!/bin/bash

# 
sudo cp /home/ubuntu/sources.list /etc/apt/sources.list
sudo rm /home/ubuntu/sources.list
sudo apt update
sudo apt upgrade -y
sudo wget https://autoinstall.plesk.com/one-click-installer
sudo chmod +x one-click-installer
sudo ./one-click-installer
sudo apt clean
sudo apt autoremove -y