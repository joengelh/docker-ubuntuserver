#use latest Ubuntu Container
FROM ubuntu:latest

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
        wget \
        sudo

#enable root login
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config

#Authorize SSH Hosts
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    cp ./known_hosts /root/.ssh/ && \
    chmod 600 /root/.ssh/known_hosts

#start ssh service 
RUN service ssh start

#expose port 22
EXPOSE 22

#run ssh service  forever
CMD ["/usr/sbin/sshd", "-D"] 
