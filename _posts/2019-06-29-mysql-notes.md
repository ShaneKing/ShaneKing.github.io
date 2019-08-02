---
layout: post
title: Mysql 笔记
categories: Mysql
description: Mysql 笔记
keywords: Mysql
---


好记性不如烂笔头！

## 语句类

### 可重复执行语句
建表样例，建索引需借助`information_schema.statistics`
```sql
drop procedure if exists p_yourtablename_create;
delimiter $$
create procedure p_yourtablename_create() begin
if not exists (select * from information_schema.tables where table_schema = 'yourschema' and table_name = 'yourtablename')
then
create table `yourschema`.`yourtablename` (
  `id` int not null comment 'id',
  primary key (`id`)
);
end if;
end;
$$
delimiter ; 
call p_yourtablename_create();
drop procedure if exists p_yourtablename_create;
```

### 导入（支持导入本地文件）
`load data[ local] infile '/tmp/TableName.csv'[ replace] into table TableName fields terminated by ',' optionally enclosed by '"' lines terminated by '\n'[ ignore 1 lines][ (column1,column2...)]`

### 导出（仅支持导出到服务器，所以需要外挂盘）
`select * from TableName into outfile '/tmp/TableName.csv' fields terminated by ',' optionally enclosed by '"' lines terminated by '\n'`

## 权限类

### select ... into outfile 需要 file 权限
`grant file on *.* to 'UserName'@'HostName'[ Identified by 'Passwd'][ with grant option]`
### all privileges
`grant all privileges on *.* to 'UserName'@'HostName'[ Identified by 'Passwd'][ with grant option]`
