
#####################################
#Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия #ключевого слова. Файл и слово должны задаваться в /etc/sysconfig
#####################################
 
#Создаем файл с конфигурацией для сервиса в директории /etc/sysconfig
 
cat << EOF > /etc/sysconfig/watchlog
# Configuration file for my watchlog service
# Place it to /etc/sysconfig
# File and word in that file that we will be monit
WORD="ALERT"

LOG=/var/log/watchlog.log
EOF

#создаем /var/log/watchlog.log и пишем туда строки на своё усмотрение,
#плюс ключевое слово ‘ALERT’

cat  << EOF > /var/log/watchlog.log
system
system
system
ALERT
EOF


#Создем скрипт
cat  << EOF > /opt/watchlog.sh
#!/bin/bash

WORD=$1
LOG=$2
DATE=`date`

if grep $WORD $LOG &> /dev/null
then
logger "$DATE: I found word, Master!"
else
exit 0
fi
EOF

#Команда logger отправляет лог в системный журнал
chmod +x /opt/watchlog.sh

#Создадим юнит для сервиса:
cat << EOF > /etc/systemd/system/watchlog.service
[Unit]
Description=My watchlog service

[Service]
Type=oneshot
EnvironmentFile=/etc/sysconfig/watchlog
ExecStart=/opt/watchlog.sh $WORD $LOG
EOF


#Создадим юнит для таймера:

cat << EOF > /etc/systemd/system/watchlog.timer
[Unit]
Description=Run watchlog script every 30 second

[Timer]
# Run every 30 second
OnUnitActiveSec=30
Unit=watchlog.service

[Install]
WantedBy=multi-user.targetstart
EOF



systemctl daemon-reload

systemctl start watchlog.timer

tail /var/log/messages










