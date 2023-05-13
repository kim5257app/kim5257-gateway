#!/bin/bash

cd "$(dirname "$0")"

idx=1
while read line || [ -n "$line" ] ; do
    echo "Renew $line.";
    bash ./certbot_run.sh $line >> certbot_run.log;
    ((idx+=1))
done < domain_list.txt
