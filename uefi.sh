#!/bin/bash

pacman -Sy

echo "-------------------------------------------------"
echo "Setting up mirrors for optimal download - US Only"
echo "-------------------------------------------------"

pacman -S --noconfirm pacman-contrib curl
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "-- Arch Install on Main Drive       --"
echo "--------------------------------------"

pacman -S --needed networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font samba

echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"



