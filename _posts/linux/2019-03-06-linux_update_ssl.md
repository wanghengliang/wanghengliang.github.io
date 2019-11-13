---
layout: post
title: CentOS 6.5升级OpenSSL步骤
date: 2017-10-19
categories: linux
tags: CentOS 服务器维护
---



https://www.cnblogs.com/kyoung/p/6801143.html



linux下安装/升级openssl
 （2810）  （1）

安装环境： 

       操作系统：CentOs7

       OpenSSL Version:openssl-1.0.2j.tar.gz

安装：
       目前版本最新的SSL地址为

http://www.openssl.org/source/openssl-1.1.0e.tar.gz

备注：进入http://www.openssl.org/source/ 查看最新版本

1、将下载的压缩包放在根目录，

2、在文件夹下解压缩，命令：tar -xzf openssl-1.0.2j.tar.gz，得到openssl-1.0.2j文件夹

3、进入解压的目录：cd openssl-1.0.2j

4、设定Openssl 安装，( --prefix )参数为欲安装之目录，也就是安装后的档案会出现在该目录下：
执行命令： ./config --prefix=/usr/local/openssl

5、执行命令./config -t

6.执行make，编译Openssl

这里如果出现如下错误

make[1]: gcc: Command not found

 

上网查才发现我安装的CentOS7中没有GCC编译器

保证系统网络畅通以后，执行命令 yum -y install gcc 安装GCC（注意，一定要忘了顺畅，不然安装不了）

7、安装 Openssl:
make install

8、执行以下命令

[root@localhost /]# cd /usr/local

[root@localhost local]# ldd /usr/local/openssl/bin/openssl

会出现类似如下信息：

   

9、查看路径

...]# which openssl

    查看版本

...]# openssl version

升级：
升级openssl环境至openssl-1.0.1g

1、查看源版本
[root@zj ]# openssl version -a

OpenSSL 0.9.8e-fips-rhel5 01 Jul 2008

2、下载openssl-1.0.1g.tar.gz
wget http://www.openssl.org/source/openssl-1.0.1g.tar.gz
3、更新zlib
yum install -y zlib
4、解压安装
tar zxf openssl-1.0.1g.tar.gz
cd openssl-1.0.1g
./config shared zlib
make
make install
mv /usr/bin/openssl /usr/bin/openssl.bak
mv /usr/include/openssl /usr/include/openssl.bak
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl
ln -s /usr/local/ssl/include/openssl /usr/include/openssl
echo “/usr/local/ssl/lib” >> /etc/ld.so.conf
ldconfig -v
5、查看是否升级成功
[root@zj ]# openssl version -a

OpenSSL 1.0.1g 7 Apr 2014