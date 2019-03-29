---
layout: post
title: BeyondCompare 破解方法
categories: Mac
description: BeyondCompare 破解方法
keywords: BeyondCompare
---


全靠registry.dat

## 手工模式
删除 `rm /Users/$(whoami)/Library/Application Support/Beyond Compare/registry.dat` 文件即可。

## 自动模式
1. `mv "/Applications/Beyond Compare.app/Contents/MacOS/BCompare" "/Applications/Beyond Compare.app/Contents/MacOS/BCompare.bak"`
2. `vim "/Applications/Beyond Compare.app/Contents/MacOS/BCompare"`
```bash
#!/bin/bash
rm "/Users/$(whoami)/Library/Application Support/Beyond Compare/registry.dat"
"`dirname "$0"`"/BCompare.bak $@
```
3. `chmod a+x "/Applications/Beyond Compare.app/Contents/MacOS/BCompare"`
