!/usr/bin/env bash

echo "--------------------------------------"
echo "-- Arch Install on Main Drive       --"
echo "--------------------------------------"

genfstab -U -p /mnt >> /mnt/etc/fstab
pacstrap -i /mnt base
arch-chroot /mnt
mkdir /mnt/boot/efi
mount  "${DISK}1" /mnt/boot/EFI
pacman -S nano
pacman -S linux linux-headers
mkinitcpio -p linux

pacman -S grub efibootmgr dosfstools os-prober mtools
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg


echo "--------------------------------------"
echo "--          Network Setup           --"
echo "--------------------------------------"
pacman -S networkmanager wpa_supplicant wireless_tools netctl dialog dhclient 
systemctl enable NetworkManager
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
