#!/bin/bash




git clone /home/justin/https://aur.archlinux.org/google-chrome.git

git clone https://aur.archlinux.org/paru-bin

git clone https://aur.archlinux.org/pikaur.git



sudo pacman -Sy --needed firefox xorg lightdm lightdm-gtk-greeter xfce4-appfinder xfce4-panel xfce4-power-manager xfce4-session xfce4-settings xfconf xfdesktop xfwm4 xfwm4-themes arc-gtk-theme arc-icon-theme vlc xfburn xfce4-artwork xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-mount-plugin xfce4-pulseaudio-plugin xfce4-screensaver xfce4-whiskermenu-plugin xfce4-weather-plugin xfce4-pulseaudio-plugin xfce4-taskmanager krusader hicolor-icon-theme kparts arj cpio kde-cli-tools kdiff3 keditbookmarks kompare konsole ktexteditor lhasa p7zip unace unrar unzip xz zip extra-cmake-modules kdoctools qbittorrent dolphin htop code gnome-disk-utility gedit terminator virt-manager qemu qemu-arch-extra terminus-font



sudo systemctl enable lightdm
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot
