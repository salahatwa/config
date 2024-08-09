echo "Deployment has been started";

cd /home/kayany_website/itways ;

sudo docker network create webnet;

sudo rm -rf docker-compose.yml;

sudo rm -rf nginx.conf;

sudo curl -O https://raw.githubusercontent.com/salahatwa/config/main/docker-compose.yml;

sudo curl -O https://raw.githubusercontent.com/salahatwa/config/main/nginx.conf;

sudo docker compose down ;

sudo docker rmi atwa4/crowdfunding-api:latest &&sudo docker rmi atwa4/crowdfunding-panel:latest && sudo docker rmi nginx:latest ;

sudo docker compose pull&&sudo docker compose build ;

sudo docker compose up;

echo "Deployment has been done";
