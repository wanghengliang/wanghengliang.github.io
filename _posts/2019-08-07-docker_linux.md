---
layout: post
title: docker安装
date: 2019-08-07
categories: 
tags: linux docker
---
docker安装

### 安装环境准备
1.Docker 要求 CentOS 系统的内核版本高于 3.10 ，验证你的CentOS 版本是否支持 Docker,通过 uname -r 命令查看你当前的内核版本

```
$ uname -r
3.10.0-957.21.3.el7.x86_64
```

2.确保 yum 包更新到最新

```
$ sudo yum update
```

3.卸载旧版本(未安装可跳过)

```
$ sudo yum remove docker  docker-common docker-selinux docker-engine
```

### docker安装

1.安装需要的软件包， yum-utils 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的

```
$ sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

2.设置yum源

```
$ sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```
或者
```
$ sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

3.查看所有仓库中所有docker版本，并选择特定版本安装

```
$ yum list docker-ce --showduplicates | sort -r
Loading mirror speeds from cached hostfile
Loaded plugins: fastestmirror
docker-ce.x86_64            3:19.03.1-3.el7                     docker-ce-stable
docker-ce.x86_64            3:19.03.0-3.el7                     docker-ce-stable
docker-ce.x86_64            3:18.09.8-3.el7                     docker-ce-stable
docker-ce.x86_64            3:18.09.7-3.el7                     docker-ce-stable
docker-ce.x86_64            3:18.09.6-3.el7                     docker-ce-stable
docker-ce.x86_64            3:18.09.5-3.el7                     docker-ce-stable
docker-ce.x86_64            3:18.09.4-3.el7                     docker-ce-stable
docker-ce.x86_64            3:18.09.3-3.el7                     docker-ce-stable
docker-ce.x86_64            3:18.09.2-3.el7                     docker-ce-stable
docker-ce.x86_64            3:18.09.1-3.el7                     docker-ce-stable
docker-ce.x86_64            3:18.09.0-3.el7                     docker-ce-stable
docker-ce.x86_64            18.06.3.ce-3.el7                    docker-ce-stable
docker-ce.x86_64            18.06.2.ce-3.el7                    docker-ce-stable
docker-ce.x86_64            18.06.1.ce-3.el7                    docker-ce-stable
docker-ce.x86_64            18.06.0.ce-3.el7                    docker-ce-stable
docker-ce.x86_64            18.03.1.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            18.03.0.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.12.1.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.12.0.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.09.1.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.09.0.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.06.2.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.06.1.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.06.0.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.03.3.ce-1.el7                    docker-ce-stable
docker-ce.x86_64            17.03.2.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.03.1.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.03.0.ce-1.el7.centos             docker-ce-stable
Available Packages
```

4.安装docker

```
$ sudo yum install docker-ce  #由于repo中默认只开启stable仓库，故这里安装的是最新稳定版19.03.1
```
或者
```
$ sudo yum install <FQPN>  # 例如：sudo yum install docker-ce-19.03.1
```

4.1 centos8安装报错

```
$ sudo yum install docker-ce
上次元数据过期检查：0:00:14 前，执行于 2021年04月21日 星期三 05时58分41秒。
错误：
 问题: package docker-ce-3:20.10.6-3.el8.x86_64 requires containerd.io >= 1.4.1, but none of the providers can be installed
  - package containerd.io-1.4.3-3.1.el8.x86_64 conflicts with runc provided by runc-1.0.0-70.rc92.module_el8.3.0+699+d61d9c41.x86_64
  - package containerd.io-1.4.3-3.1.el8.x86_64 obsoletes runc provided by runc-1.0.0-70.rc92.module_el8.3.0+699+d61d9c41.x86_64
  - package containerd.io-1.4.3-3.2.el8.x86_64 conflicts with runc provided by runc-1.0.0-70.rc92.module_el8.3.0+699+d61d9c41.x86_64
  - package containerd.io-1.4.3-3.2.el8.x86_64 obsoletes runc provided by runc-1.0.0-70.rc92.module_el8.3.0+699+d61d9c41.x86_64
  - package containerd.io-1.4.4-3.1.el8.x86_64 conflicts with runc provided by runc-1.0.0-70.rc92.module_el8.3.0+699+d61d9c41.x86_64
  - package containerd.io-1.4.4-3.1.el8.x86_64 obsoletes runc provided by runc-1.0.0-70.rc92.module_el8.3.0+699+d61d9c41.x86_64
  - problem with installed package buildah-1.16.7-4.module_el8.3.0+699+d61d9c41.x86_64
  - package buildah-1.16.7-4.module_el8.3.0+699+d61d9c41.x86_64 requires runc >= 1.0.0-26, but none of the providers can be installed
  - cannot install the best candidate for the job
  - package runc-1.0.0-56.rc5.dev.git2abd837.module_el8.3.0+569+1bada2e4.x86_64 is filtered out by modular filtering
  - package runc-1.0.0-64.rc10.module_el8.3.0+479+69e2ae26.x86_64 is filtered out by modular filtering
(尝试在命令行中添加 '--allowerasing' 来替换冲突的软件包 或 '--skip-broken' 来跳过无法安装的软件包 或 '--nobest' 来不只使用最佳选择的软件包)
```

先查看containerd.io版本，是否有满足要求的版本（containerd.io >= 1.4.1），有就直接安装，没有就通过其他途径安装（如通过Centos7的RPM包进行安装）

```
$ yum list containerd.io --showduplicates | sort -r
containerd.io.x86_64               1.4.4-3.1.el8                docker-ce-stable
containerd.io.x86_64               1.4.3-3.2.el8                docker-ce-stable
containerd.io.x86_64               1.4.3-3.1.el8                docker-ce-stable
containerd.io.x86_64               1.3.9-3.1.el8                docker-ce-stable
containerd.io.x86_64               1.3.7-3.1.el8                docker-ce-stable
containerd.io.x86_64               1.2.6-3.3.el7                @@commandline
$ sudo yum install containerd.io
$ sudo yum install docker-ce
```



5.启动并加入开机启动

```
$ sudo systemctl start docker
$ sudo systemctl enable docker
```

6.验证安装是否成功(有client和service两部分表示docker安装启动都成功了)

```
$ docker version
Client: Docker Engine - Community
 Version:           19.03.1
 API version:       1.40
 Go version:        go1.12.5
 Git commit:        74b1e89
 Built:             Thu Jul 25 21:21:07 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.1
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.5
  Git commit:       74b1e89
  Built:            Thu Jul 25 21:19:36 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.6
  GitCommit:        894b81a4b802e4eb2a91d1ce216b8817763c29fb
 runc:
  Version:          1.0.0-rc8
  GitCommit:        425e105d5a03fabd737a126ad93d62a9eeede87f
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```


```
#!/bin/bash

docker run -name=aosun-website -p 80:80\
-v /data/aosunsoft/nginx/nginx.conf:/etc/nginx/nginx.conf\
-v /data/aosunsoft/nginx/conf.d:/etc/nginx/conf.d\
-v /data/aosunsoft/nginx/logs:/var/log/nginx\
-v /data/aosunsoft/wwwroot:/usr/share/nginx/html\
-d nginx

```

### docker-compose 安装

Linux 上我们可以从 Github 上下载它的二进制包来使用，最新发行的版本地址：https://github.com/docker/compose/releases。

运行以下命令以下载 Docker Compose 的当前稳定版本：

```
## 要安装其他版本的 Compose，请替换 1.29.1。
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

将可执行权限应用于二进制文件,并创建软链：

```
$ sudo chmod +x /usr/local/bin/docker-compose
$ sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

测试是否安装成功：

```
$ docker-compose --version
docker-compose version 1.29.1, build c34c88b2
```



