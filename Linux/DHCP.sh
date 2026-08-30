sudo apt install isc-dhcp-server -y

ip a

nano /etc/network/interfaces

auto enp4s2***
iface enp4s2 inet static
        address 192.168.1.1/24
        gateway 192.168.1.3
        netmask 255.255.255.0
        dns-nameservers 8.8.8.8

auto enp3s0***
iface enp3s0 inet static
        address 192.168.168.10/24
        netmask 255.255.255.0
#       dns-nameservers 8.8.8.8


nano /etc/default/isc-dhcp-server
вписать название сетевого интерфейса (например enp3s1)

sudo service isc-dhcp-server stop

cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.old

:> /etc/dhcp/dhcpd.conf

nano /etc/dhcp/dhcpd.conf

subnet 192.168.1.0 netmask 255.255.255.224 {
range 192.168.1.10 192.168.1.29;
option domain-name-servers 1.1.1.1;
option domain-name "HA";
option routers 192.168.1.1;
option broadcast-address 192.168.1.255;
default-lease-time 6000;
max-lease-time 7200;
}

# Разрешить форвартинг
nano /etc/sysctl.conf
net.ipv4.ip_forward=1 # Разрешить форвартинг
kernel.dmesg_restrict=0 # Открыть доступ к логам

#
sudo iptables -t nat -A POSTROUTING -s 192.168.2.0/24 ! -d 192.168.2.0/24 -j MASQUERADE

sudo systemctl restart isc-dhcp-server.service

sudo systemctl status isc-dhcp-server.service


192.168.1.1 -- HA server
192.168.1.3 -- PC gateway
192.168.1.4 -- 3COM prime
192.168.1.5 -- 3COM satelit

DHCP от 10 до 29