---
layout: post
title: Mysql 小库逻辑备份自动化脚本
categories: Mysql
description: Mysql 小库逻辑备份自动化脚本
keywords: Mysql, Backup, Automation, Script
---


初期全量备份，就两个字，简单！

## 备份

### 手动
`mysqldump -u root -p databaseName > databaseName_backups.sql`

[备注]:单点间需手动换行，不然会在一个<P>标签内
`mysqldump -u root -p databaseName | gzip > databaseName_backups.sql.gz`

### 自动
- `mkdir -p /g40/mysql/sbin`
- `vim /g40/mysql/sbin/backup_mysql.sh`
  ```bash
  #!/bin/bash
  
  CMD_MYSQL="$(which mysql)"
  CMD_MYSQLDUMP="$(which mysqldump)"
  # CMD_CHOWN="$(which chown)"
  # CMD_CHMOD="$(which chmod)"
  # CMD_GZIP="$(which gzip)"
  
  LOCAL_HOST="$(hostname)"
  
  DB_USERNAME=""
  DB_PASSWORD=""
  DB_HOSTNAME="localhost"
  DB_IGNORE="information_schema"
  DB_BACKUPS="$($CMD_MYSQL -u $DB_USERNAME -h $DB_HOSTNAME -p$DB_PASSWORD -Bse 'show databases')"
  
  BACKUP_PATH_MYSQL="/g40/mysql/backups"
  BACKUP_NAME_TIMESTAMP="$(date +"%Y%m%d%H%M%S")"
  
  # $CHOWN 0.0 -R $DEST
  # $CHMOD 0600 $DEST
  
  BACKUP_FILE=""
  
  [ ! -d $BACKUP_PATH_MYSQL ] && mkdir -p $BACKUP_PATH_MYSQL || :
  
  for db in $DB_BACKUPS
  do
      skipdb=-1
  
      if [ "$DB_IGNORE" != "" ] ; then
          for i in $DB_IGNORE
          do
              [ "$db" == "$i" ] && skipdb=1 || :
          done
      fi
  
      if [ "$skipdb" == "-1" ] ; then
          BACKUP_FILE="$BACKUP_PATH_MYSQL/$db.$LOCAL_HOST.$BACKUP_NAME_TIMESTAMP.sql"
          $CMD_MYSQLDUMP -u$DB_USERNAME -h $DB_HOSTNAME -p$DB_PASSWORD $db > $BACKUP_FILE
      fi
  done
  ```
- `chmod a+x /g40/mysql/sbin/backup_mysql.sh`
- `crontab -e`
  ```bash
  10 00 * * * /bin/bash /g40/mysql/sbin/backup_mysql.sh
  ```


## 恢复
`mysql -u root -p databaseName < databaseName_backups.sql`

`gzip < databaseName_backups.sql.gz | mysql -u root -p databaseName`
