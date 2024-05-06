#!/bin/bash

#author jiahao
#date 2023-11-27
#version v1.0

## 输出日志1.log，每天归档
## 第一天1.log，第二天1.log.1，第三天1.log.2...

## 假设日志目录为 /data/
cd /data/

## 首先删除最老的日志
if [ -f 1.log.5 ]
then
    rm -f 1.log.5
fi

## 循环
for i in `seq 5 -1 2`
do
    ## 如果日志存在，则后缀+1
    if [ -f 1.log.$[$i-1] ]
    then
        mv 1.log.$[$i-1] 1.log.$i
    fi
done

mv 1.log 1.log.1

touch 1.log