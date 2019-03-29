---
layout: post
title: 亚马逊云红帽安装 Kubernetes 填坑记
categories: k8s
description: 亚马逊云红帽安装 Kubernetes 填坑记
keywords: AWS, RHEL, Kubernetes, k8s
---


墙内的童子们各种捣腾，墙外安装体验

## 坑一：docker 都安装不了
```
[root@ip-172-31-46-30 ec2-user]# yum install -y docker
已加载插件：amazon-id, rhui-lb, search-disabled-repos                                                                                           |  55 MB  00:00:01     
没有可用软件包 docker。
错误：无须任何处理
```
需修改`/etc/yum.repos.d/redhat-rhui.repo`文件的`enabled`为1
```bash
[rhui-REGION-rhel-server-extras]
name=Red Hat Enterprise Linux Server 7 Extra(RPMs)
mirrorlist=https://rhui2-cds01.REGION.aws.ce.redhat.com/pulp/mirror/content/dist/rhel/rhui/server/7/$releasever/$basearch/extras/os
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release 
sslverify=1
sslclientkey=/etc/pki/rhui/content-rhel7.key
sslclientcert=/etc/pki/rhui/product/content-rhel7.crt
sslcacert=/etc/pki/rhui/cdn.redhat.com-chain.crt
```


## 坑二：安装官网配置，kubelet 装不了
```
[root@ip-172-31-46-30 ec2-user]# yum install -y kubelet
已加载插件：amazon-id, rhui-lb, search-disabled-repos
没有可用软件包 kubelet。
错误：无须任何处理
```
如下`exclude=kube*`需删除
```bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF
setenforce 0
yum install -y kubelet kubeadm kubectl
systemctl enable kubelet && systemctl start kubelet
```
