#!/bin/bash

### 写脚本随机产生3位数字，并根据输入参数判断产生多少组数字

# author: jiahao
# date: 2019-08-23
# version: v1

# 产生一个随机数
get_a_num(){
    n=$[$RANDOM%10]
    echo $n
}

get_numbers(){
    for i in 0 1 2
    do
        a[$i]=`get_a_num`
    done
    echo ${a[@]} | sed 's/ //g'
}

# $#参数表示传入参数的个数
# 如果传入参数大于1个
if [ $# -gt 1 ]
then
    echo "请传入一个参数"
    echo "$0 5"
    exit
fi

## 如果没有传入参数，产生3位数字
## 如果传入了参数，判断是否为正整数

# 
if [ $# -eq 1 ]
then
    m=`echo $1|sed 's/[0-9]//g'`
    if [ -n "$m" ]
    then
        echo "错误，需要传入一个正整数"
        exit
    else
        echo "这些数字是:"
        for i in `seq $1`
        do
            get_numbers
        done
    fi
else
    get_numbers
fi
