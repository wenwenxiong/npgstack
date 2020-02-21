#!/bin/bash

cd `dirname $0`
docker run --rm -it -v $PWD/npgstack:/app -w /app core/ansible:v2.7.9 ansible-playbook -i hosts.ini ./reset.yml --become --become-method=sudo
