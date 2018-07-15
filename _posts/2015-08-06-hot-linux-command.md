---
layout: post
title: 常用的 Linux 命令
categories: Linux
description: 常用的 Linux 命令
keywords: Linux
---

以下命令皆可在<http://wangchujiang.com/linux-command/hot.html>找到

## 系统类

| crontab | 提交和管理用户的需要周期性执行的任务 | `crontab -l` `crontab -e` |
| df | 显示磁盘的相关信息 | `df -h` |
| du | 显示每个文件和目录的磁盘使用空间 | `du -sh Folder` |
| env | 显示系统中已存在的环境变量 | |
| ps | 报告当前系统的进程状态 | `ps -ef` |


## 文件类

| ln | 用来为文件创件连接 | `ln -s Source Dist` |
| tar | 打包和备份 | `tar -zxvf Package Path` |


## 软件类

| rpm | RPM软件包的管理工具 | `rpm -ivh PackageName.rpm` `rpm -e PackageName` `rpm -qa` |
| yum | 基于RPM的软件包管理器 | `yum -y install PkgName` `yum remove PkgName` `yum -y update PkgName` `yum list PkgName` `yum search PkgName` |

