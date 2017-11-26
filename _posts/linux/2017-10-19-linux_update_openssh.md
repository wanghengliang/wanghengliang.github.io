---
layout: post
title: CentOS 6.5升级OpenSSH步骤
date: 2017-10-19
categories: linux
tags: CentOS 服务器架设
---


### 安装telnet服务（我本地安装的没有做这步操作）

#### 安装软件
1 # yum -y install telnet-server* telnet

2.启用telnet服务
# vi /etc/xinetd.d/telnet 
将其中disable字段的yes改为no以启用telnet服务 
# mv /etc/securetty /etc/securetty.old    #允许root用户通过telnet登录 
# service xinetd start                    #启动telnet服务 
# chkconfig xinetd on                    #使telnet服务开机启动，避免升级过程中服务器意外重启后无法远程登录系统

3.测试telnet能否正常登入系统

### 卸载当前openssh
#### 备份当前openssh

```
# mv /etc/ssh /etc/ssh.old
# mv /etc/init.d/sshd /etc/init.d/sshd.old
```

#### 卸载当前openssh

##### 查看已安装的openssh

```
# rpm -qa | grep openssh
```
 
##### 删除

```
# rpm -qa |grep openssh|xargs -i rpm -e --nodeps {}
```


