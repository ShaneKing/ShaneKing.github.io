---
layout: post
title: Kubernetes 修改暴露的端口范围（nodePort）
categories: Linux
description: Kubernetes 修改暴露的端口范围（nodePort）
keywords: Kubernetes, 🈳️k8s, nodePort
---

阿里云的云监控插件（cloudmonitor）升级到1.3.4后，占用了32000端口，导致Kubernetes Dashboard启动不起来，将Dashboard改为33000后还是启动不起来，经查是因为Kubernetes中NodePort端口默认范围是30000-32767

## 修改脚本
```bash
sed -i '/    - kube-apiserver/a\    - --service-node-port-range=1-65535' /etc/kubernetes/manifests/kube-apiserver.yaml
systemctl restart kubelet
kubectl apply -f /etc/kubernetes/manifests/kube-apiserver.yaml
```


## Appendix

![](/images/posts/2018/07/QQ20180722-154109@2x.png)
