#!/usr/bin/env bash
apt-get update
apt-get install -y parted

parted -s -a optimal /dev/sdb mklabel gpt -- mkpart primary ext4 0% 100%
mkfs.ext4 /dev/sdb1
chown -R vagrant /mnt
mount /dev/sdb1 /mnt
chown -R vagrant /mnt
echo '/dev/sdb1 /mnt ext4 defaults 0 0' >> /etc/fstab
ln -s /mnt /home/vagrant/deployed
chown -R vagrant /home/vagrant/deployed
