#!/bin/bash

# Додавання appuser, якщо ще не існує
if ! id "appuser" &>/dev/null; then
  sudo useradd -m -s /bin/bash appuser
  echo "[INFO] Користувач appuser створений."
else
  echo "[INFO] Користувач appuser вже існує."
fi

# Клонування PetClinic репозиторію та збірка
sudo -u appuser bash <<EOF
cd /home/appuser
if [ ! -d "spring-petclinic" ]; then
  git clone https://github.com/spring-projects/spring-petclinic.git
fi
cd spring-petclinic
./mvnw package
cp target/*.jar /home/appuser/
EOF

echo "✅ Готово: appuser створено та PetClinic зібрано."

