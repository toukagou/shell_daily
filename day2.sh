#!/bin/bash

#author: jiahao
#version: v1
#date: 20231018

### 需求：
### 创建10个用户，并给他们设置随机密码，密码记录到一个文件里，文件名userinfo.txt
### 用户从user_00 到  user_09    
### 密码要求：包含大小写字母以及数字，密码长度15位 

#先查看/tmp/userinfo.txt文件是否存在，存在先删除
if [ -f /tmp/userinfo.txt ]
then
    rm -f /tmp/userinfo.txt
fi

#判断mkpasswd命令在不在，需要使用该命令生成随机字符串，也就是用户密码
if ! which mkpasswd
then
    yum install -y expect
fi

#借助seq生成从0到9，10个数的队列
for i in `seq -w 0 09`
do
    #每次遍历生成一个字符串，存到变量p
    #mkpasswd默认生成大小写字母+数字+特殊符号的字符串，如果不要特殊符号加 -s 0 参数，-l 定义字符串的长度
    p=`mkpasswd -l 15 -s 0`
    #添加用户，并给该用户设置密码
    useradd user_${i} && echo "${p}"|passwd --stdin user_${i}
    echo "user_${i} ${p}" >> /tmp/userinfo.txt
done

## mkpasswd参数：-l指定长度，-s指定特殊字符个数，-C指定大写字母个数，-c指定小写字母个数，-d指定数字个数
## seq可以生成序列，如：seq 1 5，seq -w 0 5，seq 10 -2 1，参考curl cheat.sh/seq
## passwd --stdin username，--stdin选项用于从标准输入、管道符读入新的密码
