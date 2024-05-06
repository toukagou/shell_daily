#!/bin/bash

#author: jiahao
#version: v1
#date: 2023-11-08

## shell脚本一天一练系列 -- Day9
## 今日脚本需求:
## 写一个脚本，执行后，打印一行提示"Please input a number:"
## 要求用户输入数值，然后打印出该数值，然后再次要求用户输入数值。
## 直到用户输入"end"停止。
echo "不能输入字母或者符号,输入 end 退出脚本."
while :
do 
    read -p "请输入一个数字: " inp

    num=`echo $inp | sed -r 's/[0-9]//g' | wc -c`
    if [ $inp == "end" ]
    then
        exit
    fi
    if [ $num -ne 1 ]
    then
        echo "你输入的不是一个数字，请重新输入！"
    else
        echo "你输入的数字是: $inp"
    fi
done

done