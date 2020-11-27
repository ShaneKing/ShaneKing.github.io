---
layout: post
title: 树莓派初体验
categories: RPI
description: 树莓派初体验
keywords: ARM, Raspberry Pi, URL
---


随着 Apple M1 发布，ARM 从手持终端跃进了办公桌面。为了提前适应这个可能的未来霸主，树莓派搞起来！

## 烧盘方式安装 RaspiOS
如果是购买的官方 SD 卡，可跳过"准备SD盘"，"下载系统"及"烧系统盘"章节

### 准备SD盘
通过 [SD Memory Card Formatter](https://www.sdcard.org/downloads/formatter/) 格式化 SD 卡（树莓派官方建议使用最小容量为8G[^1]）

### 下载系统
下载 [树莓派（32位）](http://downloads.raspberrypi.org/raspios_full_armhf/images/?C=M;O=D)（[64位](http://downloads.raspberrypi.org/raspios_arm64/images/?C=M;O=D) 还在 Beta，看客可尝鲜。）

### 烧系统盘
通过 [Etcher](https://www.etcher.net/download/) 烧到 SD 卡中

### 启动系统
插上各种设备，通上电！

### 初始设置
- Set County
  - （选择）China
  - （选择）Chinese
  - （选择）Shanghai
  - （勾选）Use English language（如果不介意英文的话）
  - （勾选）Use US Keyboard
  - Next
- Change Password
  - 按需修改
  - Next
- Set Up Screen
  - （想满屏就勾选）This screen shows a black border around the desktop（博主小屏幕不勾选的话，重启系统后会保留一点边框）
  - Next
- Select Wireless Network
  - 按需选择
  - Next
- Update Software
  - Skip
- Setup Complete
  - Restart

### 更新快源
- 备份
```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
```
- 修改软件源
```bash
sudo nano /etc/apt/sources.list
```
修改内容：
```bash
deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib
```
Ctrl+o 保存，之后回车确认，然后 Ctrl+x 退出。
- 修改系统源
```bash
sudo nano /etc/apt/sources.list.d/raspi.list
```
修改内容：
```bash
deb http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ buster main ui
# Uncomment line below then 'apt-get update' to enable 'apt-get source'
#deb-src http://archive.raspberrypi.org/debian/ stretch main ui
```
- 按需更新源
```bash
#更新软件源列表
sudo apt-get update
#更新软件版本
sudo apt-get upgrade
sudo apt-get dist-upgrade
#更新系统内核
sudo rpi-update
```
- 如果出现公钥问题，可将 Raspbian public key 加入 apt-get keyring
```bash
wget http://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -
```

### 配输入法
- （推荐）`sudo apt-get install ibus ibus-pinyin`（安装后在 开始 -> Preference -> iBus Preferences 配置）
  - General -> Keyboard Shortcuts： <Super>space 改为 <Control>space（Mac习惯）
  - input Method：添加（Add）Chinese -> Pinyin
- （或）`sudo apt-get install fcitx fcitx-googlepinyin fcitx-module-cloudpinyin fcitx-sunpinyin`
- （或）`sudo apt-get install scim-pinyin`

### 内网穿透
参考：https://service.oray.com/question/11639.html
- VNC 默认端口 5900，可点击软件右上角菜单按钮，在 Options 中的 Connections 里修改
![](/images/posts/2020/11/WX20201126-223002@2x.png)

### 远程桌面
- 树莓派：开始 -> Preference -> Raspberry Pi Configuration -> Interfaces
  - （Enable）SSH
  - （Enable）VNC
- 本机：下载 [VNC 客户端](https://www.realvnc.com/en/connect/download/viewer/)
![](/images/posts/2020/11/WX20201127-180627@2x.png)

**注意**：重新格式化时别选 `Overwrite format` 选项，贼慢。该选项仅适合于卡坏或读不出来的情况[^2]

## NOOBS 方式安装 RaspiOS
- 下载 [最新版](https://www.raspberrypi.org/downloads/noobs/) 或 [历史版](http://downloads.raspberrypi.org/NOOBS/images/?C=M;O=D) NOOBS
- 将 NOOBS 压缩包的内容全部解压到 SD 卡根目录（注意是内容全部到根目录）
- 哦了～接下来就各种 Next 了

**注意**：一定要使用 HDMI0, 否则一直是彩虹屏[^3]（博主已踩坑，忘绕过）

![](/images/posts/2020/11/Debug-screen.jpg)

至此：通过蓝牙鼠标键盘及USB供电的HDMI屏幕，基本实现一个插头供电的可远程操作小电脑。好了，现在这块板子可以随便丢到那个犄角旮旯里去了。

![](/images/posts/2020/11/WechatIMG52.jpeg)

[^1]:[SD card size (capacity)](https://www.raspberrypi.org/documentation/installation/sd-cards.md)
[^2]:[What is the difference between Quick and Overwrite format methods?](https://www.sdcard.org/downloads/formatter/faq/#faq13)
[^3]:[Coloured splash screen](https://elinux.org/R-Pi_Troubleshooting)

