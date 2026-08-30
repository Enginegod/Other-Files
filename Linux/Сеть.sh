# настрока ip
nano /etc/network/interfaces

auto enp0s3
iface enp0s3 inet static
	address 192.168.1.234/24
	gateway 192.168.1.3
	netmask 255.255.255.0
	dns-nameservers 8.8.8.8

# настройка DNS
nano /etc/resolv.conf

# Сканер ip
nmap 192.168.1.1-100

# Загрузка сети
nload -t 1000

# Разрешить форвартинг
nano /etc/sysctl.conf
net.ipv4.ip_forward=1

#
sudo iptables -t nat -A POSTROUTING -s 192.168.1.0/24 ! -d 192.168.1.0/24 -j MASQUERADE

# как узнать каким маршрутом linux добирается до сайта
traceroute ya.ru
traceroute 1.1.1.1
