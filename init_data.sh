# 공유폴더 확인
if [ -d "/home/master/nfs" ]; then
    echo "NFS shared folder ready"
else
    echo "NFS shared folder not exist"
    exit
fi

if [ -d "/home/master/nfs/kim5257-gateway-nginx" ]; then
    echo "Nginx folder already exist"
else
    mkdir /home/master/nfs/kim5257-gateway-nginx
    mkdir /home/master/nfs/kim5257-gateway-nginx/htdocs
    mkdir /home/master/nfs/kim5257-gateway-nginx/htdocs/letsencrypt
    mkdir /home/master/nfs/kim5257-gateway-nginx/conf.d
    mkdir /home/master/nfs/kim5257-gateway-nginx/cert
fi
