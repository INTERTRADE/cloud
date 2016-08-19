#/bin/sh


#IPアドレスの設定
ETH00=/etc/sysconfig/network-scripts/ifcfg-eth0:0
cat > ${ETH00} << ETX
BOOTPROTO=static
ONBOOT=yes
IPADDR=10.132.66.162
echo "NETMASK=255.255.255.240 
ETX

service network restart

#時刻修正
mv /etc/localtime /etc/localtime.org
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
cp /etc/sysconfig/clock /etc/sysconfig/clock.org
echo 'ZONE="Asia/Tokyo"'  > /etc/sysconfig/clock