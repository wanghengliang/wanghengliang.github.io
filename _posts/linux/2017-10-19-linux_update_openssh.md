---
layout: post
title: CentOS 6.5升级OpenSSH步骤
date: 2017-10-19
categories: linux
tags: CentOS 服务器架设
---


### 安装telnet服务（我本地安装的没有做这步操作）

#### 安装软件
1. 检查CentOS7.0是否已经安装 telnet-server xinetd

```
# rpm -qa telnet-server
# rpm -qa xinetd
```

2. 安装telnet、xinetd

```
# yum -y install telnet-server* telnet
# yum install xinetd
```

3. 将telnet、xinetd服务加入开机自启动

```
systemctl enable xinetd.service
systemctl enable telnet.socket
```

4. 启动telnet、xinetd两个服务

```
systemctl start telnet.socket
systemctl start xinetd
```

5. 测试telnet能否正常登入系统


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


