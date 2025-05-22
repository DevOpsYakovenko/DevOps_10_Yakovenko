#!/bin/bash
set -e

cd /home/appuser
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
chmod +x mvnw
./mvnw package
cp target/*.jar /home/appuser/

