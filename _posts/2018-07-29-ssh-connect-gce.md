---
layout: post
title: SSH GCE(Google Compute Engine) 的正确姿势
categories: Linux
description: SSH GCE(Google Compute Engine) 的正确姿势
keywords: SSH, GCE, Google Compute Engine
---


亚马逊的pem虽好，但只有1C1G可以玩。谷歌的SSH比国内的阿里腾讯严一些，不过都是该漏还得漏

## TL;DR;
- 先通过浏览器登录一把
![](/images/posts/2018/07/QQ20180729-220444@2x.png)
- 再到元数据里看下你机器登录名是啥
![](/images/posts/2018/07/QQ20180729-220548@2x.png)
- 接下来如官方文档，咱们自个物理机执行一下
```bash
# KEY_FILENAME 随便，不过我发现.ssh已经很多了，所以叫gce比较贴切些
# USERNAME 就是上图看到用户名了，也不知道Google啥规则这么牛逼，shaneking_org
ssh-keygen -t rsa -f ~/.ssh/[KEY_FILENAME] -C [USERNAME]
```
- 最后 ssh 连上去
```bash
# IP_OR_DOMAIN 第一张图中马赛克掉的ip，或者自己域名解析
ssh -i ~/.ssh/gce shaneking_org@[IP_OR_DOMAIN]
```
