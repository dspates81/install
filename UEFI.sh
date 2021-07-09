#!/bin/bash

pacmn -Sy

echo "-------------------------------------------------"
echo "Setting up mirrors for optimal download - US Only"
echo "-------------------------------------------------"

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

pacman -S --needed grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font samba

echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"
echo "--------------------------------------"

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid
systemctl enable smb.service

