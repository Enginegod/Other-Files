pacman-key --populate
pacman -S archlinux-keyring
pacman-key --init

pacman -Sc # apt clean
pacman -Scc

pacman -Sy  # update
pacman -Suy # upgrade

# rm /var/lib/pacman/db.lck
# cd /var/cache/pacman/pkg/
sudo rm /var/lib/pacman/db.lck

pacman -S mc sudo git

#pacman -Syy gnupg archlinux-keyring --ignore
#pacman -S archlinux-keyring  --ignore

tar -xvf  archive.tar.xz

DNS
nano /etc/systemd/resolved.conf
DNS=8.8.8.8