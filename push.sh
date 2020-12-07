image_name=$(sudo docker build . | tail -n 1 | grep -oE '[^ ]+$')
container_name=$(sudo docker create $image_name)
sudo docker commit $container_name joengelh/dockerhub-ubuntuserver
sudo docker push joengelh/dockerhub-ubuntuserver
