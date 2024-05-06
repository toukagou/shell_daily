#!/bin/bash

#author: jiahao
#version: v1
#date: 20231018

### 需求：
### 写一个检测脚本，用来检测本机所有磁盘分区读写是否都正常。
### 提示： 可以遍历所有挂载点，然后新建一个测试文件，
### 然后再删除测试文件，如果可以正常新建和删除，那说明该分区没问题

for mount_p in `df | sed '1d' | grep -v 'tmpfs' | awk '{print $NF}'`
do
    ## 创建测试文件并删除，从而确认该磁盘分区是否有问题
    touch $mount_p/testfile && rm -f $mount_p/testfile
    if [ $? -ne 0 ]
    then
        echo "$mount_p 读写异常"
    else
        echo "$mount_p 读写正常"
    fi
done

### 总结
# &&连接符表示当前命令执行成功才会执行后面的命令
# 两条命令都执行成功$?才会返回0，否则任何一条命令执行失败都会返回非0
# 此脚本中：
# sed '1d' 表示删除第1行信息输出（没删除原文件），这里通过管道符接收 df 命令的输出；
# grep -v 'tmpfs' 参数 -v 用于反向查找，过滤掉带'tmpfs'的输出；
# awk '{print $NF}' 打印最后一列，NF表示打印列数，$NF表示打印最后一列；