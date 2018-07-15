---
layout: page
title: About
description: ShaneKing's Blog
keywords: ShaneKing, sk, org.shaneking, Azolla, Maogu
comments: false
menu: About
permalink: /about/
---

这是 **ShaneKing** 的个人博客，建于2011.10.10，算是个技术类博客吧（毕竟博主是个敲代码的）

本博客记录着博主的点点滴滴！有什么用？

## 关于内容
崇尚原创

记记经历，碎碎阅历，说说屁事，谈谈破事，想想未来！

## 个人信息
男子，88年落地，在11年毕业于一所二流大学（某省理工大学）

略懂软件开发，假装对设计及架构很有研究

毕业后入职Neusoft，再经iSoftStone，而后eBaoTech，现工作于爱存不存

## 联系方式
{% for website in site.data.social %}
* {{ website.sitename }}：[@{{ website.name }}]({{ website.url }})
{% endfor %}

## [个人简历](http://resume.qmail.com/sk/y6yYXbQSiDs)
{% for category in site.data.skills %}
### {{ category.name }}
<div class="btn-inline">
{% for keyword in category.keywords %}
<button class="btn btn-outline" type="button">{{ keyword }}</button>
{% endfor %}
</div>
{% endfor %}

