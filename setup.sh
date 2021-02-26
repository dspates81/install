#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------




echo "-------------------------------------------------"
echo "       Setup Language to US and set locale       "
echo "-------------------------------------------------"


ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
echo hwclock --systohc
nano /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen


echo "-------------------------------------------------"
echo "-------------------Formatt----------------------"
echo "-------------------------------------------------"


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


# create partitions
sgdisk -n 1:0:+3000M ${DISK} # partition 1 (UEFI SYS), default start block, 3GB
sgdisk -n 2:0:+50000M ${DISK} # partition 2 (Root), default start block, 50GB


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

mount -t ext4 "${DISK}2" /mnt
mkdir -p /dev/"${DISK}1" /mnt/boot/efi
mount /dev/"${DISK}1" /mnt/boot/efi


echo "--------------------------------------"
echo "-- Arch Install on Main Drive       --"
echo "--------------------------------------"


pacstrap -i /mnt base linux linux-headers nano sudo man 
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt




dd if=/dev/zero of=swapfile bs=1M count=5120 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

echo "
/swapfile		none	swap	defaults	0 0
" >> /etc/fstab

pacman -S grub efibootmgr dosfstools os-prober mtools
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck
grub-mkconfig -o /boot/grub/grub.cfg



echo "--------------------------------------"
echo "--          Network Setup           --"
echo "--------------------------------------"
pacman -S networkmanager network-manager-applet wpa_supplicant wireless_tools mtools netctl dialog dhclient multilib-devel base-devel openssh
systemctl enable NetworkManager
systemctl enable ssh


echo "--------------------------------------"
echo "--      Set Password for User       --"
echo "--------------------------------------"

if ! source install.conf; then
	read -p "Please enter hostname:" hostname

	read -p "Please enter username:" username

	read -sp "Please enter password:" password

	read -sp "Please repeat password:" password2

	# Check both passwords match
	if [ "$password" != "$password2" ]; then
	    echo "Passwords do not match"
	    exit 1
	fi
  printf "hostname="$hostname"\n" >> "install.conf"
  printf "username="$username"\n" >> "install.conf"
  printf "password="$password"\n" >> "install.conf"
fi

echo "Enter password for root user: "
passwd root


# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers



umount -R /mnt

echo "--------------------------------------"
echo "--   SYSTEM READY FOR FIRST BOOT    --"
echo "--------------------------------------"
