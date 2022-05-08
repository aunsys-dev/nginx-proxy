#!/bin/bash
echo Input IP server tujuan:
read proxy_pass


docker-compose -f /root/npm/docker-compose.yml down

apt install nginx -y
rm /etc/nginx/sites-available/proxy.conf
rm /etc/nginx/sites-enabled/proxy.conf

rm /etc/nginx/sites-available/proxy.conf
rm /etc/nginx/sites-enabled/proxy.conf

wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/aunsys-dev/nginx-proxy/master/nginx.conf"
wget -O /etc/nginx/sites-available/proxy.conf "https://raw.githubusercontent.com/aunsys-dev/nginx-proxy/master/proxy-nonportHTTP.conf"
ln -s /etc/nginx/sites-available/proxy.conf /etc/nginx/sites-enabled/
service nginx restart

#setup vhost
IP=`curl -s ifconfig.me`;

sed -i "s/x.x.x.x/$IP/g" /etc/nginx/sites-available/proxy.conf
sed -i "s/y.y.y.y/$proxy_pass/g" /etc/nginx/sites-available/proxy.conf

service nginx restart
service nginx reload
