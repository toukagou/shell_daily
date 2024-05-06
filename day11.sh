#!/bin/bash

#### 加减乘除运算

# 判断传参个数是不是2
if [ $# -ne 2 ]
then
    echo "错误：传参个数应该为2。"
    exit 1
fi

# 判断数字是否为正整数
is_int(){
    if echo "$1" | grep -q '[^0-9]'
    then
        echo "$1 不是整数"
        exit 1
    fi
}

# 最大值
max(){
    if [ $1 -ge $2 ]
    then
        echo $1
    else 
        echo $2
    fi
}

# 最小值
min(){
    if [ $1 -lt $2 ]
    then
        echo $1
    else
        echo $2
    fi
}

## 总和
sum(){
    echo "$1 + $2 = $[$1+$2]"
}

## 减法
minus(){
    big=`max $1 $2`
    small=`min $1 $2`
    echo "$big - $small = $[$big - $small]"
}

## 乘法
mult(){
    echo "$1 * $2 = $[$1 * $2]"
}

## 除法
div(){
    big=`max $1 $2`
    small=`min $1 $2`
    d=`echo "scale = 2;$big / $small"|bc`
    echo "$big / $small = $d"
}

is_int $1
is_int $2
sum $1 $2
minus $1 $2
mult $1 $2
div $1 $2