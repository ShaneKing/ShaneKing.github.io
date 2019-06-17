---
layout: post
title: Nginx 笔记
categories: Nginx
description: Nginx 笔记
keywords: Nginx
---


搞 Web 的，不会 Nginx 怎么行？

## 安装

### yum 安装
`yum -y install nginx`


## 命令

### 服务命令
- 服务所系统启动：`systemctl enable nginx.service`
- 重启 nginx 服务：`systemctl restart nginx.service`
- 停止 nginx 服务：`systemctl stop nginx.service`
- 查看 nginx 运行状态：`systemctl status nginx.service`

### 操作命令
- 帮助：`nginx -h`
- 快速停止：`nginx -s stop`
- 优雅停机：`nginx -s quit`
- 重载配置：`nginx -s reload`


## 配置

### 扩展配置
根据 `/etc/nginx/nginx.conf` 文件可知，
- 模块扩展：`/usr/share/nginx/modules/*.conf`
- 应用扩展：`/etc/nginx/conf.d/*.conf`
- 配置扩展：`/etc/nginx/default.d/*.conf`

### 应用扩展：BaiDuWenKu
- `vim /etc/nginx/conf.d/BaiDuWenKu.conf`
```bash
upstream BaiDuWenKu {
    server localhost:3000;
}
server {
    listen 80;
    server_name baiduwenku.shaneking.org;
    access_log /var/log/nginx/BaiDuWenKu_access.log;
    location / {
        proxy_pass http://BaiDuWenKu;
        proxy_read_timeout 300s;
    }
}
```


## stream

### 扩展配置
- `vim /etc/nginx/nginx.conf`
- 新增：`include /etc/nginx/stream.d/*.conf;`

### stream扩展：PostgreSQL
- `vim /etc/nginx/stream.d/PostgreSQL.conf`
```bash
stream {
    upstream PostgreSQL {
        server localhost:5432;
    }
    server {
        listen 15432;
        proxy_pass PostgreSQL;
    }
}
```


