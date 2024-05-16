#Устанавливаем spawn-fcgi и необходимые для него пакеты:

yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y

cat /etc/sysconfig/spawn-fcgi

#

#vi /etc/sysconfig/spawn-fcgi

sed -i 's/#SOCKET/SOCKET/g' /etc/sysconfig/spawn-fcgi
sed -i 's/#OPTIONS/OPTIONS/g' /etc/sysconfig/spawn-fcgi

# You must set some working options before the "spawn-fcgi" service will work.
# If SOCKET points to a file, then this file is cleaned up by the init script.
#
# See spawn-fcgi(1) for all possible options.
#
# Example :
#SOCKET=/var/run/php-fcgi.sock
#OPTIONS="-u apache -g apache -s $SOCKET -S -M 0600 -C 32 -F 1 -- /usr/bin/php-cgi"

#Дополнить юнит-файл apache httpd возможностью запустить несколько инстансов
cat  << EOF > /etc/systemd/system/spawn-fcgi.service
[Unit]
Description=Spawn-fcgi startup service by Otus
After=network.target

[Service]
Type=simple
PIDFile=/var/run/spawn-fcgi.pid
EnvironmentFile=/etc/sysconfig/spawn-fcgi
ExecStart=/usr/bin/spawn-fcgi -n $OPTIONS
KillMode=process

[Install]
WantedBy=multi-user.target
EOF


systemctl start spawn-fcgi
systemctl status spawn-fcgi