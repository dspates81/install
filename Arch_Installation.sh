#!/usr/bin/env bash

echo "--------------------------------------"
echo "-- Arch Install on Main Drive       --"
echo "--------------------------------------"

genfstab -U -p /mnt >> /mnt/etc/fstab
pacstrap -i /mnt base
arch-chroot /mnt
pacman -S nano
pacman -S linux linux-headers
mkinitcpio -p linux


echo "--------------------------------------"
echo "--          Network Setup           --"
echo "--------------------------------------"
pacman -S networkmanager wpa_supplicant wireless_tools netctl dialog dhclient --noconfirm --needed
systemctl enable --now NetworkManager
pacman -S base-devel openssh
systemctl enable ssh


echo "--------------------------------------"
echo "--      Set Password for Root       --"
echo "--------------------------------------"
echo "Enter password for root user: "
passwd root

umount -R /mnt

echo "--------------------------------------"
echo "--   SYSTEM READY FOR FIRST BOOT    --"
echo "--------------------------------------"
