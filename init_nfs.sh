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
if [ -d "/home/master/nfs" ]; then
    echo "NFS shared folder already exist"
else
    mkdir /home/master/nfs
fi

if [ -d "/home/master/nfs_remote" ]; then
    echo "NFS test folder already exist"
else
    mkdir /home/master/nfs_remote
fi
chmod 777 /home/master/nfs

# 이미 설정된 경우 건너뜀
if [ `cat /etc/exports | grep "/home/master/nfs" | wc -l` -lt 1 ]; then
    # 공유폴더 설정
    tee -a /etc/exports <<< "/home/master/nfs *(rw,async)"
fi

# NFS 서비스 재시작
sudo systemctl restart nfs-kernel-server

# 연결 시험
MY_IP=`ifconfig eth0 | grep 'inet ' | awk '{ print $2}'`
TEST_FILE="TEST.tmp"

mount ${MY_IP}:/home/master/nfs /home/master/nfs_remote

touch /home/master/nfs_remote/${TEST_FILE}

if [ -f "/home/master/nfs/${TEST_FILE}" ]; then
    echo "NFS Settings complete"
else
    echo "NFS Settings failed"
fi
