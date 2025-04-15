1. Створено користувача `bob`
2. Додано до групи `sudo`
3. Створено скрипт `/home/bob/set_hostname.sh` для зміни hostname на `ubuntu22`
4. Виконано скрипт та змінено hostname
5. Увійдено під користувачем `bob`
6. Встановлено `nginx`
7. Перевірено `systemctl status nginx` — nginx працює
8. Перевірено відкриті порти через `netstat -tuln` — порт `80` слухає
