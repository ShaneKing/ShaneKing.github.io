#!/bin/bash

#run by root


MY_BUCKET=""
MY_ACCESS_KEY_ID=""
MY_ACCESS_KEY_SECRET=""
MOUNT_PATH=""
#this is shanghai, please modify according to actual situation
OSS_ENDPOINT="http://oss-cn-shanghai-internal.aliyuncs.com"


#https://shaneking.org/images/posts/2018/07/ossfs_1.80.5_centos7.0_x86_64.rpm
wget http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/32196/cn_zh/1527232195135/ossfs_1.80.5_centos7.0_x86_64.rpm

yum -y localinstall ossfs_1.80.5_centos7.0_x86_64.rpm

echo $MY_BUCKET:$MY_ACCESS_KEY_ID:$MY_ACCESS_KEY_SECRET > /etc/passwd-ossfs
chmod 640 /etc/passwd-ossfs
mkdir -p $MOUNT_PATH
ossfs $MY_BUCKET $MOUNT_PATH -ourl=$OSS_ENDPOINT


#umount
#fusermount -u $MOUNT_PATH
