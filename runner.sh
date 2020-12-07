sudo docker run -d -P joengelh/dockerhub-ubuntuserver:latest
container_name=$(sudo docker ps -a | head -n 2 | tail -n 1 | grep -oE '[^ ]+$')
sudo docker port $container_name 22
