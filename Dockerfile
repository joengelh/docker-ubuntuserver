#use latest Ubuntu Container
FROM ubuntu:latest

#include known_hosts
ADD authorized_keys /

#stop ubuntu from annoying the fuck out me
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       apt-utils \
       build-essential \
       locales \
       ssh \
       vim \
       htop \
       wget \
       sudo \
       nfs-common \      
       libffi-dev \
       git \
       libssl-dev \
       libyaml-dev \
       python3-dev \
       python3-setuptools \
       python3-pip \
       python3-apt \
       python3-yaml \
       software-properties-common \
       rsyslog systemd systemd-cron sudo iproute2 && \
       rm -Rf /usr/share/doc && \
       rm -Rf /usr/share/man && \
       apt-get clean && \
       rm -Rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -f /lib/systemd/system/systemd*udev* && \
    rm -f /lib/systemd/system/getty.target

# Fix potential UTF-8 errors with ansible-test.
RUN locale-gen en_US.UTF-8

# Install Ansible via Pip.
RUN pip3 install --no-cache-dir ansible

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

#start ssh service 
RUN service ssh start

#expose port 22
EXPOSE 22

#run ssh service  forever
CMD ["/usr/sbin/sshd", "-D"] 
