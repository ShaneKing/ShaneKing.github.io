---
layout: post
title: 阿里云 CentOS7 挂载 OSS，用于共享及归档
categories: Linux
description: 阿里云 CentOS7 挂载 OSS，用于共享及归档
keywords: Aliyun, CentOS, OSS
---


适用于 NAS 的替代方案，无公网 IP 情况文件传出，数据共享及归档等场景

[Aliyun-CentOS7-mount-OSS.sh](/images/posts/2018/07/aliyun-centos7-mount-oss.sh)

## 脚本参数（MY_ACCESS_KEY_ID，MY_ACCESS_KEY_SECRET）

### 新建RAM用户
- 不要勾选"为该用户自动生成 AccessKey"
![](/images/posts/2018/07/QQ20180722-092649@2x.png)

### 创建 AccessKey，记下 AccessKeySecret（如有必要可下载备份）
![](/images/posts/2018/07/QQ20180722-093116@2x.png)

### 为该用户赋权
![](/images/posts/2018/07/QQ20180722-100908@2x.png)


## 安装挂载
`sh Aliyun-CentOS7-mount-OSS.sh`


## Via
<https://help.aliyun.com/document_detail/32196.html>


## PS（df -h）
- 阿里云华东2节点 NAS 盘为10P

`xxxxxxxxxx-xxxxx.cn-shanghai.nas.aliyuncs.com:/   10P  2.6G   10P   1%`

- 阿里云华东2节点 Bucket 盘为256T

`ossfs                                            256T     0  256T   0%`
