#!/bin/bash

pacman -S --noconfirm pacman-contrib curl
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

pacman -S --needed  networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector iproute2 dhcp dhclient dhcpcd dhcping wpa_supplicant wireless_tools netctl
dialog base-devel linux-headers





systemctl enable NetworkManager
