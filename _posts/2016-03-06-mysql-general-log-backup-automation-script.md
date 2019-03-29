---
layout: post
title: Mysql 常规日志备份自动化脚本
categories: Mysql
description: Mysql 常规日志备份自动化脚本
keywords: Mysql, Log, Automation, Script
---


简单的日志拆分备份，对日志要求较高的库不建议使用。

## 日志路径
- `less /etc/my.cnf`
  ```bash
  log_bin=/g40/mysql/logs/mysql_binlog
  
  general_log=ON
  general_log_file=/g40/mysql/logs/mysql.log
  ```


## 自动脚本
- `mkdir -p /g40/mysql/sbin`
- `vim /g40/mysql/sbin/backup_mysql_log.sh`
  ```bash
  #!/bin/bash
  
  logs_path="/g40/mysql/logs/"
  logs_bak_path="/g40/mysql/logs/"
  
  mkdir -p ${logs_bak_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/
  cp ${logs_path}mysql.log ${logs_bak_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/mysql_$(date -d "yesterday" +"%Y%m%d").log
  cp /dev/null ${logs_path}mysql.log
  chown -R mysql.mysql ${logs_path}mysql.log
  ```
- `chmod a+x /g40/mysql/sbin/backup_mysql_log.sh`
- `crontab -e`
  ```bash
  20 00 * * * /bin/bash /g40/mysql/sbin/backup_mysql_log.sh
  ```
