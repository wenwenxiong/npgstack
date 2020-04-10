#!/bin/bash

#check npg port if already used
exist=`ss -plnt | grep -E '3000|9090|9093|8889|3100|19999|9100' | wc -l`
if [ $exist -ne 0 ]; then
  echo "port 3000|9090|9093|8889|3100|19999|9100 have one or multi in used !"
  exit 1
fi

cd `dirname $0`
#check os type for disable firewall and disable selinux
source /etc/os-release
echo $ID
if [[ $ID =~ "ubuntu" || $ID =~ "debian" ]]; then
    sudo ufw disable
    #selinux-utils not install on ubuntu default
elif [[ $ID =~ "centos" || $ID =~ "rhel" ]]; then
    sudo systemctl stop firewalld && sudo systemctl disable firewalld
    sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
    sudo setenforce 0
fi
# install docker
echo "check Docker if installed"
sudo docker -v
if [ $? -eq  0 ]; then
    echo "Docker already installed!"
else
    sudo tar xzvf ./npgstack/roles/npg_master/files/docker-19.03.5.tgz && chmod 777 -R docker/ && mv docker/* /usr/bin/ && rm -rf docker
    sudo cp  ./npgstack/roles/npg_master/files/docker.service /etc/systemd/system/
fi
sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker
echo "============= 1 Docker Installed  ============"
# install docker-compose
echo "check docker-compose if installed"
sudo docker-compose -v
if [ $? -eq  0 ]; then
    echo "docker-compose already installed!"
else
    sudo cp ./npgstack/roles/npg_master/files/docker-compose /usr/bin/ && sudo chmod 777 /usr/bin/docker-compose
fi
echo "============= 2 Docker-compose Installed  ============"
### 1. Load images
# ansible images
sudo docker load<./npgstack/roles/npg_master/files/alpineansible.tar.xz
echo "============= 3 Loaded ansible images ============"
# ansible sshkey inject
sudo mkdir -p ~/.ssh
sudo cat ./npgstack/sshkeyinject/deploy.key.pub >> ~/.ssh/authorized_keys
echo "============= 4 injected ansible ssh key to current user ============"
