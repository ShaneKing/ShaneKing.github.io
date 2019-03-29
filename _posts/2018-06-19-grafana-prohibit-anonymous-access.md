---
layout: post
title: Grafana 禁止匿名访问
categories: k8s
description: Grafana 禁止匿名访问
keywords: Kubernetes, k8s, Grafana
---


通常集群内网运行，无需权限控制。但如果有更多的人需要看到集群运行情况，则需要新增权限控制，禁止匿名访问

## 备份

### 数据源
- 查看数据源信息并记下，新增权限控制后需要手动新增
![](/images/posts/2018/06/QQ20180619-230508@2x.png)

### 仪表盘
- 导出默认的仪表盘
![](/images/posts/2018/06/QQ20180721-234946@2x.png)
[Cluster](/images/posts/2018/06/Cluster-1529723207407.json)
[Pods](/images/posts/2018/06/Pods-1529723224479.json)


## 修改

### 配置文件（grafana.yaml）
GF_AUTH_ANONYMOUS_ENABLED修改为false
```yaml
        - name: GF_AUTH_ANONYMOUS_ENABLED
          value: "false"
```

### 生效命令
`kubectl apply -f grafana.yaml`


## 配置（默认登录用户名/密码都是 admin）

### 数据源
按备份的截图配置即可（默认数据源用户名/密码都是 root）

### 仪表盘
导入 json 文件
![](/images/posts/2018/06/QQ20180722-000010@2x.png)

### 用户
按需新增配置
