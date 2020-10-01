
#!/usr/bin/env bash
# make filesystems
echo -e "\nCreating Filesystems...\n$HR"

mkfs.vfat -F32 -n "UEFISYS" "${DISK}1"
mkfs.ext4 -L "ROOT" "${DISK}2"
mkfs.ext4 -L "linuxfilesystem" "${DISK}2"

# mount target

mount -t ext4 "${DISK}2" /mnt
mkdir /mnt/home
mount -t vfat "${DISK}3" /mnt/home/
mkdir /mnt/etc

mount
