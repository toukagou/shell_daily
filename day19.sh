#!/bin/bash

check_tools(){
    if ! which pgrep &>/dev/null
    then 
        echo "本机没有pgrep命令！"
        exit 1
    fi
    if ! which ss &>/dev/null
    then
        echo "本机没有ss命令！"
        exit 1
    fi
}

check_ps(){
    if pgrep "$1" &>/dev/null
    then
        return 0
    else
        return 1
    fi
}

check_port(){
    port_n=`ss -lnp|grep ":$1 "|wc -l`
    if [ $port_n -ne 0 ] 
    then
        return 0
    else
        return 1
    fi
}

check_srv(){
    if check_ps $1 && check_port $2
    then 
        echo "$1服务正常"
    else
        echo "$1服务不正常"
    fi
}

check_tools
check_srv nginx 443
check_srv mysql 3306
check_srv redis 6379
check_srv java 8825
check_srv postmaster 5432
