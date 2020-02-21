#!/bin/bash

cd `dirname $0`
echo "参考样例说明修改hosts.ini文件"
echo "请输入任意键进入hosts.ini修改界面"
read -p ""
sudo vi npgstack/hosts.ini
docker run --rm -it -v $PWD/npgstack:/app -w /app core/ansible:v2.7.9 ansible-playbook -i hosts.ini ./npgmaster.yml --become --become-method=sudo
