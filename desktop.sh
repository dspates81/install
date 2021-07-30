#!/bin/bash


#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------


nc=$(grep -c ^processor /proc/cpuinfo)
echo "You have " $nc" cores."
echo "-------------------------------------------------"
echo "Changing the makeflags for "$nc" cores."
sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j$nc"/g' /etc/makepkg.conf
echo "Changing the compression settings for "$nc" cores."
sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g' /etc/makepkg.conf

echo "-------------------------------------------------"
echo "       Setup Language to US and set locale       "
echo "-------------------------------------------------"

ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
cp /ArchInst/conf/locale.gen /etc/locale.gen
locale-gen

echo "Desktop" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 desktop.localdomain Desktop" >> /etc/hosts


dd if=/dev/zero of=swapfile bs=1M count=1024 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

echo "
/swapfile		none	swap	defaults	0 0

//10.170.25.80/Media\040Sever   /home/justin/Media_Sever/               cifs    credentials=/home/justin/.Pserver_creds,file_mode=0777,dir_mode=0777,rw 0   0

//10.170.25.80/domains   /home/justin/domains/               cifs    credentials=/home/justin/.Pserver_creds,file_mode=0777,dir_mode=0777,rw       0       0

//10.170.25.80/storage   /home/justin/storage/               cifs    credentials=/home/justin/.Pserver_creds,file_mode=0777,dir_mode=0777,rw       0       0
" >> /etc/fstab

# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

passwd
useradd -mG wheel justin
passwd justin


pacman -S networkmanager network-manager-applet 

./Install/uefi.sh
./Install/bootloader.sh

