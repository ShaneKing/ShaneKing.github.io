---
layout: post 
title: Mac 中使用 readlink
categories: Mac 
description: Mac 中使用 readlink 
keywords: readlink, greadlink
---


相对总是容易让人找不到位置，N 轮相对后更是如此。特别是 Shell 程序，readlink 绝对的好帮手

## 问题
Mac 下运行 readlink 程序报如下错误
```bash
readlink: illegal option -- f
usage: readlink [-n] [file ...]
```

## 解决
```bash
brew install coreutils

### macos 10.15 before
cat >>~/.bash_profile <<EOF

# sk$(date +'%Y%m%d%H%M%S')
alias readlink=greadlink
EOF
source ~/.bash_profile

### macos 10.15 and after
cat >>~/.zprofile <<EOF

# sk$(date +'%Y%m%d%H%M%S')
alias readlink=greadlink
EOF
source ~/.zprofile
```
