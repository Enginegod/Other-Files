zcat debian-bookworm-arm64-uch4ai.bin.gz > sd-card.img


f8bd477d-9bdc-4a48-8eee-77d06dc8661b

dd if=sd-card.img of=/dev/sdb2



ls -la /dev/disk/by-uuid/

umount /dev/sdb1
sudo tune2fs /dev/sdb1 -U 1cd02f0e-6974-4cc1-ba5b-9fc6db941dfe



wget https://dl.sd-card-images.johang.se/boots/2024-06-01/boot-raspberrypi_3b.bin.gz
wget https://dl.sd-card-images.johang.se/debians/2024-06-17/debian-bullseye-arm64-quoeg9.bin.gz
zcat boot-raspberrypi_3b.bin.gz debian-bullseye-arm64-quoeg9.bin.gz > sd-card.img
dd if=sd-card.img of=/dev/sdXXX # .
