#!/bin/bash

systemctl enable --now ssh
systemctl disable --now dphys-swapfile
systemctl mask dphys-swapfile

# Update the system to latest
apt update; apt upgrade -y; apt autoremove -y

# Install required OS packages 
apt install -y \
    python3-dev \
    zlib1g-dev \
    libjpeg62-turbo-dev
#    libjpeg9-dev

# By using "--no-install-recommends", the GUI components are not installed
apt install -y python3-picamera2 --no-install-recommends