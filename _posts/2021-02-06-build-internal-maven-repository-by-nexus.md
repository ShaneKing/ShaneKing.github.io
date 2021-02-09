---
layout: post 
title: 基于 Nexus 搭建 Maven 私服 
categories: Java 
description: 基于 Nexus 搭建 Maven 私服 
keywords: Nexus, Maven
---


私服：自嗨的代名词。由于部分开源软件的版本节奏差异，有时候要打一些开源软件的补丁，等不及开源软件版本，特此有了搭私服的需求。

## 要求
- java
- maven
- npm

## 安装
```bash
if [ ! -d ${SK_EXP__GIR_REPO_DIR}/workspace/1612622024868_t4WFmTyaXpeY5bXPcNf ]; then
  mkdir -p ${SK_EXP__GIR_REPO_DIR}/workspace/1612622024868_t4WFmTyaXpeY5bXPcNf && cd ${SK_EXP__GIR_REPO_DIR}/workspace/1612622024868_t4WFmTyaXpeY5bXPcNf
  # 链接: https://pan.baidu.com/s/104JoiD01xBm6yJjHUZUbKQ 提取码: 1n4t 复制这段内容后打开百度网盘手机App，操作更方便哦
  wget http://share.nps.shaneking.org/software/com/sonatype/nexus-3.29.2-02-unix.tar.gz
  mkdir -p /usr/local/nexus && cd /usr/local/nexus
  tar -xzvf ${SK_EXP__GIR_REPO_DIR}/workspace/1612622024868_t4WFmTyaXpeY5bXPcNf/nexus-3.29.2-02-unix.tar.gz -C .
  sed -i "s|application-port=8081|application-port=${SK_EXP__NEXUS__PORT}|g" /usr/local/nexus/nexus-3.29.2-02/etc/nexus-default.properties
  /usr/local/nexus/nexus-3.29.2-02/bin/nexus start

  cat >/etc/nginx/conf.d/nexus.conf <<EOF
server {
    listen 80;
    server_name ${SK_EXP__NEXUS__DOMAIN};
    location / {
        proxy_set_header Host \$host:\$server_port;
        proxy_pass http://127.0.0.1:${SK_EXP__NEXUS__PORT};
    }
}
EOF
  nginx -s reload

  cd ${SK_EXP__GIR_REPO_DIR}
else
  echo 'nexus installed.'
fi
```

## 配置
### 禁止匿名
因为暴露在公网上，补丁又不一定是最终合入主分支的版本，所以禁止匿名访问，如果是内网，就没有必要了。

![](/images/posts/2021/02/WX20210208-000023@2x.png)

### 设置帐号
```xml
<!--~/.m2/settings.xml-->
<servers>
  <server>
    <id>NexusMirror</id>
    <username>admin</username>
    <password>admin123</password>
  </server>
  <!-- nexus just for snapshot
  <server>
    <id>releases</id>
    <username>username</username>
    <password>password</password>
  </server>
  -->
  <server>
    <id>snapshots</id>
    <username>username</username>
    <password>password</password>
  </server>
</servers>
```

### 设置下载
```xml
<!--~/.m2/settings.xml-->
<mirrors>
  <!--default is central-->
  <!-- maybe no storage, haha
  <mirror>
    <id>NexusMirror</id>
    <name>NexusMirror</name>
    <url>http://nexus.shaneking.org/repository/maven-public/</url>
    <mirrorOf>*</mirrorOf>
  </mirror>
  -->
  <!--https://segmentfault.com/a/1190000017402970-->
  <mirror>
    <id>snapshots</id>
    <name>snapshots</name>
    <url>http://nexus.shaneking.org/repository/maven-public/</url>
    <mirrorOf>snapshots</mirrorOf>
  </mirror>
</mirrors>
```

## 使用
### 设置上传
```xml
<!--pom.xml-->
<distributionManagement>
  <!-- nexus just for snapshot
  <repository>
    <id>releases</id>
    <url>http://nexus.shaneking.org/nexus/content/repositories/releases/</url>
  </repository>
  -->
  <snapshotRepository>
    <id>snapshots</id>
    <url>http://nexus.shaneking.org/repository/maven-snapshots/</url>
  </snapshotRepository>
</distributionManagement>
```

## 参考
<https://www.cnblogs.com/java-linux/p/10263568.html>

<https://www.cnblogs.com/zishengY/p/7794923.html>
