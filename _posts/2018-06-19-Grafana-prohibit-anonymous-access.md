---
layout: post
title: Grafana禁止匿名访问
categories: k8s
description: Grafana禁止匿名访问
keywords: Kubernetes, k8s, Grafana
---


## 备份

### 数据源

![](/images/posts/2018/QQ20180619-230508@2x.png)

### 仪表盘

![](/images/posts/2018/QQ20180721-234946@2x.png)

[Cluster](/images/posts/2018/Cluster-1529723207407.json)

[Pods](/images/posts/2018/Pods-1529723224479.json)


## 修改

### 配置文件（grafana.yaml）

GF_AUTH_ANONYMOUS_ENABLED修改为false
```yaml
        - name: GF_AUTH_ANONYMOUS_ENABLED
          value: "false"
```

### 生效命令

`kubectl apply -f grafana.yaml`


## 配置（默认登录用户名/密码都是admin）

### 数据源

按备份的截图配置即可（默认数据源用户名/密码都是root）

### 仪表盘

导入json文件即可

![](/images/posts/2018/QQ20180722-000010@2x.png)

### 用户

按需新增配置
