---
layout: page
title: About
description: ShaneKing's Blog
keywords: ShaneKing, sk, org.shaneking
comments: false
menu: About
permalink: /about/
---

这是 **ShaneKing** 的个人博客，始建于2011.10.10，算是个技术类博客吧（毕竟博主是个敲代码的）

从懵懂的Wordpress，至Java+Bootstrap自建，到现在的静态化Markdown。部分内容也由于格式等原因未能完全迁移

关注软件的维护性，可扩展性，致力于软件的高质量，快速开发

## 关于内容
崇尚原创

记记经历，碎碎阅历，说说屁事，谈谈破事，想想未来！


## 个人信息
男子，88年落地，11年毕业于某省理工大学

略懂软件开发，假装对设计及架构很有研究

毕业后入职Neusoft，再经iSoftStone，而后eBaoTech，现工作于爱存不存


## 联系方式
* GitHub：[ShaneKing](https://github.com/ShaneKing)
* Mail：<a target="_blank" href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=5NXW19fX1dLR3KSVlcqHi4k" style="text-decoration:none;"><img src="http://rescdn.qqmail.com/zh_CN/htmledition/images/function/qm_open/ico_mailme_01.png"/></a>
* QQ：<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=123331658&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:123331658:51" alt="发起聊天" title="发起聊天"/></a>


## [简历](http://resume.qmail.com/sk/y6yYXbQSiDs)


## 技能
{% for category in site.data.skills %}
### [{{ category.name }}]({{ category.url }})
<div class="btn-inline">
{% for keyword in category.keywords %}
<button class="btn btn-outline" type="button">{{ keyword }}</button>
{% endfor %}
</div>
{% endfor %}


## 产品
{% for product in site.data.products %}
* {{ product.desc }}：[{{ product.name }}]({{ product.url }})
{% endfor %}


## 公益
{% for commonweal in site.data.commonweals %}
* {{ commonweal.desc }}：[{{ commonweal.name }}]({{ commonweal.url }})
{% endfor %}


## 发表
- [彭金胜.一种新型的Web国际化解决思路及实践[J].软件,2018,39(07):143-145+193.](http://kns.cnki.net/KCMS/detail/detail.aspx?dbcode=CJFQ&dbname=CJFDLAST2018&filename=RJZZ201807030&v=MDM1MzlCTnlmUmRMRzRIOW5NcUk5R1pJUjhlWDFMdXhZUzdEaDFUM3FUcldNMUZyQ1VSTE9mWStkckZ5emhVYnI=)

## 专利
- [彭金胜.数据访问控制方法及装置:中国,202010257974.3[P].2020-07-28.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SCPD&dbname=SCPD2020&filename=CN111460506A&v=5vMonWIcXV85CJxX8Yk8YXEVRXdvqG4K3LHRVcYjENOC1PgecuobHkA1awXN8nmg)
- [彭金胜.一种任务调度方法、装置及存储介质:中国,	CN202110290109.3[P].2021-05-14.](https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SCPD&dbname=SCPD2021&filename=CN112801546A&v=k6pIBPvTDdNXLKvZR7OcW2qbKoWnfWeidjdKcpKp9EDDoULvwkHWy7Ak9%25mmd2BKD0iyt)
