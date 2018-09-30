---
layout: post
title: linux服务器架设Nginx
date: 2018-09-18
categories: linux
tags: linux Nginx
---
linux服务器架设Nginx

### 安装Nginx服务

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

### 配置Nginx

Nginx全局配置 /etc/nginx/nginx.conf
自定义Nginx站点配置文件存放目录 /etc/nginx/conf.d/

网站文件存放默认目录 /usr/share/nginx/html
网站默认站点配置 /etc/nginx/conf.d/default.conf


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