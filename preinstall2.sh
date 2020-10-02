#!/usr/bin/env bash

arch-chroot /mnt

#fallocate -l 2GB /swapfile
#chmod 600 /swapfile
#mkswap /swapfile
#swapon /swapfile
#ln -sf /usr/share/zoneinfo/America/New York /etc/localtime
#hwclock --systohc


pacman -S os-prober mtools do sfstools
pacman -S efibootmgr

pacman -S networkmanager network-manager-applet 
pacman -S wpa_supplicant wireless_tools netctl dialog dhclient
systemctl enable now NetworkManager
pacman -S nano
systemctl enable ssh

mkinitcpio -p linux
pacman -S intel-ucode
Pacman -S xorg-server
pacman -S mesa
pacman -S nvidia nvidia-utils


