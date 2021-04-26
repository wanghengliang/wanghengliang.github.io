---
layout: post
title: java应用部署到linux出现中文乱码
date: 2021-03-30
categories: 
tags: 
---
java应用部署到linux出现中文乱码



### 问题描述

应用部署在本地一切正常，部署到linux服务器后出现两个问题

* swagger出现乱码页面无法跳转
* flowable流程图出现乱码

### 问题出现的原因

因为linux没有相应的中文字体

### 问题解决办法

下载或者从本机拷贝相应中文字体文件，放到jdk字体目录下即可`/usr/java/jdk1.8.0_261/jre/lib/fonts/`。

如果是采用默认java最好重新安装java

```
$ rpm -qa |grep jdk
java-1.8.0-openjdk-headless-1.8.0.275.b01-1.el8_3.x86_64
copy-jdk-configs-3.7-4.el8.noarch
$ rpm -e --nodeps  java-1.8.0-openjdk-headless-1.8.0.275.b01-1.el8_3.x86_64
$ rpm -e --nodeps copy-jdk-configs-3.7-4.el8.noarch
## 解压jdk安装包
$ cp jdk-8u261-linux-x64.tar.gz /usr/java/
$ cd /usr/java/
$ tar -zxvf jdk-8u261-linux-x64.tar.gz
$ cp chinese_fonts.zip /usr/java/jdk1.8.0_261/jre/lib/fonts/
$ cd /usr/java/jdk1.8.0_261/jre/lib/fonts/
$ unzip chinese_fonts.zip
##配置java环境变量
$ vi /etc/profile
export JAVA_HOME=/usr/java/jdk1.8.0_261
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
$ source /etc/profile
## 测试java安装是否成功
$ java -version
java version "1.8.0_261"
Java(TM) SE Runtime Environment (build 1.8.0_261-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.261-b12, mixed mode)

```

