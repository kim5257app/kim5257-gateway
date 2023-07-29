#!/bin/bash

# 관리자 권한 확인
if [ $(id -u) -ne 0 ]; then
    echo "Please run as root."
    exit
fi

# NFS 패키지 설치
apt update
apt install -y nfs-common nfs-kernel-server

# 공유폴더 생성
if [ -d "/home/$USER/nfs" ]; then
    echo "NFS shared folder already exist"
else
    mkdir /home/$USER/nfs
fi

if [ -d "/home/$USER/nfs_remote" ]; then
    echo "NFS test folder already exist"
else
    mkdir /home/$USER/nfs_remote
fi
chmod 777 /home/$USER/nfs

# 이미 설정된 경우 건너뜀
if [ `cat /etc/exports | grep "/home/$USER/nfs" | wc -l` -lt 1 ]; then
    # 공유폴더 설정
    tee -a /etc/exports <<< "/home/$USER/nfs *(rw,async)"
fi

# NFS 서비스 재시작
sudo systemctl restart nfs-kernel-server

# 연결 시험
MY_IP=`ifconfig eth0 | grep 'inet ' | awk '{ print $2}'`
TEST_FILE="TEST.tmp"

mount ${MY_IP}:/home/$USER/nfs /home/$USER/nfs_remote

touch /home/$USER/nfs_remote/${TEST_FILE}

if [ -f "/home/$USER/nfs/${TEST_FILE}" ]; then
    echo "NFS Settings complete"
else
    echo "NFS Settings failed"
fi
