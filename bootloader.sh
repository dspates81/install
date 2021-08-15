#!/bin/bash


pacman -S --needed grub efibootmgr dosfstools os-prober mtools

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

cp /install/conf/grub /etc/default/grub

cp /install/conf/mkinitcpio.conf /etc/

mkinitcpio -p linux
