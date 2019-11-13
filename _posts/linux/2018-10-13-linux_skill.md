---
layout: post
title: Linux使用技巧
date: 2018-10-13
categories: linux
tags: linux
---
Linux使用技巧


### 单用户登录模式

1. 重启服务器，在选择内核界面使用上下箭头移动

2. 选择内核并按“e”

3. 找到下面这行
![](/images/posts/linux/skill_01_01.png)
这里要删除掉rhgb quiet，如下图
![](/images/posts/linux/skill_01_02.png)

5. 使用“ctrl + x” 来重启服务器就可以了，重启后就会进入到单用户

6. 退出单用户命令  exec /sbin/init


### 图形界面切换命令行界面
```
ctrl+alt+F2
```

### 同步时间

1. 安装ntp服务

```
yum install ntp
```

2. 加入crontab

```
vi /etc/crontab

## 加入如下内容
* */1 * * * root ntpdate 0.asia.pool.ntp.org
```

### linux下对一个文件设置多个组的权限

```
//获得文件的访问控制列表
[user1@localhost dir]$ getfacl dir001
# file: dir001
# owner: user1
# group: user1
user::rwx
group::r-x
other::r--

//配置多个组能够读写的权限
[user1@localhost dir]# setfacl -m g:user1:rw,g:user2:rw dir001
[user2@localhost dir]$ getfacl dir001
# file: dir001
# owner: user1
# group: user1
user::rwx
group::r-x
group:user1:rw-
group:user2:rw-
mask::rw-
other::r--

//删除组控制权限
[user1@localhost dir]# setfacl -x g:user2 dir001
[user2@localhost dir]$ getfacl dir001
# file: dir001
# owner: user1
# group: user1
user::rwx
group::r-x
group:user1:rw-
mask::rw-
other::r--

```


### 升级zlib步骤(顺序错误导致误删zlib后果很严重)

1. 下载[zlib](http://www.zlib.net/) ，我下载的是zlib-1.2.11.tar.gz

2. 解压编译

```
# tar -zxvf zlib-1.2.11.tar.gz
# cd zlib-1.2.11
# ./configure
# make && make install
```
编译是可能报错

```
Compiler error reporting is too harsh for ./configure (perhaps remove -Werror).
```

解决办法是，打开configure文件删除以下行

```
echo "Checking for obsessive-compulsive compiler options..." >> configure.log

if try $CC -c $CFLAGS $test.c; then
  :
else
  echo "Compiler error reporting is too harsh for $0 (perhaps remove -Werror)." | tee -a configure.log
  leave 1
fi
```

3. 不用执行卸载zlib命令，误删后基本上所有的命令都执行不了

恢复办法i
a，尝试利用ext3grep进行找回/lib 和/usr/lib下的库文件（可能是/lib64和/usr/lib64）
b，从其他机子或者u盘拷贝回来libz.so.1.y.z文件
c，从新安装新版本(可能无法编译，可能需要旧版本的zlib)

```
ln -s /usr/lib/libz.so.1.y.z /usr/lib/libz.so.1
ln -s /usr/lib/libz.so.1.y.z /usr/lib/libz.so
```


### 修改主机名
1.centos6修改方法

```
$ vi /etc/sysconfig/network
$ vi /etc/hosts
```

2.centos7修改方法

```
$ vi /etc/hostname
$ vi /etc/hosts
$ reboot
```

### 常用软件安装

```
$ yum install lrzsz

$ yum install -y unzip zip
```

### 其他


traceroute命令（路由跟踪）



查看当前目录下的文件数量（不包含子目录中的文件）

```
ls -l|grep "^-"| wc -l
```

查看当前目录下的文件数量（包含子目录中的文件）

```
ls -lR|grep "^-"| wc -l
```

查看当前目录下的文件夹目录个数（不包含子目录中的目录）

```
ls -l|grep "^d"| wc -l
```



