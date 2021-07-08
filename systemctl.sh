#!/bin/bash


sudo systemctl enable lightdm
sudo systemctl enable bluetooth
sudo systemctl enable sshd
sudo systemctl enable avahi-daemon
sudo systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
sudo systemctl enable reflector.timer
sudo systemctl enable fstrim.timer
sudo systemctl enable libvirtd
sudo systemctl enable firewalld
sudo systemctl enable acpid


#sudo firewall-cmd --add-port=1025-65535/tcp --permanent
#sudo firewall-cmd --add-port=1025-65535/udp --permanent
#sudo firewall-cmd --reload
