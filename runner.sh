sudo docker run -d -p 22:2222 joengelh/dockerhub-ubuntuserver:latest
container_name=$(sudo docker ps -a | head -n 2 | tail -n 1 | grep -oE '[^ ]+$')
