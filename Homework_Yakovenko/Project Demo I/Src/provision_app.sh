#!/bin/bash
apt update
apt install -y git openjdk-17-jdk unzip

useradd -m -s /bin/bash appuser || echo "Користувач вже існує"
su - appuser -c "git clone https://github.com/spring-projects/spring-petclinic.git"
su - appuser -c "cd spring-petclinic && ./mvnw clean package"

