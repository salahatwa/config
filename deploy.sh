echo "Deployment has been started";

cd /home/kayany_website/itways ;

sudo chmod 777 /var/run/docker.sock;

sudo docker network create webnet;

sudo rm -rf docker-compose.yml;

sudo rm -rf nginx.conf;

curl -O https://raw.githubusercontent.com/salahatwa/config/main/docker-compose.yml;

curl -O https://raw.githubusercontent.com/salahatwa/config/main/nginx.conf;

sudo docker compose down -d;

sudo docker rmi atwa4/crowdfunding-api:latest && sudo docker rmi atwa4/crowdfunding-panel:latest && sudo docker rmi atwa4/crowdown-panel:latest && sudo docker rmi nginx:latest ;

sudo docker compose pull && sudo docker compose build ;

sudo docker compose up;

echo "Waiting for Ollama container to be ready...";
sleep 20  # wait 20 seconds for Ollama to start (adjust as needed)

echo "Pulling phi model in Ollama...";
sudo docker exec ollama ollama pull phi; #mistral

echo "Deployment has been done success :)";
