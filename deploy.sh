sed "s/\$USER/$USER/g" docker-compose.yml.template > docker-compose.yml
docker stack deploy --with-registry-auth --compose-file docker-compose.yml kim5257_gateway
