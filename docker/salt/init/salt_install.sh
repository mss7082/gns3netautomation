sudo apt-get update 
sudo apt-get -y install apt-utils sudo wget openssh-server python3 gnupg git iputils-ping net-tools traceroute mtr vim python3-pip tree
sudo rm -rf /var/lib/apt/lists/*

wget -O - https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
sudo touch /etc/apt/sources.list.d/saltstack.list
sudo echo "deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" >> /etc/apt/sources.list.d/saltstack.list
sudo apt-get update && apt-get -y install salt-master salt-minion
sudo echo "master: 127.0.0.1" >> /etc/salt/minion
sudo touch /etc/salt/proxy
sudo echo "master: localhost\npki_dir: /etc/salt/pki/proxy\ncache_dir: /var/cache/salt/proxy\nmultiprocessing: False" >> /etc/salt/proxy

sudo pip3 install --upgrade pip
sudo pip3 install napalm
sudo pip3 install jxmlease
sudo shutdown -r now