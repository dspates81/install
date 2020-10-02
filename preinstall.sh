#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo "-------------------------------------------------"
echo "Setting up mirrors for optimal download - US Only"
echo "-------------------------------------------------"
timedatectl set-ntp true
pacman -S --noconfirm pacman-contrib
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist



echo -e "\nInstalling prereqs...\n$HR"
pacman -S --noconfirm gptfdisk btrfs-progs

echo "-------------------------------------------------"
echo "-------select your disk to format----------------"
echo "-------------------------------------------------"
lsblk
echo "Please enter disk: (example /dev/sda)"
read DISK
echo "--------------------------------------"
echo -e "\nFormatting disk...\n$HR"
echo "--------------------------------------"

# disk prep
sgdisk -Z ${DISK} # zap all on disk
sgdisk -a 2048 -o ${DISK} # new gpt disk 2048 alignment

# create partitions
sgdisk -n 1:0:+5120M ${DISK} # partition 1 (UEFI SYS), default start block, 512MB
sgdisk -n 2:0:0     ${DISK} # partition 2 (Root), default start, remaining

# set partition types
sgdisk -t 1:ef00 ${DISK}
sgdisk -t 2:8300 ${DISK}

# label partitions
sgdisk -c 1:"UEFISYS" ${DISK}
sgdisk -c 2:"ROOT" ${DISK}

# make filesystems
echo -e "\nCreating Filesystems...\n$HR"

mkfs.vfat -F32 -n "UEFISYS" "${DISK}1"
mkfs.ext4 -L "ROOT" "${DISK}2"

# mount target

mount -t ext4 "${DISK}2" /mnt/
mkdir /mnt/boot
mount "${DISK}1" /mnt/boot/

#Install Arch linux base pacgkages
echo "--------------------------------------"
echo "-- Arch Install on Main Drive       --"
echo "--------------------------------------"

pacstrap /mnt base 
pacman -S base-devel linux-firmware 
pacman -S vim nano sudo 
genfstab -U /mnt >> /mnt/etc/fstab
#pacstrap -i /mnt base
arch-chroot /mnt
fallocate -l 2GB /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
ln -sf /usr/share/zoneinfo/America/New York /etc/localtime
hwclock --systohc


pacman -S os-prober mtools do sfstools
pacman -S efibootmgr

pacman -S networkmanager network-manager-applet 
pacman -S wpa_supplicant wireless_tools netctl dialog dhclient
systemctl enable now NetworkManager
pacman -S nano
systemctl enable ssh

mkinitcpio -p linux
pacman -S intel-ucode
Pacman -S xorg-server
pacman -S mesa
pacman -S nvidia nvidia-utils

echo "--------------------------------------"
echo "--      Set Password for Root       --"
echo "--------------------------------------"
echo "Enter password for root user: "
passwd root

echo "--------------------------------------"
echo "-- Bootloader Systemd Installation  --"
echo "--------------------------------------"



bootctl --path=/boot install



echo "--------------------------------------"
echo "--   SYSTEM READY FOR FIRST BOOT    --"
echo "--------------------------------------"
