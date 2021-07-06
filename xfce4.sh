#!/bin/bash


sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload


git clone https://aur.archlinux.org/google-chrome.git

git clone https://aur.archlinux.org/paru-bin

git clone https://aur.archlinux.org/pikaur.git



pacman -S --needed acpi acpi_call-lts acpid alsa-utils arc-gtk-theme arc-icon-theme arj avahi bridge-utils code cpio dnsmasq dnsutils dolphin edk2-ovmf extra-cmake-modules gedit gnome-disk-utility gvfs gvfs-smb hicolor-icon-theme htop inetutils kde-cli-tools kdiff3 kdoctools keditbookmarks kompare konsole kparts krusader ktexteditor lhasa lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings nfs-utils nss-mdns ntfs-3g p7zip pavucontrol pulseaudio pulseaudio-bluetooth pulseaudio-jack qbittorrent qemu qemu-arch-extra sof-firmware terminator unace unrar unzip vde2 virt-manager vlc xfburn xfce4-appfinder xfce4-artwork xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-mount-plugin xfce4-panel xfce4-power-manager xfce4-pulseaudio-plugin xfce4-screensaver xfce4-session xfce4-settings xfce4-taskmanager xfce4-weather-plugin xfce4-whiskermenu-plugin xfconf xfdesktop xfwm4 xfwm4-themes xorg xz zip


systemctl enable NetworkManager
systemctl enable bluetooth
#systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
#systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
#systemctl enable firewalld
systemctl enable acpid



sudo systemctl enable lightdm
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot
