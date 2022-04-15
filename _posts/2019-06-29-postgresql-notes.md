---
layout: post
title: PostgreSQL 笔记
categories: [DB, PostgreSQL]
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
  - `alter user postgres with password 'pwd'`
- 配合 Nginx
```bash
stream {
    server {
        listen 45432;
        proxy_pass ip:5432;
    }
}
```
- 修改 /var/lib/pgsql/12/data/postgresql.conf

```bash
listen_addresses = '*'
```
- 修改 /var/lib/pgsql/12/data/pg_hba.conf

```bash
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
#local   all             all                                     peer
local   all             all                                     md5
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
host    all             all             0.0.0.0/0               md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     all                                     peer
local   replication     all                                     md5
host    replication     all             127.0.0.1/32            md5
host    replication     all             ::1/128                 md5
host    replication     all             0.0.0.0/0               md5
```
- 重启：`systemctl restart postgresql-12`

## 建
- `su - postgres`
- `psql -U postgres`
### 用户
- `create user testuser with password 'testuser';`
- `create database testdb encoding=UTF8;`
- `grant all privileges on database testdb to testuser;`
### schema
- `psql -U testuser -d testdb[ -p 5432]`
- `create schema testschema;`
- `alter schema testschema owner to testuser;`



## 命令

| \? | 帮助 |  |
| \dS+ | 列出表 | `\dS+ tableName` 列出表信息 |
| \l | 列出数据库 | `\l+` 列出更多信息 |
| \q | 退出 |  |
| psql | 登录 | `psql -U testuser -d testdb` |

