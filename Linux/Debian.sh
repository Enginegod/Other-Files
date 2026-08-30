# История
nano /home/pc/.bashrc
nano /root/.bashrc

HISTSIZE=1000000
HISTFILESIZE=1000000


nano /etc/apt/sources.list
apt-cdrom add ## добавить файлы с сд

#deb https://deb.debian.org/debian experimental main

deb http://deb.debian.org/debian/ bookworm main contrib
deb-src http://deb.debian.org/debian/ bookworm main contrib

deb http://security.debian.org/debian-security bookworm-security main
deb-src http://security.debian.org/debian-security bookworm-security main

deb http://deb.debian.org/debian/ bookworm-updates main
deb-src http://deb.debian.org/debian/ bookworm-updates main

deb http://deb.debian.org/debian/ bookworm-backports main contrib
# обновления
#deb http://ftp.ru.debian.org/debian/ bookworm-backports main contrib non-free

nano /etc/apt/sources.list

Дистрибутивы Debian
1 -- Buzz Rex Bo
2 -- Hamm Slink Potato
3 -- Woody Sarge
4 -- etch
5 -- lenny
6 -- squeeze
7 -- wheezy
8 -- jessie
9 -- stretch
10 -- buster
11 -- bullseye
12 -- bookworm
13 -- trixie

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ********

sudo update-grub

sudo shutdown -r now
