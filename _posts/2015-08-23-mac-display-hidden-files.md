---
layout: post
title: Mac 显示隐藏文件
categories: Mac
description: Mac 显示隐藏文件
keywords: Mac, Finder
---


> 作为一个开发者，怎么可以忍受有自己看不到的东西呢。就跟jar一定要sources一样，虽然这个比较危险（误操作）

## 命令模式
显示隐藏文件命令：`defaults write com.apple.finder AppleShowAllFiles -bool YES`

需要重启Finder：`killall Finder`

同理隐藏命令：`defaults write com.apple.finder AppleShowAllFiles -bool NO`


## 对话框场景
在打开和保存对话框中，可通过 <kbd>Command+Shift+.</kbd> 来 显示/隐藏 隐藏文件


## Finder模式
在普通的Finder窗口实现 <kbd>Command+Shift+.</kbd> 显示/隐藏 隐藏文件
1. 打开Automator.app
2. 选择 <u>服务</u>
3. 在 <u>资源库</u> 中选中 <u>Run Shell Script</u> 并将它拖到右边的工作区中
4. 输入下列代码
    ```bash
    STATUS=`defaults read com.apple.finder AppleShowAllFiles`
    if [ $STATUS == YES ];
    then
    defaults write com.apple.finder AppleShowAllFiles NO
    else
    defaults write com.apple.finder AppleShowAllFiles YES
    fi
    killall Finder
    ```
5. 在上边的 <u>“服务”收到选定的</u> 下拉菜单中选择 <u>no input</u>
6. 将工作流程保存为`Toggle Hidden Files`
7. 此刻Finder的 <u>服务</u> 菜单便会出现刚才制作的 <u>Toggle Hidden Files</u> 选项
8. 打开 <u>系统偏好设置</u> 的 <u>键盘</u> ，点击 <u>快捷键选项卡</u> ，在左边选择 <u>服务</u> ，然后勾上 <u>Toggle Hidden Files</u> ，在它的右边双击鼠标，然后按下想要设定成为的快捷键。如：<kbd>Command+Shift+.</kbd>


## 右键菜单模式
将上面第5步改为：在 <u>“服务”收到选定的</u> 下拉菜单中选择 <u>文件和文件夹</u>


## Appendix
![](/images/posts/2015/QQ20150823-1@2x.png)
