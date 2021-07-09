#!/bin/bash


pacman -S --needed grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
cp /ArchInst/conf/grub /etc/default/grub

cp /ArchInst/conf/mkinitcpio.conf /etc/
mkinitcpio -p linux


#bootctl --path=/boot install
#cp loader.conf /boot/loader
#cp arch.conf /boot/loader/entries


