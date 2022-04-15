---
layout: post
title: location 中 alias 与 root 的区别
categories: [FrontEnd, Nginx]
description: location 中 alias 与 root 的区别
keywords: Nginx, location, alias, root
---


机器上有多块 nfs 外挂盘，分别为 nfs1，nfs2，nfs3。。。期望 nginx 匹配配置。

## 区别
- alias 必须以 `/` 结尾
- alias 只能在 location 块中
- 对于 location 后的 url，映射方式不同
  ```
  location /nfs1/ {
      alias|root /nfsroot/nfs1/;
  }
  ```
  当请求/nfs1/path/test.html时：
  - alias：alias 替换 location。所以访问的是：`/nfsroot/nfs1/path/test.html`
  - root：root 追加 location。所以访问的是：`/nfsroot/nfs1/nfs1/path/test.html`

## 实现
```
location /nfs {
    root /nfsroot/;
}
```
