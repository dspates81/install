#!/bin/bash

pacman -S --noconfirm pacman-contrib curl

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

curl -s "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

pacman -S --needed  networkmanager network-manager-applet dialog wpa_supplicant reflector iproute2 dhcp dhclient dhcpcd netctl nfs-utils networkmanager-vpnc nss iputils netcf innernet
 

systemctl enable NetworkManager
