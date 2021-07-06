#!/bin/bash


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
#pacman -S --noconfirm --needed pacman-contrib curl
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

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
mv /ArchInst/locale.gen /etc/locale.gen
locale-gen
echo "Dspate81" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 Dspates81.localdomain Dspates81" >> /etc/hosts


echo "--------------------------------------"
echo "-- Arch Install on Main Drive       --"
echo "--------------------------------------"


dd if=/dev/zero of=swapfile bs=1M count=1024 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

echo "
/swapfile		none	swap	defaults	0 0
" >> /etc/fstab

pacman -S --needed grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers wireless_tools intel-ucode xdg-utils xdg-user-dirs bash-completion openssh rsync cronie ipset iptables iptables-nft bluez bluez-utils terminus-font tlp reflector openbsd-netcat os-prober

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm



# cups
# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings


systemctl enable NetworkManager


grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
mv /ArchInst/grub /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

mv /ArchInst/mkinitcpio.conf /etc/
mkinitcpio -p linux

sleep 5

# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers






printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

