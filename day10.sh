#!/bin/bash

#监控某个站点访问是否正常
#正常echo正常 ，不正常echo不正常

#检查本机是否安装curl命令
if ! which curl &> /dev/null
then
    echo "本机没有安装curl命令。"
    read -p "是否需要进行安装：(y/n)" choice
    case ${choice} in
        y)
            echo "正在进行安装..."
            yum install -y curl
        ;;
        n)
            echo "取消安装。"
            exit 1
        ;;
    esac
    if [ $? -ne 0 ]
    then
        echo "未成功安装curl"
        exit 1
    fi
fi

##获取状态码
##是否能通过循环同时检测多个网站
code=`curl --connect-timeout 3 -I $1 2>/dev/null | grep 'HTTP' | awk '{print $2}'`

##如果状态码是2xx或3xx则条件成立
if echo $code | grep -qE '^2[0-9][0-9]|^3[0-9][0-9]'
then
    echo "$1 访问正常"
else
    echo "$1访问不正常"
fi