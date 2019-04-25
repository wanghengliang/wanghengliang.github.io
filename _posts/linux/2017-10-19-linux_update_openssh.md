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

5. 开启防火墙端口

```
firewall-cmd --zone=public --add-port=23/tcp --permanent
firewall-cmd --reload
firewall-cmd --list-ports
```


6. 测试telnet能否正常登入系统

```
telnet 192.168.0.111
```

telnet 112.18.251.41


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


#### 安装新版本openssh

##### 安装相关依赖包

```
# yum install -y gcc openssl-devel pam-devel rpm-build
```

##### 下载安装包

```
wget https://cloudflare.cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.9p1.tar.gz



```

##### 编译安装

```
tar -zxvf openssh-7.9p1.tar.gz
cd openssh-7.9p1
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-md5-passwords--with-pam --with-tcp-wrappers  --with-ssl-dir=/usr/local/ssl --without-hardening
rm -rf /etc/ssh
make && make install

```

##### 安装完成，执行配置

```
cp contrib/redhat/sshd.init /etc/init.d/sshd
chkconfig --add sshd
chkconfig sshd on
chkconfig --list|grep sshd
sed -i "PermitRootLogin yes" /etc/ssh/sshd_config
systemctl restart sshd
```

##### 查看版本

```
systemctl status sshd
ssh -V
```


#### 修改配置文件

```
useradd maihe
passwd maihe
```

```
vi /etc/ssh/sshd_config

# Port 22
# PermitRootLogin yes

改为
Port 22323
PermitRootLogin no //禁止root远程ssh登录
```

```
service sshd restart
```

注意 需要关闭selinux，否则或无法登录(总是提示Permission denied, please try again错误)

```
// 临时关闭
# setenforce 0
// 永久关闭，修改 selinux 配置文件将SELINUX=enforcing改为SELINUX=disabled，保存后退出
# vi /etc/selinux/config
SELINUX=disabled
```
