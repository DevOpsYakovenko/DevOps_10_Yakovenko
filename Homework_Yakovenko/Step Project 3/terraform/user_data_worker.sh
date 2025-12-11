#!/bin/bash
apt update -y
apt install -y openjdk-17-jdk docker.io git
usermod -aG docker ubuntu
systemctl enable docker
systemctl start docker
