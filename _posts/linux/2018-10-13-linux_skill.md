---
layout: post
title: Linux使用技巧
date: 2018-10-13
categories: linux
tags: linux
---
Linux使用技巧


### 单用户登录模式

1. 重启服务器，在选择内核界面使用上下箭头移动

2. 选择内核并按“e”

3. 找到下面这行
![](/images/posts/linux/skill_01_01.png)
这里要删除掉rhgb quiet，如下图
![](/images/posts/linux/skill_01_02.png)

5. 使用“ctrl + x” 来重启服务器就可以了，重启后就会进入到单用户

6. 退出单用户命令  exec /sbin/init




### 同步时间

1. 安装ntp服务

```
yum install ntp
```

2.加入crontab

```
vi /etc/crontab

## 加入如下内容
* */1 * * * root ntpdate 0.asia.pool.ntp.org
```




