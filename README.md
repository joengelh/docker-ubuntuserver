# docker-ubuntuserver
contianer which can be used for testing with ansible, ssh enabled.

place your public ssh key in ``authorized_keys`` and run 
``docker-compose up -d``.

docker-compose can be installed using the ansible role:
[go to github](https://github.com/joengelh/ansible-kvm/tree/main/roles/docker-compose)
