---
layout: post
title: 利用 NFS 实现分布式锁
categories: Java
description: 利用 NFS 实现分布式锁
keywords: Java, NFS, Lock, FileLock
---


看遍了各种基于数据库（主键；版本号；排他等），基于缓存（Redis；Redlock等），基于分布式（ZooKeeper；Consul等）的分布式锁，来个简单的基于文件的分布式锁

## 场景
- 假设这块共享存储挂载在各应用服务器中（比如 `/nfsroot/nfs1`）

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
<https://github.com/ShaneKingBlog/org.shaneking.demo.nfs.file.lock>
