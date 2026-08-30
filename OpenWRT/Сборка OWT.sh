https://4pda.to/forum/index.php?showtopic=821686&st=5880#entry141418733

nano /etc/resolv.conf

apt update && apt upgrade -y && apt upgrade -y && apt autoremove -y && apt clean && apt autoclean
apt install swig python3-pip python3-setuptools build-essential clang flex bison g++ gawk gcc-multilib g++-multilib gettext git libncurses5-dev libssl-dev python3-pyelftools python3-dev rsync unzip zlib1g-dev file wget ccache mkisofs sudo cmake ninja-build -y
#apt install python3-distutils -y

#####################################################
# На всякий случай создаём свап
nano swap.sh

#!/bin/bash

sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show

sudo chmod ugo+x swap.sh
./swap.sh


#####################################################
# обязательно НЕ от Рута !!!
exit !!!!


#git clone https://github.com/openwrt/openwrt.git -b v24.10.5 && cd openwrt && git checkout openwrt-24.10
#git clone https://git.openwrt.org/openwrt/openwrt.git  -b v24.10.5 --depth 1 && cd openwrt
git clone https://git.openwrt.org/openwrt/openwrt.git -b v25.12.5 --depth 1 && cd openwrt


#####################################################
#Репозитории (необязательно ?)
nano ./feeds.conf.default

src-git packages https://github.com/openwrt/packages.git;openwrt-24.10
src-git luci https://github.com/openwrt/luci.git;openwrt-24.10
src-git routing https://github.com/openwrt/routing.git;openwrt-24.10
src-git telephony https://github.com/openwrt/telephony.git;openwrt-24.10

./scripts/feeds update -a && ./scripts/feeds install -a
#./scripts/feeds update -a && ./scripts/feeds install base-files busybox

#####################################################
# Получение DTS
# в роутере: ssh root@192.168.31.1

#Вытаскиваем dtb файл с роутера 
cat /sys/firmware/fdt > /www/device-tree.dtb 

#Копируем dtb файл на линукc машиyу и получаем из него dts
dtc -I dtb -O dts device-tree.dtb -o device-tree.dts

nano device-tree.dts

#####################################################
# USB MOD
nano target/linux/ramips/dts/mt7628an_xiaomi_mi-router-4c.dts
&ehci {
status = "okay";
};
&ohci {
status = "okay";
};

#####################################################
# Внутреняя флэш МОД

nano /home/pc/openwrt/target/linux/ramips/image/mt76x8.mk
IMAGE_SIZE := 65216k

nano target/linux/ramips/dts/mt7628an_xiaomi_mi-router-4c.dts
label = "firmware";
reg = <0x160000 0x3ea0000>;


#####################################################
wget https://downloads.openwrt.org/releases/25.12.5/targets/ramips/mt76x8/config.buildinfo && mv config.buildinfo .config   # 4C
wget https://downloads.openwrt.org/releases/25.12.5/targets/ramips/mt7620/config.buildinfo && mv config.buildinfo .config   # s1010
wget https://downloads.openwrt.org/releases/25.12.5/targets/x86/64/config.buildinfo && mv config.buildinfo .config   # x64

#####################################################

# или ccache ( сильно ускоряет повторные сборки )

mkdir -p ~/.ccache
export CCACHE_DIR=~/.ccache
export CC="ccache gcc"
export CXX="ccache g++"
ccache --max-size=10G   # лимит кэша

source ~/.bashrc # или перезапустить терминал для применения

ccache -s # статус 
 ccache --show-config | grep cache_dir # Папка


make menuconfig

# Насторойка:
"
Global Build Settings --> Enable ccache. ?

Target profile --> 4C

Global build settings  ---> [] Select all target specific packages by default & [] Select all kernel module packages by default 
					---> Kernel build options  ---> [] Enable IPv6 multicast routing & [] IPv6 support for Multipath TCP
					---> [] Make debug information reproducible & [] Collect kernel debug information
					
Image configuration  ---> Preinit configuration options  ---> IP
					
Base-system --> block-mount
Kernel module --> File system --> kmod-fs-ext4
			--> USB Support -->  kmod-usb-core kmod-usb-ohci kmod-usb-storage kmod-usb-uhci
LuCI -->  Modules --> Translations  --> (RU)

# lsusb usbutils

Utilities --> docker docker-compose mc
Utilities --> Editors --> nano
Utilities --> Disc --> lsblk
Network --> File Transfer --> curl
Network --> Version Control Systems --> git-http


wpad-full вместо wpad (меньше весит)

curl
ip6tables-mod-nat
gzip
grep
git-http
"

# Если цель — несжатый root, оставьте [*] ext4, а [*] squashfs снимите



#####################################################
make -j4 V=s

make CC="ccache gcc" CXX="ccache g++" -j4 V=s
cd /bin

make target/linux/clean V=s (очистка)

#####################################################
# Прошивка через консоль

cd /tmp
wget http://192.168.1.1:800/pxeos/router/24.10-4c-sysupgrade.bin
sysupgrade -v firmware_image.bin


#####################################################
# Копирование, не разобрался
pscp pc@debian:/media/pc/123/openwrt/bin/targets/ramips/mt76x8$/openwrt-24.10-snapshot-r29233-443ec4032a-ramips-mt76x8-xiaomi_mi-router-4c-squashfs-sysupgrade.bin
scp /home/sergiy/file root@losst.pro:/root/


#####################################################
# Сборка через imagebuilder

wget https://downloads.openwrt.org/releases/25.12.5/targets/x86/64/openwrt-imagebuilder-25.12.5-x86-64.Linux-x86_64.tar.zst
mkdir -p imagebuilder
tar --zstd -xf openwrt-imagebuilder-25.12.5-x86-64.Linux-x86_64.tar.zst -C imagebuilder && cd imagebuilder

make info
make image PROFILE=generic PACKAGES="luci-base luci-i18n-attendedsysupgrade-ru luci-i18n-base-ru luci-i18n-firewall-ru luci-i18n-package-manager-ru nano-full mc git-http microsocks"

cd /home/pc/imagebuilder/bin/targets/x86/64



"
В файле feeds.conf.default отключите лишние feeds (или оставьте только packages).
Обновите feeds:
bash
./scripts/feeds update packages
./scripts/feeds install -a
"



######################
git clone https://git.openwrt.org/openwrt/openwrt.git -b v25.12.5 --depth 1 && cd openwrt && ./scripts/feeds update -a && ./scripts/feeds install -a



#Ускорение сборки (скачать инструменты для своей архитектуры)
wget https://downloads.openwrt.org/releases/25.12.5/targets/ramips/mt7620/openwrt-sdk-25.12.5-ramips-mt7620_gcc-14.3.0_musl.Linux-x86_64.tar.zst
tar --zstd -xf openwrt-sdk-25.12.5-ramips-mt7620_gcc-14.3.0_musl.Linux-x86_64.tar.zst
rm openwrt-sdk-25.12.5-ramips-mt7620_gcc-14.3.0_musl.Linux-x86_64.tar.zst
mv openwrt-sdk-25.12.5-ramips-mt7620_gcc-14.3.0_musl.Linux-x86_64 sdk
cd sdk
export PATH=$(pwd)/staging_dir/host/bin:$PATH

which quilt
# Должен показать путь вида /home/user/sdk/staging_dir/host/bin/quilt

dtc -I dts -O dtb -i . -o test.dtb mt7620a_rostelecom_s1010.dts

# Сборка тулчейна
CC="ccache gcc" CXX="ccache g++" make -j1 V=s tools/install

make -j4 V=s TARGET=ramips SUBTARGET=mt7620 package/kernel/linux/compile

make target/linux/clean







###############################################################
cd /tmp && wget http://192.168.2.234/1/st.bin
sysupgrade -v *.bin
sysupgrade -n -v  *.bin #чистая прошивка без сохранения конфигов



# Репозитории
nano /etc/apk/repositories.d/distfeeds.list