#!/bin/bash

# Порогове значення з аргументу або за замовчуванням 80%
THRESHOLD=${1:-80}

# Отримуємо поточне використання диска (%)
USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

# Якщо перевищує поріг — записати у /var/log/disk.log
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "$(date): WARNING! Disk usage is ${USAGE}% (threshold is ${THRESHOLD}%)" | sudo /usr/bin/tee -a /var/log/disk.log > /dev/null
fi

