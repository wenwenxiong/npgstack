#!/bin/bash

set -x
#ssh-keygen -f deploy.key -P "" #生成ssh密钥对

passwd=engine123               # 指定要传递的密码为thinker
user_host=`awk '{print $3}' ./deploy.key.pub`   # 此变量用于判断远程主机中是否已添加本机信息成功
 
for i in  $@
do
        ./autocopy.exp $i $passwd  >&/dev/null
        ssh -i ./deploy.key $i "grep "$user_host" ~/.ssh/authorized_keys" >&/dev/null  # 判断是否添加本机信息成功
        if [ $? -eq 0 ];then
                echo "$i is ok"
        else
                echo "$i is not ok"
        fi
done
set +x
