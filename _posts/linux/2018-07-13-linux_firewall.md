---
layout: post
title: Linux防火墙设置
date: 2018-07-13
categories: linux
tags: 防火墙
---
Linux防火墙设置

### CentOS 6.5

#### 查看防火墙的状态

#### 查看已经开放的端口

#### 开启端口

#### 启动防火墙

#### 关闭防火墙

#### 重启防火墙


### CentOS 7

#### 查看防火墙的状态

```
# firewall-cmd --state
```

#### 查看已经开放的端口

```
firewall-cmd --list-ports
```

#### 开启端口

```
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=30000-30010/tcp --permanent
```

#### 启动防火墙

```

```

#### 关闭防火墙

```
systemctl start firewalld.service #启动firewall
systemctl stop firewalld.service #停止firewall
systemctl disable firewalld.service #禁止firewall开机启动
```

#### 重启防火墙

```
firewall-cmd --reload
```
