#!/bin/bash

#pacman -S --needed grub efibootmgr
#grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
#mv /ArchInst/grub /etc/default/grub
#grub-mkconfig -o /boot/grub/grub.cfg

bootctl --path=/boot install
cp /ArchInst/loader.conf /boot/loader
cp /ArchInst/arch.conf /boot/loader/entries



#mv /ArchInst/mkinitcpio.conf /etc/
#mkinitcpio -p linux
