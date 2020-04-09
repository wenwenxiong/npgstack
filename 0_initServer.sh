#!/bin/bash

#check npg port if already used
exist=`ss -plnt | grep -E '3000|9090|9093|8889|3100|19999|9100' | wc -l`
if [ $exist -ne 0 ]; then
  echo "port 3000|9090|9093|8889|3100|19999|9100 have one or multi in used !"
  exit 1
fi

cd `dirname $0`
#get files from fileserver
#sudo wget http://144.202.6.173/npg_files.tar.gz
#sudo tar -zxvf npg_files.tar.gz
#sudo cp ./npg_files/alpineansible.tar.xz ./npgstack/roles/npg_master/files/alpineansible.tar.xz
#sudo cp ./npg_files/npg_master.tar.xz ./npgstack/roles/npg_master/files/npg_master.tar.xz
#sudo cp ./npg_files/docker-compose ./npgstack/roles/npg_master/files/docker-compose
#sudo cp ./npg_files/npg_stack_images.tar.xz ./npgstack/roles/npg_master/files/npg_stack_images.tar.xz
#sudo cp ./npg_files/docker-19.03.5.tgz ./npgstack/roles/npg_master/files/docker-19.03.5.tgz
#sudo rm -rf ./npg_files ./npg_files.tar.gz
# install docker
sudo systemctl stop firewalld && sudo systemctl disable firewalld
sudo setenforce 0
sudo tar xzvf ./npgstack/roles/npg_master/files/docker-19.03.5.tgz && chmod 777 -R docker/ && mv docker/* /usr/bin/ && rm -rf docker
sudo cp  ./npgstack/roles/npg_master/files/docker.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker
echo "============= 1 Docker Installed  ============"
# install docker-compose
sudo cp ./npgstack/roles/npg_master/files/docker-compose /usr/bin/ && sudo chmod 777 /usr/bin/docker-compose
echo "============= 2 Docker-compose Installed  ============"
### 1. Load images
# ansible images
sudo docker load<./npgstack/roles/npg_master/files/alpineansible.tar.xz
echo "============= 3 Loaded ansible images ============"
# ansible sshkey inject
sudo cat ./npgstack/sshkeyinject/deploy.key.pub >> ~/.ssh/authorized_keys
echo "============= 4 injected ansible ssh key to current user ============"
