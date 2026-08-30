#Сериал СОМ Порт

nano /etc/default/grub
GRUB_CMDLINE_LINUX="console=tty0 console=ttyS0,115200"
sudo update-grub


#Пропал Windows

sudo fdisk -l /dev/sda1

nano /etc/grub.d/40_custom
sudo os-proper

nano /etc/sudoers
%pc   ALL=(ALL:ALL) ALL

menuentry "Win7" {
 insmod part_msdos
 insmod ntfs
 set root='(sda1,msdos2)'
 search --no-floppy --fs-uuid --set D2886C90886C74BF
 chainloader +1
}

sudo nano /etc/default/grub
sudo update-grub


/usr/share/images/desktop-base/

#apt install gnome-desktop-testing

apt install sudo gdm3 gnome-terminal mc

sudo shutdown -r now

nano /etc/network/interfaces
закоментировать сеть
# The primary network interface
#allow-hotplug enp0s3
#iface enp0s3 inet dhcp

ls /usr/share/xsessions/ # визуальные сессиии

Автовход
sudo nano /etc/gdm3/daemon.conf


# Новый Gnome

nano /etc/apt/sources.list
deb http://deb.debian.org/debian/ experimental main contrib
apt install -t experimental gdm3 gnome-terminal
apt-get install -t experimental gdm3

sudo apt install net-tools
sudo netstat -ntlp

#Пропал Windows

sudo fdisk -l /dev/sda1

nano /etc/grub.d/40_custom
sudo os-proper

menuentry "Win7" {
 insmod part_msdos
 insmod ntfs
 set root='(sda1,msdos2)'
 search --no-floppy --fs-uuid --set D2886C90886C74BF
 chainloader +1
}

sudo update-grub




#apt install gnome-desktop-testing

apt install sudo gdm3 gnome-terminal

sudo shutdown -r now

nano /etc/network/interfaces
закоментировать сеть
# The primary network interface
#allow-hotplug enp0s3
#iface enp0s3 inet dhcp

Автовход
sudo nano /etc/gdm3/daemon.conf


# Новый Gnome

nano /etc/apt/sources.list
deb http://deb.debian.org/debian/ experimental main contrib
apt -t install experimental gdm3 gnome-terminal

