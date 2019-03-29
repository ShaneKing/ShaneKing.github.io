---
layout: post
title: Web 中的 px em rem
categories: CSS
description: Web 中的 px em rem
keywords: CSS, Web, px, em, rem
---


不管响应式是否崛起，自适应是否流行，等比缩放一直都是一件让人很舒服的事情

## px

### "绝对大小" －－ 在同一块屏幕中
指包含多少个像素点，因为屏幕的分辨率（像素密度，即ppi）不一样，所以px算是一个相对的绝对值


## em

### 相对大小 －－ 相对 body 元素
- 对于元素 font-size 属性而言是相对父元素 font-size
- 对于没有 font-size 属性的元素而言，其他属性也是相对父元素 font-size
- 对于有 font-size 属性的元素而言，其他属性是相对自身的 font-size


## rem

### 相对大小 －－ 相对 html 元素


## Appendix
浏览器默认情况下设置 body 元素及 html 元素的 font-size 为 16px
