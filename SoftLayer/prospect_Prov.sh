#/bin/sh

# インターフェース無効化
sed -i -e "s/ONBOOT=yes/ONBOOT=no/g"  /etc/sysconfig/network-scripts/ifcfg-eth1

# IPアドレスの設定
ETH00=/etc/sysconfig/network-scripts/ifcfg-eth0:0
cat > ${ETH00} << ETX
BOOTPROTO=static
ONBOOT=yes
IPADDR=10.132.66.163
echo "NETMASK=255.255.255.240 
ETX

# NWサービス再起動
service network restart

# 時刻修正
mv /etc/localtime /etc/localtime.org
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
cp /etc/sysconfig/clock /etc/sysconfig/clock.org
echo 'ZONE="Asia/Tokyo"'  > /etc/sysconfig/clock
