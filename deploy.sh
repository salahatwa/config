echo "Deployment has been started";

sudo chmod 777 /var/run/docker.sock;

sudo docker network create webnet;

sudo rm -rf docker-compose.prod.yml;

curl -O https://raw.githubusercontent.com/salahatwa/config/dynamic-platform/docker-compose.prod.yml;

curl -O https://raw.githubusercontent.com/salahatwa/config/main/.env.production;

sudo docker compose down;

sudo docker rmi salahatwa2035/dynamic-platform-api:latest;

sudo docker compose pull && sudo docker compose build ;

sudo docker compose -f docker-compose.prod.yml --env-file .env.production up -d ;

echo "Deployment has been done success :)";
