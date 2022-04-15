---
layout: post
title: 评估系统性能的正确姿势
categories: [Testing, Performance]
description: 评估系统性能的正确姿势
keywords: System, Performance, 系统性能
---


我们经常被问或者问别人 "这个系统的性能怎么样？"，好像专业一点的 "这个系统的并发是多少？"，还有更专业的 "这个系统的 TPS 多少？"

这些问题是否都有一些前提（或者 `常识`）？比如成功率？比如响应时间？

这里以 SpringBoot 接口为例介绍几个评估姿势。系统性能可参考几个重要接口/常用接口的平均值，或者响应时间最长的接口，当然接口间用资源竞争除外，比如A接口和B接口用的是同一个线程池或队列等场景。

```java
  @PostMapping("/mapStream")
  public Map<String, String> mapStream(@RequestBody Map<String, String> req) {
    Map<String, String> rtnMap = Maps.newHashMap();
    req.keySet().stream().forEach(s -> rtnMap.put(s, req.get(s)));
    return rtnMap;
  }
```

## 响应时间：测出一个资源充足下响应时间
单用户依次调用接口，得到响应时间。如下图第一条可知，这个接口响应时间为`2ms`
![](/images/posts/2020/05/QQ20200516-205657@2x.png)

## 评估姿势
### 姿势一：没错就是结果
如上图最后一条（`HTTP请求=830*100`）数据，830并发下，失败率为零，响应时间为`226ms`，TPS=并发数/响应时间

### 姿势二：瓶颈资源的 TPS 为系统的 TPS
当前云环境下，大部分服务都支持横向伸缩，所以**瓶颈资源的 TPS，为系统的 TPS**，比如数据库，Redis服务器等

既然 TPS 有了，资源充足下的响应时间也有了，其它指标也可以相应推导，比如：并发数=TPS/响应时间

## 源码
<https://github.com/ShaneKingBlog/org.shaneking.demo.performance.testing>

