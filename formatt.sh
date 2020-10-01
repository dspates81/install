
#!/usr/bin/env bash

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
sgdisk -a ${DISK} # new gpt disk 2048 alignment
sgdisk -b ${DISK} # new gpt disk 2048 alignmen

# create partitions
sgdisk -n 1:0:+5120M ${DISK} # partition 1 (UEFI SYS), default start block, 512MB
sgdisk -n 2:0:+102400M ${DISK} # partition 2 (Root), default start block, 102400MB
sgdisk -n 3:0:0     ${DISK} # partition 3  (home), default start, remaining

# set partition types
sgdisk -t 1:ef00 ${DISK}
sgdisk -t 2:8300 ${DISK}
sgdisk -t 3:8300 ${DISK}

# label partitions
sgdisk -c 1:"UEFISYS" ${DISK}
sgdisk -c 2:"ROOT" ${DISK}
sgdisk -c 3:"FREESPACE" ${DISK}

# make filesystems
echo -e "\nCreating Filesystems...\n$HR"

mkfs.vfat -F32 -n "UEFISYS" "${DISK}1"
mkfs.ext4 -L "ROOT" "${DISK}2"
mkfs.ext4 -L "linuxfilesystem" "${DISK}3"

# mount target

mount -t ext4 "${DISK}2" /mnt
mkdir /mnt/home
mount -t ext4 "${DISK}3" /mnt/home/
mkdir /mnt/etc

./Arch_Installation.sh
