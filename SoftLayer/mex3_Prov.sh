#/bin/sh

# インターフェース無効化
sed -i -e "s/ONBOOT=yes/ONBOOT=no/g"  /etc/sysconfig/network-scripts/ifcfg-eth1

# IPアドレスの設定
ETH00=/etc/sysconfig/network-scripts/ifcfg-eth0:0
cat > ${ETH00} << ETX
BOOTPROTO=static
ONBOOT=yes
IPADDR=10.132.66.162
echo "NETMASK=255.255.255.240 
ETX

# マルチキャストルーティング追加
echo "any net 239.0.0.0/8 dev eth0" >> /etc/sysconfig/static-routes

# NWサービス再起動
service network restart

# 時刻修正
mv /etc/localtime /etc/localtime.org
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
cp /etc/sysconfig/clock /etc/sysconfig/clock.org
echo 'ZONE="Asia/Tokyo"'  > /etc/sysconfig/clock

# カーネルパラメータの変更
cp -p /etc/sysctl.conf /etc/sysctl.conf.org
cat >> ${ETH00} << ETX
# Add
kernel.sem = 250 32000 128 1000
net.core.rmem_default = 1048756
net.core.wmem_default = 262144
kernel.shmmni = 4096
net.core.rmem_max = 33554432
net.core.wmem_max = 1048576
net.ipv4.ip_local_port_range = 30001 65500
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
net.core.netdev_max_backlog = 2000
ETX

