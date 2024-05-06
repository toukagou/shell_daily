#!/bin/bash
# author: jiahao 
# version: v1.0
# date: 20230927

#接收下载地址
read -p "请输入下载地址：" download_url
read -p "请输入保存目录：" download_dir
echo "检测中，请稍等..."
download_url_check=`curl -Is $download_url | awk '{if(NR==1) print $2}'`

if [ $download_url_check -eq 200 ];then
#创建目录，存在用户判断
    while :
    do
        #目录存在，跳出循环
        if [ -d $download_dir ]
        then 
            break
        else
            #目录不存在，询问用户
            read -p "目录不存在，是否创建？y/n：" yn
            case $yn in
                y|Y|yes|YES|Yes)
                    mkdir -p $download_dir
                    break 
                    ;;
                n|N|no|NO|No)
                    #用户拒绝创建，退出脚本
                    exit 2
                    ;;
                *)
                    #用户比较反骨，输入不是为y/n，提示用户
                    echo "输入有误，请输入y或者n"
                    continue
                    ;;
            esac
        fi
    done
elif [ $download_url_check -ne 200 ];then
    echo "下载地址：$download_url 输入有误，请检查..."
    exit 1
fi

#进入目录
cd $download_dir
#使用wget命令下载，判断wget是否安装
wget_check=`rpm -qa wget`
if [ ! -n "wget_check" ];then
    yum install -y wget
else
    echo "正在下载中..."
    sleep 1s
    wget $download_url
fi

#判断文件是否已经下载过
#md5_check=`md5sum $download_dir | awk '{print $1}'`

if [ $? -eq 0 ];then
    echo "下载成功"
    exit 0
else 
    echo "下载失败"
    exit 1
fi

