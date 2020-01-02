---
layout: post
title: 利用 NFS 实现分布式锁
categories: Java
description: 利用 NFS 实现分布式锁
keywords: Java, NFS, Lock, FileLock
---


大部分分布式都存在单点，或许不是很正确。比如区块链，虽然每个客户端都保留帐本是非常浪费存储资源的。或许将控制节点多副本的 Zookeeper 模式是个比较好的选择，至少好于 Quartz 以数据库为控制中心的集群模式及本文的基于 NFS 的分布式文件锁模式。

对于中小型系统而言，通常是单库（一个数据库实例）多应用副本（好几台应用服务器，前端 Nginx 负载均衡）模式。想要实现一个生产消费模式，势必会涉及到锁。如果条件允许，使用消息队列（Kafka等）的方式会更合适。本文以 NFS 作为单点，通过 Java 的文件锁方式，解决重复消费问题。

## 场景
- 生产的数据存于数据库表 `t_task` 中
- 消费的结果存于一块共享存储中，以便各应用服务器都能读写
- 假设这块共享存储挂载在各应用服务器的 `/nfsroot/nfs1` 中

## 实现
```

```

## 源码
<https://github.com/ShaneKing/org.shaneking.demo.nfs.file.lock>
