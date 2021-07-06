#!/bin/bash

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
mv /ArchInst/grub /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

mv /ArchInst/mkinitcpio.conf /etc/
mkinitcpio -p linux


systemctl enable NetworkManager
systemctl enable bluetooth
#systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid