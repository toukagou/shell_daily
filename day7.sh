#!/bin/bash

#authoer:jiahao
#version: v1
#date: 2023-11-08

## 今日脚本需求:
## 有一台服务器作为web应用，有一个目录（/data/web/attachment）
## 不定时地会被用户上传新的文件，但是不知道什么时候会上传。
## 所以，需要我们每5分钟做一次检测是否有新文件生成。
## 写一个shell脚本去完成检测。检测完成后若是有新文件，
## 还需要将新文件的列表输出到一个按年、月、日、时、分为名字的日志里。
## 思路： 每5分钟检测一次，那肯定需要有一个计划任务，每5分钟去执行一次。
## 脚本检测的时候，就是使用find命令查找5分钟内有过更新的文件，
## 若是有更新，那这个命令会输出东西，否则是没有输出的。
## 固，我们可以把输出结果的行数作为比较对象，看看它是否大于0。

#日志文件名
d=`date +%Y%m%d%H%M`
[ -d /data/web/attachment ] || mkdir -p /data/web/attachment
basedir=/data/web/attachment

#找到5分钟内新产生的文件，写入到文件里
find $basedir/ -type f -mmin -5 > /tmp/newfile.txt

#如果文件有内容，将文件改名
if [ -s /tmp/newfile.txt ]
then
    /bin/mv /tmp/newfile.txt /tmp/$d
fi