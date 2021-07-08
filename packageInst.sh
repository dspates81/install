#!/bin/bash

pacman -S --needed tlp firefox dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils alsa-utils pulseaudio pulseaudio-bluetooth pavucontrol pulseaudio-jack bash-completion openssh rsync reflector acpi acpi_call tlp edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld sof-firmware nss-mdns acpid os-prober ntfs-3g

sudo systemctl enable lightdm
sudo systemctl enable sshd
sudo systemctl enable avahi-daemon
#sudo systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
#sudo systemctl enable bluetooth
#sudo systemctl enable reflector.timer
#sudo systemctl enable fstrim.timer
#sudo systemctl enable libvirtd
#sudo systemctl enable firewalld
#sudo systemctl enable acpid


#sudo firewall-cmd --add-port=1025-65535/tcp --permanent
#sudo firewall-cmd --add-port=1025-65535/udp --permanent
#sudo firewall-cmd --reload
