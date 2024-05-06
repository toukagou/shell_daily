#!/bin/bash

#author: jiahao
#version: v1
#date: 20231018

## 需求:
## 检查/data/wwwroot/app目录下所有文件和目录，看是否满足下面条件：
## 1）所有文件权限为644
## 2）所有目录权限为755
## 3）文件和目录所有者为www，所属组为root
## 如果不满足，改成符合要求
## 注意，不要直接改权限，一定要有判断的过程。

cd /data/wwwroot/app

### 遍历当前目录的所有目录和文件
for f in `find .`
do
    #查看文件权限
    f_p=`stat -c %a $f`
    #查看文件所有者
    f_u=`stat -c %U $f`
    #查看文件所属组
    f_g=`stat -c %G $f`

    #判断是否为目录
    if [ -d $f ]
    then
        [ $f_p != '755' ] && chmod 755 $f
    else
        [ $f_p != '644' ] && chmod 644 $f
    fi

    #&&用在两条命令中间，可以起到if判断的作用
    [ $f_u != 'www' ] && chown www $f
    [ $f_g != 'root' ] && chown :root $f
done

<<'COMMENT'
另外也可以用find来实现
find /data/wwwroot/app/ -type d ! -perm 755 -exec chmod 755 {} \; 
find /data/wwwroot/app/ ! -type d ! -perm 644 -exec chmod 644 {} \;
find /data/wwwroot/app/ ! -user www -exec chown www {} \; 
find /data/wwwroot/app/ ! -group root -exec chgrp root {} \;

两个脚本相比，第一个只需要find一次，而第二个需要find四次
如果文件量很大，执行效率很差。 

### 关键知识点总结：
1）查看文件权限：stat  -c  %a  1.txt
2）查看文件所属组：stat -c %G  1.txt
3）查看文件所有者：stat -c %U  1.txt
4）&& 可以实现：当前面命令执行成功再执行后面命令
5）|| 可以实现：当前面命令不成功再执行后面命令
COMMENT