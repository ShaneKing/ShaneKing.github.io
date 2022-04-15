---
layout: post 
title: 你的代码怎么样？ 
categories: [BackEnd, Java, Sonar] 
description: 你的代码怎么样？ 
keywords: Sonar, SonarQube
---


你的代码怎么样？抛开体系架构不谈，抛开模式设计不说，抛开性能指标不看。除去个人的思想及手法，回到代码的基本功本身。Sonar

## 要求
https://docs.sonarqube.org/latest/requirements/requirements/
- JDK11[^1]：`dnf -y install java-11-openjdk-devel`
- PostgreSQL[^2]
  - UTF8[^1]
  - `ALTER USER sonaruser SET search_path to sonarschema`[^3]

## 安装
```bash
if [ ! -d ${SK_EXP__GIR_REPO_DIR}/workspace/1612870559333_SDfsRpNpStjSEsOGHqk ]; then
  mkdir -p ${SK_EXP__GIR_REPO_DIR}/workspace/1612870559333_SDfsRpNpStjSEsOGHqk && cd ${SK_EXP__GIR_REPO_DIR}/workspace/1612870559333_SDfsRpNpStjSEsOGHqk
  wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.6.1.40680.zip
  mkdir -p /usr/local/sonar && cd /usr/local/sonar
  unzip -o ${SK_EXP__GIR_REPO_DIR}/workspace/1612870559333_SDfsRpNpStjSEsOGHqk/sonarqube-8.6.1.40680.zip -d ./
  cp /usr/local/sonar/sonarqube-8.6.1.40680/conf/sonar.properties /usr/local/sonar/sonarqube-8.6.1.40680/conf/sonar.properties_skbak$(date +'%Y%m%d%H%M%S')
  sed -i "s|#sonar.web.port=9000|sonar.web.port=${SK_EXP__SONAR__PORT}|g" /usr/local/sonar/sonarqube-8.6.1.40680/conf/sonar.properties
  sed -i "s|#sonar.jdbc.username=|sonar.jdbc.username=${SK_EXP__SONAR__PG_USER}|g" /usr/local/sonar/sonarqube-8.6.1.40680/conf/sonar.properties
  sed -i "s|#sonar.jdbc.password=|sonar.jdbc.password=${SK_EXP__SONAR__PG_PWD}|g" /usr/local/sonar/sonarqube-8.6.1.40680/conf/sonar.properties
  sed -i "s|#sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube?currentSchema=my_schema|sonar.jdbc.url=${SK_EXP__SONAR__PG_URL}|g" /usr/local/sonar/sonarqube-8.6.1.40680/conf/sonar.properties

  if id -u sonar >/dev/null 2>&1; then
    echo 'sonar exists'
  else
    useradd -g root sonar
  fi

  chmod -R 775 /usr/local/sonar
  su - sonar -c '/usr/local/sonar/sonarqube-8.6.1.40680/bin/linux-x86-64/sonar.sh start'
  #su - sonar -c '/usr/local/sonar/sonarqube-8.6.1.40680/bin/linux-x86-64/sonar.sh stop'

  cd ${SK_EXP__GIR_REPO_DIR}
else
  echo 'sonar installed.'
fi
```

## 配置
默认 admin/admin 登录后，新增 Token

![](/images/posts/2021/02/WX20210211-090229@2x.png)
## 使用
### setting.xml
```xml
<pluginGroup>org.sonarsource.scanner.maven</pluginGroup>
```
### pom.xml
```xml
<plugin>
  <groupId>org.sonarsource.scanner.maven</groupId>
  <artifactId>sonar-maven-plugin</artifactId>
  <version>${org.sonarsource.scanner.maven_sonar-maven-plugin_version}</version>
</plugin>
```
### mvn
`mvn sonar:sonar -Dsonar.host.url=http://sonar.shaneking.org -Dsonar.login=上面新增的Token`

## 效果
![](/images/posts/2021/02/WX20210211-092435@2x.png)

## 参考
<https://www.cnblogs.com/passedbylove/p/12432955.html>

<https://github.com/jchowdhary/junit5-spring-boot-rest-springmvc-sonar>

[^1]:[Prerequisites and Overview](https://docs.sonarqube.org/latest/requirements/requirements)
[^2]:[PostgreSQL 笔记](https://shaneking.org/2019/06/29/postgresql-notes/)
[^3]:[Install the Server](https://docs.sonarqube.org/latest/setup/install-server)
