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

## Shadowsocks-libev（适合于机房其它机器通过某台外网机上网）

### 服务端
```bash
#!/usr/bin/env bash

if ! [ -x "$(command -v snap)" ]; then
  apt-get -y install snapd
  #systemctl status snapd
  systemctl enable snapd
  systemctl restart snapd
  #systemctl status snapd

  # long time
  #snap install snap-store
  #snap install snap-store-proxy
  #snap install snap-store-proxy-client
else
  echo 'snapd installed.'
fi

snap install core
snap install shadowsocks-libev
mkdir -p /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev
cat >/var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json <<EOF
{
    "server":["::0","0.0.0.0"],
    "server_port":41080,
    "local_port":1080,
    "password":"${SK_EXP_U20_ALI_SH__SL__PWD}",
    "timeout":60,
    "method":"aes-256-gcm",
    "mode":"tcp_and_udp",
    "fast_open":false
}
EOF
cat >/etc/systemd/system/shadowsocks-libev-server@.service <<EOF
[Unit]
Description=Shadowsocks-Libev Custom Server Service for %I
After=network-online.target

[Service]
Type=simple
LimitNOFILE=65536
ExecStart=/usr/bin/snap run shadowsocks-libev.ss-server -c /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/%i.json

[Install]
WantedBy=multi-user.target
EOF

systemctl enable shadowsocks-libev-server@config
systemctl restart shadowsocks-libev-server@config
#systemctl status shadowsocks-libev-server@config

```

### 客户端
```bash
#!/usr/bin/env bash

if ! [ -x "$(command -v snap)" ]; then
  apt-get -y install snapd
  #systemctl status snapd
  systemctl enable snapd
  systemctl restart snapd
  #systemctl status snapd

  # long time
  #snap install snap-store
  #snap install snap-store-proxy
  #snap install snap-store-proxy-client
else
  echo 'snapd installed.'
fi

snap install core
snap install shadowsocks-libev
mkdir -p /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev
cat >/var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json <<EOF
{
    "server":"${SK_EXP_U20_ALI_SH__SL__IP}",
    "server_port":41080,
    "local_port":1080,
    "password":"${SK_EXP_U20_ALI_SH__SL__PWD}",
    "timeout":60,
    "method":"aes-256-gcm",
    "mode":"tcp_and_udp",
    "fast_open":false
}
EOF
cat >/etc/systemd/system/shadowsocks-libev-local@.service <<EOF
[Unit]
Description=Shadowsocks-Libev Custom Client Service for %I
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/snap run shadowsocks-libev.ss-local -c /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/%i.json
Restart=on-failure
RestartSec=15

[Install]
WantedBy=multi-user.target
EOF

systemctl enable shadowsocks-libev-local@config
systemctl restart shadowsocks-libev-local@config
#systemctl status shadowsocks-libev-local@config
#systemctl disable shadowsocks-libev-local@config

# perm add
cat >>~/.bashrc <<EOF

export http_proxy=socks5://127.0.0.1:1080
export https_proxy=socks5://127.0.0.1:1080
EOF

source ~/.bashrc

# temp add
#export http_proxy=socks5://127.0.0.1:1080
#export https_proxy=socks5://127.0.0.1:1080

# temp del
#export -p
#export -n http_proxy
#export -n https_proxy

```

## OpenVPN（不推荐，容易被墙）
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
