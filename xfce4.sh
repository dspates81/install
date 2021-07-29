#!/bin/bash


#sudo firewall-cmd --add-port=1025-65535/tcp --permanent
#sudo firewall-cmd --add-port=1025-65535/udp --permanent
#sudo firewall-cmd --reload


mkdir Aur_file
cd Aur_file

git clone https://aur.archlinux.org/google-chrome.git
#cd google-chome/
#makepkg -isc --noconfirm/justin/google-chrome


#Xfce
sudo pacman -S --needed exo garcon thunar thunar-volman tumbler xfce4-appfinder xfce4-panel xfce4-power-manager xfce4-session xfce4-settings xfconf xfdesktop xfwm4 xfwm4-themes thunar-archive-plugin thunar-media-tags-plugin xfburn xfce4-artwork xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-mpc-plugin xfce4-netload-plugin xfce4-notes-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screensaver xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-taskmanager xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-xkb-plugin xfce4-whiskermenu-plugin pavucontrol pulseaudio pulseaudio-bluetooth pulseaudio-jack gedit lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings terminator xorg htop alsa-utils gnome-disk-utility hicolor-icon-theme sof-firmware qbittorrent


#Other
sudo pacman -S --needed  firefox arc-gtk-theme arc-icon-theme code vlc gvfs gvfs-smb edk2-ovmf vde2 nss-mdns virt-manager qemu qemu-arch-extra mkinitcpio-archiso archiso arch-install-scripts bash e2fsprogs libarchive libisoburn squashfs-tools erofs-utils openssl dkms fuse2 gtk3 gtkmm3 hicolor-icon-theme

sudo systemctl enable lightdm.servcie
