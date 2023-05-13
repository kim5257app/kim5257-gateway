#!/bin/bash

# 관리자 권한 확인
if [ $(id -u) -ne 0 ]; then
    echo "Please run as root."
    exit
fi

snap install core
snap refresh core
ln -s /snap/bin/certbot /usr/bin/certbot
