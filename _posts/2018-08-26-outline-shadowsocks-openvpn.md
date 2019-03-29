---
layout: post
title: 科学上网：Outline <- ShadowSocks <- OpenVPN
categories: Linux
description: 科学上网：Outline <- ShadowSocks <- OpenVPN
keywords: Outline, ShadowSocks, OpenVPN
---


因为亚马逊的一年免费，只有1C1G，基本上跑不了什么，搭个 VPN 用于科学上网却非常适合，于是乎有了从 OpenVPN 到 Outline 的使用经历

## Outline（强烈推荐）
Google 解决地缘政治问题的产物，基于 ShadowSocks（简称 SS），SS 相对于 OpenVPN 的好处就是，自建协议，加密传输，估计这也是 OpenVPN 为啥用了两天就连不上的原因

### Outline Manager
Outline Manager 是管理 Outline Server GUI客户端，下载并安装 Outline Manager

<https://github.com/Jigsaw-Code/outline-releases/tree/master/manager>

### Outline Server
选择亚马逊，并根据提示打开火墙。然后通过命令安装 
```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh)"
```
PS：
1. 实例要是 Ubuntu。其它实例会报安装 Docker 错误，估计提前装好也行
2. 如果有安装 Docker 的提示，输入Y
3. 如有有需要 root 权限的提示，输入Y

### 命令返回
```json
{"apiUrl":"https://your-public-ip:port/xYZ","certSha256":"XXX"}
```
在 Outline Manager 中输入上述`命令返回`的 JSON，就可以了

### 新增key（`ss://xxxxxx`）
![](/images/posts/2018/08/WX20180829-192822@2x.png)

### Outline Client
从 App Store美国下载 Outline Client，贴入上面的key即可。美国帐号可参考：

<https://bbs.feng.com/read-htm-tid-11716266.html>


## ShadowSocks
还没装就发现了Outline，写在这里你懂的

REF：<http://celerysoft.github.io/2016-01-15.html>

## OpenVPN
REF：<https://www.jianshu.com/p/e20254d0baa3>

PS：
1. udp1194端口也要开
2. 如果连不上，估计ip被墙了，需要停止再启动实例（不是终止），这样会更换ip

### 可通过如下命令安装：
```bash
sudo apt-get update && sudo apt-get -y install git tcl tk expect && git clone https://github.com/ShaneKing/openvpn-install.git && cd openvpn-install && chmod +x openvpn-install.sh && sudo ./openvpn-install.sh ${PWD} ${OPENVPN_VERSION}
```
PS：
1. `PWD`：openvpn的密码，默认`XSW@1qaz`
2. `OPENVPN_VERSION`：默认`openvpn-as-2.5.2-Ubuntu16.amd_64.deb`
