git config --global user.email "73387330+joengelh@users.noreply.github.com"
git config --global user.name "joengelh"
git pull
git add -u
git add *
git commit -m 'automated commit for update saving'
git push
image_name=$(sudo docker build . | tail -n 1 | grep -oE '[^ ]+$')
container_name=$(sudo docker create $image_name)
sudo docker commit $container_name joengelh/dockerhub-ubuntuserver
sudo docker push joengelh/dockerhub-ubuntuserver
