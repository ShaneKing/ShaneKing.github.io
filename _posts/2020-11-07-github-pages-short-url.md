---
layout: post
title: GitHub Pages 短域名
categories: [Tips, GitHub]
description: GitHub Pages 短域名
keywords: Github, Short, URL
---


TL;DR;

请求：
```
curl -i https://git.io -F 'url=https://ShaneKing.github.io' -F 'code=shaneking'
```

响应：
```bash
HTTP/1.1 201 Created
Server: Cowboy
Connection: keep-alive
Date: Sat, 07 Nov 2020 04:41:12 GMT
Status: 201 Created
Content-Type: text/html;charset=utf-8
Location: https://git.io/shaneking
Content-Length: 27
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Runtime: 0.018109
X-Node: e4109ba8-8c13-4911-a83e-c33bfef2f1b6
X-Revision: 392798d237fc1aa5cd55cada10d2945773e741a8
Strict-Transport-Security: max-age=31536000; includeSubDomains
Via: 1.1 vegur

https://ShaneKing.github.io%
```

效果：通过访问 <https://git.io/shaneking> 看到浏览器先重定向到 <https://ShaneKing.github.io> ，再重定向到 <https://shaneking.org/> 。
![](/images/posts/2020/11/WX20201122-192216@2x.png)
