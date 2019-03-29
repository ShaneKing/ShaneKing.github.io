---
layout: post
title: 常用的 Linux 命令
categories: Linux
description: 常用的 Linux 命令
keywords: Linux, Command
---


以下命令皆可在<http://wangchujiang.com/linux-command/hot.html>找到

## 系统类
[备注]:表格前必须空行

| [crontab](http://wangchujiang.com/linux-command/c/crontab.html) | 提交和管理用户的需要周期性执行的任务 | `crontab -l` `crontab -e` |
| [df](http://wangchujiang.com/linux-command/c/df.html) | 显示磁盘的相关信息 | `df -h` |
| [du](http://wangchujiang.com/linux-command/c/du.html) | 显示每个文件和目录的磁盘使用空间 | `du -sh Folder` |
| [env](http://wangchujiang.com/linux-command/c/env.html) | 显示系统中已存在的环境变量 | |
| findmnt | 查看挂载 | 可能需要安装`util-linux` |
| [ps](http://wangchujiang.com/linux-command/c/ps.html) | 报告当前系统的进程状态 | `ps -ef` |


## 文件类

| [find](http://wangchujiang.com/linux-command/c/find.html) | 在指定目录下查找文件 | `find /home -name "*.txt"` |
| [ln](http://wangchujiang.com/linux-command/c/ln.html) | 用来为文件创建连接 | `ln -s Source Dist` |
| [tar](http://wangchujiang.com/linux-command/c/tar.html) | 打包和备份 | `tar -zxvf Package Path` |


## 软件类

| [rpm](http://wangchujiang.com/linux-command/c/rmp.html) | RPM软件包的管理工具 | `rpm -ivh PackageName.rpm` `rpm -e PackageName` `rpm -qa` |
| [yum](http://wangchujiang.com/linux-command/c/yum.html) | 基于RPM的软件包管理器 | `yum -y install PkgName` `yum remove PkgName` `yum -y update PkgName` `yum list PkgName` `yum search PkgName` |

