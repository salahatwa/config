echo "Deployment has been started";

cd /home/kayany_website/itways/itways-ai;

sudo chmod 777 /var/run/docker.sock;

sudo docker network create webnet;

sudo rm -rf docker-compose.yml;

sudo rm -rf nginx.conf;

curl -O https://raw.githubusercontent.com/salahatwa/config/itways-ai/docker-compose.yml;

curl -O https://raw.githubusercontent.com/salahatwa/config/itways-ai/nginx.conf;

sudo docker compose down;

sudo docker rmi atwa4/itways-ai-api:latest && sudo docker rmi nginx:latest ;

sudo docker compose pull && sudo docker compose build ;

sudo docker compose up;

echo "Deployment has been done success :)";
