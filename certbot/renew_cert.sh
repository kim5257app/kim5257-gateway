#!/bin/bash

cd "$(dirname "$0")"

# 폴더 정리
rm -rf ./archive
rm -rf ./live
rm -rf ./renewal
rm -rf ./renewal-hooks

idx=1
while read line || [ -n "$line" ] ; do
    echo "Renew $line.";
    bash ./certbot_run.sh $line >> certbot_run.log;
    ((idx+=1))
done < domain_list.txt

docker exec `docker container ls -f "name=kim5257_gateway_nginx" --format "{{.Names}}"` service nginx reload
