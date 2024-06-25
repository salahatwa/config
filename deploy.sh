echo "Deployment has been started";

cd /home/kayany_website/itways ;

rm -rf docker-compose.yml;

rm -rf nginx.conf;

curl -O https://raw.githubusercontent.com/salahatwa/config/main/docker-compose.yml;

curl -O https://raw.githubusercontent.com/salahatwa/config/main/nginx.conf;

sudo docker compose down ;

sudo docker rmi atwa4/crowdfunding-api:latest &&sudo docker rmi atwa4/crowdfunding-panel:latest ;

sudo docker compose pull&&sudo docker compose build ;

sudo docker compose up -d;

echo "Deployment has been done";
