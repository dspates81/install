#!/bin/bash


pacman -S --needed grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
cp /ArchInst/conf/grub /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg

cp /ArchInst/conf/mkinitcpio.conf /etc/
mkinitcpio -p linux
