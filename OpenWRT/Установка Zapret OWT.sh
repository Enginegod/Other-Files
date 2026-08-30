####################################
# Новый от бол-вана
mkdir /opt && cd /opt
wget https://github.com/bol-van/zapret/releases/download/v72.13/zapret-v72.13-openwrt-embedded.tar.gz
# Распаковать
./install_bin.sh
./install_prereq.sh
./install_easy.sh


####################################
# Старый рабочий вариант

Заходим в роутер. Делаем обновление. Смотрим какая архитектура
https://downloads.openwrt.org/releases/24.10.5/packages/mipsel_24kc/base/Packages.sig
Архитектура mipsel_24kc

Заходим https://github.com/remittor/zapret-openwrt/releases

Качаем на комп например:
https://github.com/remittor/zapret-openwrt/releases/download/v72.20260307/zapret_v72.20260307_mipsel_24kc.zip

Распаковываем
И т.д.


####################################
# Вариант от ИИ
Способ 1: Быстрая установка (рекомендуется для устройств с достаточным объемом ОЗУ)
Этот метод не требует форматирования диска или настройки дополнительных репозиториев. Все файлы временно размещаются в оперативной памяти (/tmp).
Подготовка. Убедитесь, что роутер подключен к интернету. Зайдите в веб-интерфейс LuCI (Система → Программное обеспечение) и установите пакеты wget, unzip и openssh-sftp-server (для удобства передачи файлов), если они отсутствуют.
Загрузка архива. Подключитесь к роутеру по SSH. Перейдите во временную папку:
cd /tmp
Скачайте последнюю версию Zapret:
wget https://github.com/bol-van/zapret/archive/refs/heads/master.zip -O zapret.zip
Распакуйте архив:
unzip zapret.zip && rm zapret.zip
Запустите установку:
cd zapret-master
chmod +x install_easy.sh
./install_easy.sh
В процессе скрипт задаст вопросы. Для большинства задач подходят следующие ответы:
Установить grep? — Можно ответить N (No) для экономии места.
Режим работы (MODE): выберите tpws. Это наиболее универсальный режим.
Включить обработку HTTP? — Y.
Включить обработку HTTPS? — Y.
Включить Keep-Alive? — Y.
Настройка автозапуска. Чтобы правила работали после перезагрузки, добавьте запуск сервиса в системный планировщик (cron) или инициализацию. Самый простой способ в современных версиях OpenWRT:
ln -s /tmp/zapret-master/init.d/openwrt/S99zapret /etc/rc.d/S99zapret
Очистка. Удалите временные файлы из /tmp, чтобы освободить оперативную память:
cd .. && rm -rf zapret-master


####################################
# Старый рабочий вариант 2
cd /tmp && wget http://192.168.1.1:800/zapret-v70.5.tar.gz
 
tar xzf zapret-v70.5.tar.gz && rm zapret-v70.5.tar.gz && mv zapret-v70.5 zapret
 
cd /tmp/zapret/ipset/ && wget http://192.168.1.1:800/zapret-hosts-auto.txt && cat zapret-hosts-auto.txt

cd /tmp/zapret && rm config && wget http://192.168.1.1:800/config

./install_bin.sh && ./install_prereq.sh && wget http://192.168.1.1:800/zz && chmod u+x zz
 
./zz



