#use latest Ubuntu Container
FROM ubuntu:latest

#include shell scripts scripts
ADD nirvana.sh /

#include known_hosts
ADD known_hosts /

#stop ubuntu from annoying the fuck out me
ENV DEBIAN_FRONTEND=noninteractive

#install api python module
RUN apt-get update && \
    apt-get install -y \
        git \
        openssh-server \
        vim \
        htop \
        wget

#Authorize SSH Hosts
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    cp ./known_hosts /root/.ssh/ && \
    chmod 600 /root/.ssh/known_hosts

#run etnernal nirvana script
CMD ["bash", "./nirvana.sh"]
