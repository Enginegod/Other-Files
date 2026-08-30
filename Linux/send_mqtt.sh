#!/bin/bash

command=$1
code=1781581463
topic=m25yyuluh02
server=test.mosquitto.org
#server='192.168.1.1'
ipaddr=$(curl ifconfig.me)
#ipaddr='178.168.1.1'
ipif=${ipaddr%%.*}
echo "command"
echo "server: $server"
echo "ipaddr:  $ipaddr"
echo "ipif:  $ipaddr"
if [[ $ipif -eq 178 ]]
then
  echo "178 OK! $ipif"
else
  echo "178 ERROR, $ipif"
  command = 0
fi
ipaddr=${ipaddr//178/192}
echo "ip coded:  ipaddr"
if [[ $command -eq $code ]]
then
  echo "OK! $ipif"
  mosquitto_pub -h $server -t $topic -m $ipaddr
else
  echo "ERROR, $ipif"
  mosquitto_pub -h $server -t $topic -m "err $ipif"
fi