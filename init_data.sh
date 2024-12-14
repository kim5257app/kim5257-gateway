# 공유폴더 확인
if [ -d "/home/$USER/nfs" ]; then
    echo "NFS shared folder ready"
else
    echo "NFS shared folder not exist"
    exit
fi

if [ -d "/home/$USER/nfs/kim5257-gateway-nginx" ]; then
    echo "Nginx folder already exist"
else
    mkdir /home/$USER/nfs/kim5257-gateway-nginx
    mkdir /home/$USER/nfs/kim5257-gateway-nginx/htdocs
    mkdir /home/$USER/nfs/kim5257-gateway-nginx/htdocs/letsencrypt
    mkdir /home/$USER/nfs/kim5257-gateway-nginx/conf.d
    mkdir /home/$USER/nfs/kim5257-gateway-nginx/cert
fi

if [ -d "/home/$USER/nfs/kim5257-gateway-nameserver" ]; then
    echo "Nameserver folder already exist"
else
    mkdir /home/$USER/nfs/kim5257-gateway-nameserver
    mkdir /home/$USER/nfs/kim5257-gateway-nameserver/config
    mkdir /home/$USER/nfs/kim5257-gateway-nameserver/config/zone
    cp ./data/nameserver/* /home/$USER/nfs/kim5257-gateway-nameserver/config
fi
