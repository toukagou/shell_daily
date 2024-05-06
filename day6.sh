#!/bin/bash

#author: jiahao
#version: v1
#date: 20231023

#创建log目录
[ -d /tmp/logs ] || mkdir -p /tmp/logs

while :
do
    #获取1分钟负载
    load=`uptime | awk -F 'average:' '{print $2}' | cut -d ',' -f1 | sed 's/ //g' | cut -d. -f1`
    if [ $load -gt 10 ]
    then
        #截取top命令100行写入到日志文件
        top -bn1 | head -n 100 > /tmp/logs/top.`date +%s`
        #获取vmstat 10次刷新数据写入到日志文件
        vmstat 1 10 > /tmp/logs/vmstat.`date +%s`
        #获取ss
        ss -an > /tmp/logs/ss.`date +%s`
    fi
    sleep 15

    #找到30天以前的日志删除
    find /tmp/logs \( -name "top*" -o -name "vmstat*" -o -name "ss*" \) -mtime +30 | xargs rm -f
done