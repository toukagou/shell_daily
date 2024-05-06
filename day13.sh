#!/bin/bash

create_number(){
    while :
    do
        nu=$[$RANDOM%99+1]
        # 或者nu=$(($RANDOM%99+1))

        n=`awk -F ':' -v NUMBER=$nu '$2 == NUMBER' /tmp/name.log|wc -l`
        # awk使用-v 将系统变量转成自己的变量
        if [ $n -gt 0 ]
        then
            continue
        else
            echo $nu
            break
        fi
    done
}

while :
do
    read -p "请输入你的名字：" name
    if [ ! -f /tmp/name.log ]
    then
        number=$[$RANDOM%99+1]
        echo "你的数字是：$number"
        echo "$name:$number" > /tmp/name.log
    else 
        n=`awk -F ':' -v NAME=$name '$1 == NAME' /tmp/name.log|wc -l`
        if [ $n -gt 0 ]
        then
            echo "这个名字已存在。"
            awk -F ':' -v NAME=$name '$1 == NAME' /tmp/name.log
            continue
        else
            number=`create_number`
        fi
        echo "你的数字是：$number"
        echo "$name:$number" >> /tmp/name.log
    fi
done

