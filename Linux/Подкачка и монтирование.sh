_______Swap________

nano swap.sh

#!/bin/bash

#sudo fallocate -l 2G /swapfile
sudo dd if=/dev/zero of=/swapfile bs=1M count=2048
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show


sudo chmod ugo+x swap.sh
./swap.sh


sudo swapoff /swapfile # отключить подкачку




___________Автозагрузка swap_____________

sudo nano /lib/systemd/system/swapfile.service


[Unit]
Description=SWAP File Service
After=multi-user.target
[Service]
Type=idle
ExecStart=/usr/local/bin/swap.sh
[Install]
WantedBy=multi-user.target

sudo chmod u+x /usr/local/bin/swap.sh
sudo chmod 644 /lib/systemd/system/swapfile.service
sudo systemctl daemon-reload
sudo systemctl enable swapfile.service

sudo systemctl status swapfile.service

# Запущенные службы
systemctl list-unit-files | grep swap


_______Disk_______

sudo blkid
sudo mount -v /dev/sda2 /mnt/
sudo umount /mnt



_______Zram_______

sudo nano /etc/default/grub

GRUB_CMDLINE_LINUX_DEFAULT=".... zram.num_devices=1"

sudo update-grub

sudo nano /usr/local/bin/zram.sh

#!/bin/bash
sudo modprobe zram num_devices=1
echo '512M' > /sys/block/zram0/disksize
sudo mkswap /dev/zram0
sudo swapon /dev/zram0 -p 10

sudo chmod ugo+x /usr/local/bin/zram.sh  # сделать исполняемым

free -h

_________RAM Disk_________

sudo nano /usr/local/bin/ramdisk.sh

#!/bin/bash
sudo mkdir /cache
sudo chmod 777 /cache
sudo mount -t tmpfs -o size=128M tmpfs /cache

sudo chmod ugo+x /usr/local/bin/ramdisk.sh

---------------------------
sudo mkdir /var/www/html/ram
sudo chmod 777 /var/www/html/ram
sudo mount -t tmpfs -o size=128M tmpfs /var/www/html/ram


# Создать файл
sudo dd if=/dev/zero of=/var/www/html/ram/file.img bs=1M count=128 && cd /var/www/html/ram && ls

___________Автозагрузка скрипта_____________

sudo nano /lib/systemd/system/ramdisk.service


[Unit]
Description=RAM Disk Service
After=multi-user.target
[Service]
Type=idle
ExecStart=/usr/local/bin/ramdisk.sh
[Install]
WantedBy=multi-user.target

sudo chmod u+x /usr/local/bin/ramdisk.sh
sudo chmod 644 /lib/systemd/system/ramdisk.service
sudo systemctl daemon-reload
sudo systemctl enable ramdisk.service

sudo systemctl status ramdisk.service


# Запущенные службы
systemctl list-unit-files | grep ram

























