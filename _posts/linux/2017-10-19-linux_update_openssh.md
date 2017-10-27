---
layout: post
title: CentOS 6.5升级OpenSSH步骤
date: 2017-10-19
categories: linux
tags: CentOS 服务器架设
---

### 备份当前openssh

```
# mv /etc/ssh /etc/ssh.old
```

### 卸载当前openssh

#### 查看已安装的openssh

```
# rpm -qa | grep openssh
```
 
#### 删除

```
# rpm -qa |grep openssh|xargs -i rpm -e --nodeps {}
```

