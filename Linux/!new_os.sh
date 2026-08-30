apt update && apt upgrade -y && apt upgrade -y && apt autoremove -y && apt clean && apt autoclean

apt install sudo nano mc git wget curl htop -y

cat<<EOL >> /etc/sudoers

%pc   ALL=(ALL:ALL) ALL
EOL

nano /etc/resolv.conf
nameserver 1.1.1.1

# Автовход
sudo nano /etc/gdm3/daemon.conf

x11vnc -display :0 -rfbport 5900

#Уменьшить таймаут
sudo nano /etc/default/grub
GRUB_TIMEOUT=5
sudo update-grub



nano /etc/resolv.conf

apt --fix-broken install

pwd # Путь до каталога

# настрока ip
nano /etc/network/interfaces

auto enp0s3
iface enp0s3 inet static
	address 192.168.1.62/24
	gateway 192.168.1.3
	netmask 255.255.255.0
	dns-nameservers 8.8.8.8