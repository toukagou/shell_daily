#!/bin/bash

#author: jiahao
#date: 2019-08-23
#version: 1.0

## 脚本要求：遍历a.txt的行找出b.txt中没有的行写入到c.txt中

#如果c.txt存在，先删除
[ -f /data/c.txt ] && rm -f /data/c.txt

#使用while循环读取a.txt的内容，判断是否在b.txt中，如果不在，则写入到c.txt
cat /data/a.txt | while read line
do
    if ! grep "^${line}$" /data/b.txt
    then
        echo ${line} >> /data/c.txt
    fi
done

#统计行数
wc -l /data/c.txt
