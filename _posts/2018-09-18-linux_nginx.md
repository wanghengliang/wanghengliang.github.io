---
layout: post
title: linux服务器架设Nginx
date: 2018-09-18
categories: 
tags: linux Nginx
---
linux服务器架设Nginx

### yum安装Nginx服务

1. 添加源：默认情况Centos7中无Nginx的源，但是Nginx官网提供了Centos的源地址。因此可以如下执行命令添加源：

```
sudo rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
```

2. 安装Nginx

```
yum install -y nginx
```

3. 启动Nginx并设置开机自动运行

```
sudo systemctl start nginx.service
sudo systemctl enable nginx.service
```

4. 配置Nginx

Nginx全局配置 /etc/nginx/nginx.conf
自定义Nginx站点配置文件存放目录 /etc/nginx/conf.d/

网站文件存放默认目录 /usr/share/nginx/html
网站默认站点配置 /etc/nginx/conf.d/default.conf


### 源码安装Nginx服务

#### 安装所需环境
##### 一. gcc 安装
安装 nginx 需要先将官网下载的源码进行编译，编译依赖 gcc 环境，如果没有 gcc 环境，则需要安装：

```
yum install gcc-c++
```

##### 二. PCRE pcre-devel 安装
PCRE(Perl Compatible Regular Expressions) 是一个Perl库，包括 perl 兼容的正则表达式库。nginx 的 http 模块使用 pcre 来解析正则表达式，所以需要在 linux 上安装 pcre 库，pcre-devel 是使用 pcre 开发的一个二次开发库。nginx也需要此库。命令：

```
yum install -y pcre pcre-devel
```

##### 三. zlib 安装
zlib 库提供了很多种压缩和解压缩的方式， nginx 使用 zlib 对 http 包的内容进行 gzip ，所以需要在 Centos 上安装 zlib 库。

```
yum install -y zlib zlib-devel
```

##### 四. OpenSSL 安装
OpenSSL 是一个强大的安全套接字层密码库，囊括主要的密码算法、常用的密钥和证书封装管理功能及 SSL 协议，并提供丰富的应用程序供测试或其它目的使用。

nginx 不仅支持 http 协议，还支持 https（即在ssl协议上传输http），所以需要在 Centos 安装 OpenSSL 库。

```
yum install -y openssl openssl-devel
```

#### 官网下载

直接下载.tar.gz安装包，地址：https://nginx.org/en/download.html

Nginx官网提供了三个类型的版本,

Mainline version：Mainline 是 Nginx 目前主力在做的版本，可以说是开发版

Stable version：最新稳定版，生产环境上建议使用的版本

Legacy versions：遗留的老版本的稳定版


#### 编译安装
tar -zxvf nginx-1.14.2.tar.gz
cd nginx-1.14.2
./configure
make && make install


### nginx服务命令

#### Nginx启动

```
nginx
```

#### Nginx重启

```
nginx -s reload
```

#### Nginx检查配置文件

```
nginx -t
```