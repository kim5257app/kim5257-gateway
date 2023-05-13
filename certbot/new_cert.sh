#!/bin/bash

CONF_HOME=/home/cnslink/nfs/kim5257-gateway-nginx/conf.d
CERT_HOME=/home/cnslink/nfs/kim5257-gateway-nginx/cert

if [ $# -ne 2 ] ; then
    echo "도메인 이름을 인자로 넣어야 합니다."
fi

mkdir $CERT_HOME/$1
cp ./dummy_cert/* $CERT_HOME/$1

sed "s/\$domain/$1/g" template.conf | sed "s/\$server_name/$2/g" > $CONF_HOME/$1.conf

docker service update --force kim5257_gateway_nginx

bash ./certbot_run.sh $1

docker service update --force kim5257_gateway_nginx
