#!/bin/bash

pacmn -Sy

pacman -S --needed grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
cp /ArchInst/grub /etc/default/grub


#bootctl --path=/boot install
#cp loader.conf /boot/loader
#cp arch.conf /boot/loader/entries

cp /ArchInst/mkinitcpio.conf /etc/
mkinitcpio -p linux