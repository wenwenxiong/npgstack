#!/bin/bash

cd `dirname $0`
#get files from fileserver
sudo wget http://144.202.6.173/npg_files.tar.gz
sudo tar -zxvf npg_files.tar.gz
sudo cp ./npg_files/alpineansible.tar.xz ./npgstack/roles/npg_master/files/alpineansible.tar.xz
sudo cp ./npg_files/npg_master.tar.xz ./npgstack/roles/npg_master/files/npg_master.tar.xz
sudo cp ./npg_files/docker-compose ./npgstack/roles/npg_master/files/docker-compose
sudo cp ./npg_files/npg_stack_images.tar.xz ./npgstack/roles/npg_master/files/npg_stack_images.tar.xz
sudo cp ./npg_files/docker-19.03.5.tgz ./npgstack/roles/npg_master/files/docker-19.03.5.tgz
sudo cp ./npg_files/node_exporter ./npgstack/roles/npg_master/files/node_exporter
sudo cp ./npg_files/netdata-v1.21.0.gz.run ./npgstack/roles/npg_master/files/netdata-v1.21.0.gz.run
#delete local file
sudo rm -rf ./npg_files ./npg_files.tar.gz
