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
```java
package org.shaneking.demo.nfs.file.lock;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;
import java.text.MessageFormat;

public class NFSFileLock {
  public static final int MAX_TRY_TIMES = 10;
  public static final String FMT_FAILED = "Lock file {0} failed, th{1}.";
  public static final String FMT_SUCCESSFULLY = "Lock file {0} successfully, th{1}.";

  public static void main(String[] args) {
    RandomAccessFile randomAccessFile = null;
    FileChannel fileChannel = null;
    FileLock fileLock = null;

    try {
      File lockFile = new File(args[0]);
      if (!lockFile.exists()) {
        lockFile.getParentFile().mkdirs();
        lockFile.createNewFile();
      }
      randomAccessFile = new RandomAccessFile(lockFile, "rw");
      fileChannel = randomAccessFile.getChannel();
      int tryTimes = 0;
      while (fileLock == null && tryTimes < MAX_TRY_TIMES) {
        try {
          fileLock = fileChannel.tryLock();
        } catch (IOException e) {
          e.printStackTrace();
        }
        if (fileLock == null) {
          System.out.println(MessageFormat.format(FMT_FAILED, lockFile.getAbsolutePath(), tryTimes));
          if (!lockFile.exists()) {
            lockFile.getParentFile().mkdirs();
            lockFile.createNewFile();
          }
          tryTimes++;
          Thread.sleep(10000);//10
        } else {
          System.out.println(MessageFormat.format(FMT_SUCCESSFULLY, lockFile.getAbsolutePath(), tryTimes));
        }
      }
      if (fileLock != null) {
        //TODO some logic here
        Thread.sleep(100000);//100, Just to make the test more obvious
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      if (fileLock != null) {
        try {
          fileLock.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
      if (fileChannel != null) {
        try {
          fileChannel.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
      if (randomAccessFile != null) {
        try {
          randomAccessFile.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
    }
  }
}

```

## 测试
### 准备
```bash
[user@dev-cluster-s1 ~]% df -h | grep cluster
abcdefghig-12345.cn-shanghai.nas.aliyuncs.com:/   10P  106M   10P   1% /dev-nas-cluster
ossfs                                            256T     0  256T   0% /dev-oss-cluster
[user@dev-cluster-s2 ~]% df -h | grep cluster
abcdefghig-12345.cn-shanghai.nas.aliyuncs.com:/   10P  106M   10P   1% /dev-nas-cluster
ossfs                                            256T     0  256T   0% /dev-oss-cluster


[user@dev-cluster-s2 ~]% mkdir -p /dev-nas-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock
[user@dev-cluster-s2 ~]% mkdir -p /dev-oss-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock

[user@dev-cluster-s2 org.shaneking.demo.nfs.file.lock]% yum -y list java*
[user@dev-cluster-s2 org.shaneking.demo.nfs.file.lock]% yum -y install java-11-openjdk*
[user@dev-cluster-s2 org.shaneking.demo.nfs.file.lock]% yum -y install java-1.8.0-openjdk*
```

### nas
```bash
[user@dev-cluster-s1 org.shaneking.demo.nfs.file.lock]% java -cp org.shaneking.demo.nfs.file.lock-0.10.0.jar org.shaneking.demo.nfs.file.lock.NFSFileLock /dev-nas-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock/test.lock
Lock file /dev-nas-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock/test.lock successfully, th0.

[user@dev-cluster-s2 org.shaneking.demo.nfs.file.lock]% java -cp org.shaneking.demo.nfs.file.lock-0.10.0.jar org.shaneking.demo.nfs.file.lock.NFSFileLock /dev-nas-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock/test.lock
Lock file /dev-nas-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock/test.lock failed, th0.
Lock file /dev-nas-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock/test.lock failed, th1.
```

### oss
```bash
[user@dev-cluster-s1 org.shaneking.demo.nfs.file.lock]% java -cp org.shaneking.demo.nfs.file.lock-0.10.0.jar org.shaneking.demo.nfs.file.lock.NFSFileLock /dev-oss-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock/test.lock
Lock file /dev-oss-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock/test.lock successfully, th0.

[user@dev-cluster-s2 org.shaneking.demo.nfs.file.lock]% java -cp org.shaneking.demo.nfs.file.lock-0.10.0.jar org.shaneking.demo.nfs.file.lock.NFSFileLock /dev-oss-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock/test.lock
Lock file /dev-oss-cluster/workspace/github/shaneking/org.shaneking.demo.nfs.file.lock/test.lock successfully, th0.
```

## 结论
NAS（NFS）支持分布式文件锁，OSS（S3FS）不支持。

## 源码
<https://github.com/ShaneKing/org.shaneking.demo.nfs.file.lock>
