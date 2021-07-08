#!/bin/bash

sudo systemctl enable lightdm
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable sshd
sudo systemctl enable avahi-daemon
sudo systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
sudo systemctl enable reflector.timer
sudo systemctl enable fstrim.timer
sudo systemctl enable libvirtd
sudo systemctl enable firewalld
sudo systemctl enable acpid
sudo systemctl enable smb
sudo systemctl enable nmb
