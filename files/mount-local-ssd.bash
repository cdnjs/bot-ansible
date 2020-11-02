set -xe

dest=/cdnjs

vgcreate nvme /dev/nvme0n1 /dev/nvme0n2
lvcreate -i2 -I32 -l100%FREE -ncdnjs nvme
mkfs.ext4 /dev/nvme/cdnjs

mkdir -p $dest
mount /dev/nvme/cdnjs $dest
chmod a+w $dest

df -h $dest
