#!/bin/bash

pacman -S --noconfirm pacman-contrib curl
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

pacman -S --needed  networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers os-prober net-tools reflector

#xdg-user-dirs bluez bluez-utils  gvfs gvfs-smb nfs-utils inetutils ntfs-3g acpi acpi_call tlp edk2-ovmf bridge-utils firewalld sof-firmware nss-mdns acpid avahi iptables-nft ipset dnsmasq vde2 xdg-utils dnsutils alsa-utils bash-completion openssh rsync openbsd-netcat 
systemctl enable NetworkManager
