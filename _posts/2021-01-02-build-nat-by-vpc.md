---
layout: post
title: 基于 VPC 搭建 NAT
categories: [Network, VPC]
description: 基于 VPC 搭建 NAT
keywords: VPC, NAT
---


整完外网访问内网，就该整内网访问外网了。VPN 代理模式 跟 SNAT 使用场景还是有差的

## 需求
内网机通过公网机联网

## 分析
VPN 只能代理代理 HTTP 啥的，遇到 wget 什么的就麻烦了，基于 iptables 还是有点啰嗦的，结合来看还是 VPC 简洁

## 设计
### 所需材料
- 一台 VPC 公网 ECS

### 限制条件
- 内网机与公网机在同一个 VPC 下

## 开发
### VPC
![](/images/posts/2021/01/QQ20210101-173933@2x.png)

### ECS
```bash
# 开启firewalld防火墙
systemctl enable firewalld
systemctl start firewalld

# 网卡默认是在public的zone内，也是默认zone。永久添加源地址转换功能
firewall-cmd --add-masquerade --permanent
firewall-cmd --reload
 
# 添加网卡的ip转发功能
cat >>/etc/sysctl.conf <<EOF

net.ipv4.ip_forward=1
EOF
  
# 重载网络配置生效
sysctl -p
```
## 验证
```bash
[root@sk-ecs-bdwk ~]# ping shaneking.org
PING shaneking.org (185.199.111.153) 56(84) bytes of data.
64 bytes from 185.199.111.153 (185.199.111.153): icmp_seq=1 ttl=48 time=37.8 ms
64 bytes from 185.199.111.153 (185.199.111.153): icmp_seq=2 ttl=48 time=37.8 ms
64 bytes from 185.199.111.153 (185.199.111.153): icmp_seq=3 ttl=48 time=37.5 ms
^C
--- shaneking.org ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 6ms
rtt min/avg/max/mdev = 37.465/37.675/37.803/0.149 ms
[root@sk-ecs-bdwk ~]#
```

## 参考
<https://amos-x.com/index.php/amos/archives/centos7-aliyun-nat/>
