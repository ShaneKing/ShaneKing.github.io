---
layout: post 
title: 树莓派静态文件服务 
categories: [FrontEnd, Nginx, OS, RPI] 
description: 树莓派静态文件服务 
keywords: ARM, Raspberry Pi, URL
---


现在的云存储实在是太贵了，遥想 18 年，阿里云 OSS 服务，1TB 存储，3 年才 99 元，现在 3996 元。于是折腾又开始了...

## 树莓派
### 挂载移动硬盘
<https://blog.csdn.net/weixin_42118716/article/details/108193396>

### 安装 NGINX
`sudo apt-get -y install nginx`

### 配置 NGINX
- `vim /etc/nginx/conf.d/share.conf`
```bash
server_names_hash_bucket_size 128;
server {
    listen 80;
    server_name share.nps.shaneking.org;
    access_log /var/log/nginx/share_access.log;
    location / {
        root /mnt/d320g1/share;
        autoindex on;
        autoindex_exact_size on;
        autoindex_localtime on;
    }
}
```

## NPS
**仅需加一条域名解析**，无需其它配置

![](/images/posts/2021/01/WX20210207-204950@2x.png)
