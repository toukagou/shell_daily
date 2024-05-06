#!/bin/bash

# author: jiahao
# date: 2023-11-08
# version: v1.0

## 需求：
## 写一个脚本接收选项[i,I]，完成一下任务：
## 当使用-i选项时，显示指定网卡的IP地址
## 当使用-I选项时，显示其指定IP所属的网卡
## 例如：sh xxx.sh -i eth0
##      sh xxx.sh -I 192.168.1.1
## 当使用[i | I]之外的选项时，显示[-i interface | -I ip]次信息
## 当用户指定信息不符合时，显示错误（如：指定的eth0错误）

## 创建打印脚本使用帮助函数
useage(){
    echo "请使用：$0 -i 网卡名 or $0 -I IP地址"
    echo "例如： -i eth0"
}

## 如果脚本参数不等于2，提示使用帮助
if [ $# -ne 2 ]
then
    useage
    exit
fi

## 获取本机所有网卡名字，存入临时文件
ip add | awk -F ":" '$1 ~ /^[1-9]/ {print $2}' | sed 's/ //g' > /tmp/eths.txt

