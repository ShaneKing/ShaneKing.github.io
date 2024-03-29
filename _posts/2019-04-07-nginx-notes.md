---
layout: post
title: Nginx 笔记
categories: [FrontEnd, Nginx]
description: Nginx 笔记
keywords: Nginx
---


搞 Web 的，不会 Nginx 怎么行？

## 安装
### yum 安装
`yum -y install nginx`

## 命令
### 服务命令
- 服务所系统启动：`systemctl enable nginx`
- 重启 nginx 服务：`systemctl restart nginx`
- 停止 nginx 服务：`systemctl stop nginx`
- 查看 nginx 运行状态：`systemctl status nginx`

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
- `vim /etc/nginx/conf.d/bdwk.conf`
```bash
server {
    listen 80;
    server_name bdwk.shaneking.org;
    access_log /var/log/nginx/bdwk_access.log;
    location / {
        #### https://www.docs4dev.com/docs/zh/nginx/current/reference/http-ngx_http_proxy_module.html
        proxy_read_timeout 300s; ### default 60s
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Ssl on; ### for https, comment if http
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://ip:3000;
    }
}
```

## stream
### 扩展配置
- `vim /etc/nginx/nginx.conf`
- 在 `include /usr/share/nginx/modules/*.conf;` 下面新增：`include /etc/nginx/stream.d/*.conf;`

### stream扩展：PostgreSQL
- `vim /etc/nginx/stream.d/pg12.conf`

```bash
stream {
    server {
        listen 45432;
        ### https://www.docs4dev.com/docs/zh/nginx/current/reference/stream-ngx_stream_proxy_module.html
        proxy_pass ip:5432;
    }
}
```
