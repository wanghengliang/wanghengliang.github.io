---
layout: post
title: Linux网络设置
date: 2018-07-13
categories: 
tags: linux 网络
---
Linux网络设置

### IP设置

#### 查看IP地址

```
# ifconfig
```

#### 网络接口配置文件修改配置

文件路径是/etc/sysconfig/network-scripts/

```
# vi /etc/sysconfig/network-scripts/ifcfg-网络接口名称
```

修改以下配置

```
TYPE=Ethernet
BOOTPROTO=static
HWADDR=00:0c:29:ce:3f:3c  #MAC地址
IPADDR=192.168.1.104     #静态IP
BROADCAST=192.168.1.255 #广播地址
GATEWAY=192.168.1.2     #默认网关
NETMASK=255.255.255.0    #子网掩码
DNS1=192.168.1.2         #DNS配置
```

#### 重启网络服务

```
# service network restart
```