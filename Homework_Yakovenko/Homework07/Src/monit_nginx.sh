#!/bin/bash

# Скрипт створює конфіг Monit для nginx

cat <<EOF | sudo tee /etc/monit/conf-enabled/nginx
check process nginx with pidfile /run/nginx.pid
    start program = "/usr/sbin/service nginx start"
    stop program  = "/usr/sbin/service nginx stop"
    if failed host 127.0.0.1 port 80 protocol http then restart
    if 7 restarts within 7 cycles then timeout
EOF
