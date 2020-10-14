---
layout: post
title: CentOS 6.5升级GCC步骤
date: 2020-01-13
categories: 
tags: linux
---
CentOS 6.5升级GCC步骤

### 获取安装包及其依赖项

```
wget https://ftp.gnu.org/gnu/gcc/gcc-4.9.4/gcc-4.9.4.tar.gz
tar -zxvf gcc-4.9.4.tar.gz
#下载供编译需求的依赖项
./contrib/download_prerequisites

```

### 编译安装

```
#建立一个目录供编译出的文件存放
mkdir gcc-build
cd gcc-build

#生成Makefile文件
../configure -enable-checking=release -enable-languages=c,c++ -disable-multilib

#编译，-j4选项是make对多核处理器的优化，如果不成功请使用 make
make -j4

#安装(需要root权限)
make install

#查看安装
ls /usr/local/bin | grep gcc

#查看gcc版本
gcc -v
```

