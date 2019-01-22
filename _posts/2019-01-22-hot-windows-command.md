---
layout: post
title: 常用的 Windows 命令
categories: Windows
description: 常用的 Windows 命令
keywords: Windows, Command
---


如有不明，可百科。

## 系统类

| nbtstat | 查看局域网内ip对应机器名 | `nbtstat -A 10.0.0.99` |


## 文件类

| certutil | 查看文件MD5/SHA1/SHA256 | `certutil -hashfile yourfilename.ext MD5` |
| del | 删除文件（支持通配符） | `del /f /s /q yourfilename.ext` |
| mklink | 用来为文件创建连接 | `mklink /J targetDir sourceDir` |
| rd | 删除目录 | `rd /s /q yourdir` |

