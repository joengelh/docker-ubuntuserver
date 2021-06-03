#use latest Ubuntu Container
FROM ubuntu:latest

#include known_hosts
ADD authorized_keys /

#stop ubuntu from annoying the fuck out me
ENV DEBIAN_FRONTEND=noninteractive

#install api python module
RUN apt-get update && \
    apt-get install -y \
        git \
        ssh \
        vim \
        htop \
        wget \
        sudo \
        nfs-common

#create wheel group and give sudoless password permissions
RUN groupadd wheel && \
    echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#create user
RUN adduser --disabled-password --gecos '' ansible && \
    usermod -a -G wheel ansible

#change workdir to ansible user
WORKDIR /home/ansible

#Authorize SSH Hosts
RUN mkdir -p .ssh/ && \
    chmod 0700 .ssh/ && \
    mv /authorized_keys .ssh/ && \
    chmod 600 .ssh/authorized_keys && \
    chown -R ansible:wheel .ssh/

#clean up sh***
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#start ssh service 
RUN service ssh start

#expose port 22
EXPOSE 22

#run ssh service  forever
CMD ["/usr/sbin/sshd", "-D"] 
