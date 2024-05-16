#####
#####3 сервера с разными конфигами

###Создаем шаблон
cat << EOF > /usr/lib/systemd/system/httpd.service

[Unit]
Description=The Apache HTTP Server
Wants=httpd-init.service

After=network.target remote-fs.target nss-lookup.target httpd-
init.service

Documentation=man:httpd.service(8)

[Service]
Type=notify
Environment=LANG=C
EnvironmentFile=/etc/sysconfig/httpd-%I
ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND
ExecReload=/usr/sbin/httpd $OPTIONS -k graceful
# Send SIGWINCH for graceful stop
KillSignal=SIGWINCH
KillMode=mixed
PrivateTmp=true

[Install]
WantedBy=multi-user.target

EOF


#в окружении задается  опция для запуска веб-сервера с необходимым конфигурационным файлом
cat << EOF > /etc/sysconfig/httpd-first

OPTIONS=-f conf/first.conf

EOF

cat << EOF > /etc/sysconfig/httpd-second

OPTIONS=-f conf/second.conf

EOF

cat << EOF > /etc/httpd/conf/first.conf

PidFile /var/run/httpd-first.pid
Listen 8080

EOF

№создаются конфиги
cat << EOF > /etc/httpd/conf/second.conf

PidFile /var/run/httpd-second.pid
Listen 8081

EOF

#Старт
systemctl start httpd@first
systemctl start httpd@second
#Проврка
 ss -tnulp | grep httpd