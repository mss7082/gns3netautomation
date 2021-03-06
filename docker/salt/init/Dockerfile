# Build salt master image for use in GNS3

FROM ubuntu:bionic


ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install apt-utils sudo wget openssh-server python3 \
     gnupg git iputils-ping net-tools traceroute mtr vim python3-pip tree \
     && rm -rf /var/lib/apt/lists/*

# Run the following command to import the SaltStack repository key

RUN wget -O - https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -

RUN touch /etc/apt/sources.list.d/saltstack.list

RUN echo "deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" >> /etc/apt/sources.list.d/saltstack.list 

RUN apt-get update && apt-get -y install salt-master salt-minion

RUN echo "master: 127.0.0.1" >> /etc/salt/minion

RUN touch /etc/salt/proxy

RUN echo "master: localhost\npki_dir: /etc/salt/pki/proxy\ncache_dir: /var/cache/salt/proxy\nmultiprocessing: False" >> /etc/salt/proxy 

VOLUME [ "/etc", "/var/cache/salt", "/var/log/salt", "/var/run/salt", "/srv" ]

RUN salt-master -d

RUN salt-minion -d



# Set up SSH

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

RUN service ssh start


# Set up Napalm and related libraries

RUN pip3 install --upgrade pip

RUN pip3 install napalm

RUN pip3 install jxmlease

