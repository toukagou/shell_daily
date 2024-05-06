#!/bin/bash

### 根据一串数字判断是否为合法日期

#author jiahao
#date 20231127
#version v1.0

## 判断参数
if [ $# -ne 1 ] || [ ${#1} -ne 8 ]
then
    echo "格式为：$0 yyyymmdd"
    exit 1
fi

mydate=$1
#截取前四个字符
year=${mydate:0:4}
#截取第5，6个字符
month=${mydate:4:2}
#截取第6，7个字符
day=${mydate:6:2}

if cal $day $month $year >/dev/null 2>/dev/null
then
    echo "$year年$month月$day日."
else
    echo "日期格式错误"
fi