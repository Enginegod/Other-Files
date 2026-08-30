
apt install -y samba

mkdir -p /home/pc/share

chown pc:pc /home/pc/share && chmod 777 /home/pc/share

mv /etc/samba/smb.conf /etc/samba/smb.conf.orig

nano /etc/samba/smb.conf

[global]
        log file = /var/log/samba/log.%m
        map to guest = Bad User
        max log size = 1000
        security = USER
        server role = standalone server
[share]
        comment = Общая папка
        create mask = 0666
        directory mask = 0777
        force directory mode = 0777
        guest ok = Yes
        path = /home/pc/share
        read only = No
		


testparm

systemctl restart smb && systemctl status smb

smbpasswd -a pc