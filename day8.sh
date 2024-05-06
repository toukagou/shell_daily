#!/bin/bash

#author: jiahao
#version: v1
#date: 2023-11-08

## shell脚本一天一练系列 -- Day8
## 今日脚本需求:
## 写一个脚本实现如下功能：  
## 输入一个数字，然后运行对应的一个命令。
## 显示命令如下：
## *cmd meau**  1—date 2–ls 3–who 4–pwd
## 当输入1时，会运行date, 输入2时运行ls, 依此类推。

while :
do 
    read -p "Plase Input Number(1-4)：" number
    case $number in 
    1)
        date
        ;;
    2)
        ls
        ;;
    3)
        who
        ;;
    4)
        pwd
        ;;
    *)
        break
        ;;
    esac
done