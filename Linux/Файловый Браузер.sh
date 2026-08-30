https://tonyteaches.tech/filebrowser-tutorial/


curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

sudo nano /etc/filebrowser/default.json


{
  "port": 80,
  "baseURL": "",
  "address": "",
  "log": "stdout",
  "database": "/etc/filebrowser/filebrowser.db",
  "root": "/"
}


/etc/apache2/ports.conf