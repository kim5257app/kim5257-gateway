#!/bin/bash

CONF_HOME=/home/$USER/nfs/kim5257-gateway-nginx/conf.d
CERT_HOME=/home/$USER/nfs/kim5257-gateway-nginx/cert

if [ $# -ne 2 ] ; then
    echo "도메인 이름을 인자로 넣어야 합니다."
    exit -1;
fi

mkdir $CERT_HOME/$1
cp ./dummy_cert/* $CERT_HOME/$1

sed "s/\$domain/$1/g" template.conf | sed "s/\$server_name/$2/g" > $CONF_HOME/$1.conf

docker exec `docker container ls -f "name=kim5257_gateway_nginx" --format "{{.Names}}"` service nginx reload

bash ./certbot_run.sh $1

docker exec `docker container ls -f "name=kim5257_gateway_nginx" --format "{{.Names}}"` service nginx reload
