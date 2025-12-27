#!/bin/bash
set -e

# Update system
apt-get update -y

# Install Java (REQUIRED for Jenkins agent)
apt-get install -y openjdk-17-jre

# Install basic tools (safe)
apt-get install -y curl wget git unzip

# Setup SSH for ubuntu user
mkdir -p /home/ubuntu/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC840uOV3mhgebSfx4VgQ4iyUtuGwbMICaCV1IHBRfb/Kp6KmsieuQTIV38bUrEsLv0oqc8dkaKE5E2baKD9nf+sx7GSLSU/NHgqWYxgiTT0yXc9NdDUbFWjSE6M96tVvgx8t+cEPp/y9Gv/TXD83JENHildzhrMMy5Epkgpauuywe/uA/OEkaBWGSsR1X+Ke4enAoygl0MGaPSBJlQpotLsDKLl0H0sVLQo3TL1ecReC4tDBro08mBV/lemfGrFjv5M7rrBuSwy9E3fRfKpJmBxeMylwbfTHPCFmKP8hRYpPnyD0aR6F9O848vUhAXzltYUMBJmsn19PFYlcC9q4M+WsBTNe9pHFxtf7+SLVgKJttaDeBKFZNrhhKC6+Y+Bf3OR+fD9mDu0zbNa53nCnFec/TDYtxOvaT9tSLecah5Coz16wkHvUk3mtkTmW2tpKl6OVnTxeX0C7GpxnxUoNPQM/hAqyyp+zaRMA0VT38E6dxWWtWrBKG8Al9jE/p9SkxOzVGzIyrYYqkExnYiyiIgBPd+GUTaZgKS6zfWDxPmjTeCZIzU6TMpmLJ2YXBsX/ThwIJve6HJHvoSHJydKg1bj2bRaproMvXWdaUKTMA/93LjfcizFW0pFgL+02UL+FyBDzS37pm8fuEBBe5BHlpuLFF52/Ug1FFmVlzNL/pkBw== yakovenko-jenkins-main" > /home/ubuntu/.ssh/authorized_keys

chown -R ubuntu:ubuntu /home/ubuntu/.ssh
chmod 700 /home/ubuntu/.ssh
chmod 600 /home/ubuntu/.ssh/authorized_keys

# Verify Java install
java -version > /var/log/java_version.log 2>&1
