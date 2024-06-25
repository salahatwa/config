echo "Deployment has been started";

cd /home/kayany_website/itways ;

sudo docker compose down ;

sudo docker rmi atwa4/crowdfunding-api:latest &&sudo docker rmi atwa4/crowdfunding-panel:latest ;

sudo docker compose pull&&sudo docker compose build ;

sudo docker compose up -d;

echo "Deployment has been done";
