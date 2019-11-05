set -xe

dev=/dev/nvme0n1
dest=/cdnjs-sven

mkfs.ext4 -F $dev
mkdir -p $dest
mount $dev $dest
chmod a+w $dest

df -h $dest
