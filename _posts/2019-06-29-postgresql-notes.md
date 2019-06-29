---
layout: post
title: PostgreSQL 笔记
categories: PostgreSQL
description: PostgreSQL 笔记
keywords: PostgreSQL
---


Base of MPPDB.

## 安装设置

### 安装
<https://www.postgresql.org/download/linux/redhat/>

### 设置
- 修改 postgres 密码
  - `su - postgres`
  - `psql -U postgres`
  - `alter user postgres with password 'ShaneKing为PostgreSQL在上海'`
- 配合 Nginx
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
- 修改 /var/lib/pgsql/11/data/pg_hba.conf

```bash
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
#local   all             all                                     peer
local   all             all                                     md5
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     all                                     peer
local   replication     all                                     md5
host    replication     all             127.0.0.1/32            md5
host    replication     all             ::1/128                 md5
```
- 重启：`systemctl restart postgresql-11`

## 用户

### 建
- `su - postgres`
- `psql -U postgres`
- `create user das with password 'das';`
- `create database dasdb;`
- `grant all privileges on database dasdb to das;`

## 命令

| \? | 帮助 |  |
| \dS+ | 列出表 | `\dS+ tableName` 列出表信息 |
| \l | 列出数据库 | `\l+` 列出更多信息 |
| \q | 退出 |  |
| psql | 登录 | `psql -U das -d dasdb` |

