---
layout: post
title: 离线安装 Rancher2.2.7 HA 集群
categories: [K8S, Rancher]
description: 离线安装 Rancher2.2.7 HA 集群
keywords: Kubernetes, k8s
---


无坑安装！

## 环境
阿里云（上海节点）

| IP             | HOST NAME             | OS        | Software    | Network |
| :------------- | :-------------------- | :-------- | :---------- | :------ |
| 172.19.200.125 | dev-ecs-cluster-entry | CentOS7.6 | git, nginx  | 有外网   |
| 172.19.200.127 | dev-ecs-cluster-m1    | CentOS7.6 |             | 无      |  
| 172.19.200.128 | dev-ecs-cluster-m2    | CentOS7.6 |             | 无      |  
| 172.19.200.129 | dev-ecs-cluster-m3    | CentOS7.6 |             | 无      |  
| 172.19.200.132 | dev-ecs-cluster-s1    | CentOS7.6 |             | 无      |  
| 172.19.200.133 | dev-ecs-cluster-s2    | CentOS7.6 |             | 无      |  

## 安装
### entry
```bash
git clone https://github.com/ShaneKing/sk.sh.git
cd sk.sh

cp a0_please_source_first.sh.sample a0_please_source_first.sh
# vim a0_please_source_first.sh 
## modify SK_EXP_C7_ALI_SH__RANCHER__ALI_REGISTRY_PWD and SK_EXP_C7_ALI_SH__RANCHER__RANCHER_USR_PWD
# vim c7_ali_sh__rancher__110_node.sh
## modify ip hostname etc...
# vim c7_ali_sh__rancher__120_entry.sh
## modify ip hostname etc...

source a0_please_source_first.sh
sh c7_ali_sh__rancher__100_entry.sh
exit
## exit for /ect/profile
```

### nodes
```bash
cd sk.sh
source a0_please_source_first.sh
sh c7_ali_sh__rancher__110_node.sh
```

### entry
```bash
cd sk.sh
source a0_please_source_first.sh
sh c7_ali_sh__rancher__120_entry.sh
```

## 参考
<https://www.cnblogs.com/weavepub/p/11053099.html>

<https://www.cnrancher.com/docs/rancher/v2.x/cn/installation/air-gap-installation/ha/>
