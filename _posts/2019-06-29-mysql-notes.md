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
delimiter $$
drop procedure if exists p_yourtablename_create;
create procedure p_yourtablename_create() begin
if not exists (select * from information_schema.tables where table_schema = 'yourschema' and table_name = 'yourtablename')
then
create table `yourschema`.`yourtablename` (
  `id` int not null comment 'id',
  primary key (`id`)
);
end if;
end;
call p_yourtablename_create();
drop procedure if exists p_yourtablename_create;
$$
delimiter ; 
```
