---
layout: post
title: 探索：IE8 中使用 canvas
categories: HTML
description: 探索：IE8 中使用 canvas
keywords: 探索, IE8, canvas
---


前两天单位买了个图形操作类产品，准备用于业务系统中。但是那个图形产品是基于 canvas 的，而业务系统的 X-UA-Compatible 还停留在 IE8 水平。于是乎，折腾开始了...

## 使 IE8 支持 canvas
前面补了一堆 polyfill 就不说了，想要 IE8 支持 canvas，右边两个 js 是少不了的：[excanvas.compiled.js](/images/posts/2019/03/excanvas.compiled.js) 和 [html5.js](/images/posts/2019/03/html5.js)
- getContext 报错
  - 创建节点 `var nodeElement = document.createElement(“canvas”);` 后
  - 要先 `G_vmlCanvasManager.initElement(nodeElement)`
  - `getContext` 之前，还必须先 append 节点 `$(‘main’).appendChild(nodeElement);`
- fillText 报错
  - 直接替换 [excanvas.compiled.js](/images/posts/2019/03/excanvas.compiled.js) 为 [excanvas.js](/images/posts/2019/03/excanvas.js) 即可


## 提升 iframe 的 X-UA-Compatible
理论上没有什么问题了（网上说的其它问题还没遇到）。但是天宫不作美，压缩过的源码改了一堆，还行报错，所以想提升 X-UA-Compatible。
早年的业务系统，都是 iframe 套 iframe，一层一层的，为了控制影响，所以想仅提升 iframe 内的 X-UA-Compatible，但是不管怎么提都提不上来，最后看完这几张图，果断转弯。
![](/images/posts/2019/03/3817-dc94-o.gif)
![](/images/posts/2019/03/3818-54b0-o.gif)
![](/images/posts/2019/03/3819-cb39-o.gif)

图基本一看就明白，iframe 想在 X-UA-Compatible=IE8 的页面里提升 documentMode，没门！


## 提升系统的 X-UA-Compatible
终极大法
