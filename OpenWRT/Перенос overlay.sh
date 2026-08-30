Перенос /overlay на внешний накопитель
Подготовить USB-флешку, два раздела с файловой системой ext4.

Воткнуть флешку в роутер. Обновить список пакетов и установить необходимые:
opkg update
opkg install kmod-usb-storage block-mount kmod-fs-ext4

В LuCi появится новый пункт меню (System → Mount Points).
Там нужно нажать кнопку Generate Config в Mount Points появятся разделы /dev/sda1

Нажать Edit возле sda1, включить Enable this mount, в качестве Mount point выбрать /overlay.

Скопировать содержимое /overlay на флешку. В терминале:

mkdir -p /tmp/extoverlay
mount /dev/sda1 /tmp/extoverlay
tar -C /overlay -cvf - . | tar -C /tmp/extoverlay -xf -
umount /tmp/extoverlay

Перезагрузить роутер