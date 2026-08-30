#####################################
# Межсетевой мост

luci-proto-relay
# возможно понадобится
bridge
kmod-nft-bridge

#####################################
# Прокси SOCKS OpenWRT

opkg install microsocks

nano /etc/config/microsocks

config microsocks 'config'
         option enabled '1'
         option bindaddr ''
         option listenip ''
         option port '1081'  # Настроить проброс
         option user ''
         option password ''
         option auth_once '0'
         option quiet '1'


/etc/init.d/microsocks restart
/etc/init.d/microsocks status