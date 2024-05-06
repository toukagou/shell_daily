#!/bin/bash

## 用于批量删除day2.sh批量创建的user_00-09用户

#author: jiahao
#version: v1
#date: 20231018

#循环遍历user_00-09用户，批量删除
for i in `seq -w 0 09`
do
    userdel -r user_${i}
    echo "user_${i} 已删除"
done

#删除之前创建的userinfo.txt文件
if [ -f /tmp/userinfo.txt ]
then
    rm -r /tmp/userinfo.txt
fi
