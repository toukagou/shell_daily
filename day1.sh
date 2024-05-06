#!/bin/bash

#author: jiahao
#version: v1
#date: 20231018

### 脚本实现批量备份文件

#获取当前日期，以对应格式输出
suffix=`date +%Y%m%d`

#循环遍历/data/目录下的所有txt文件，备份所有文件加上suffix
for f in `find /data/ -type f -name "*.txt"`
do
    echo "备份文件$f"
    cp ${f} ${f}_${suffix}
done
