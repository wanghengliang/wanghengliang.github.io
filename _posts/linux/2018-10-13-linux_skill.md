---
layout: post
title: Linux使用技巧
date: 2018-10-13
categories: 
tags: linux
---
Linux使用技巧

### 安装linux后配置

#### 配置主机名

```
$ hostname
$ vi /etc/hostname
```

#### 配置网络

```
## 安装net-tools
$ yum -y install net-tools
## 修改网络配置
$ cd /etc/sysconfig/network-scripts/
$ vi ifcfg-enp0s3
$ less ifcfg-enp0s3

TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="none"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="enp0s3"
UUID="bb52f7c9-24c5-41a0-94db-7e86dfb561b2"
DEVICE="enp0s3"
ONBOOT="yes"
IPADDR="192.168.0.231"
PREFIX="21"
GATEWAY="192.168.0.1"
DNS1="114.114.114.114"
IPV6_PRIVACY="no"

## 重启网络服务
$ service network restart
## 查看网络信息
$ ifconfig -a
```

#### 配置yum源信息

```
## 先安装wget，下载163源需要
$ yum install wget
## 备份原来的源
$ cd /etc/yum.repos.d/
$ mkdir repo_backup
$ mv *.repo repo_backup/
## 下载163源
$ wget http://mirrors.163.com/.help/CentOS7-Base-163.repo
## 清除yum缓存
$ yum clean all
## 刷新yum源
$ yum repolist
## 更新yum包
$ yum update -y
```

#### 安装docker

```
## 在 CentOS 7安装docker要求系统为64位、系统内核版本为 3.10 以上，可以使用以下命令查看
$ uname -r
3.10.0-1127.el7.x86_64
## 安装docker 下面两个安装一个就可以
### 官网脚本(https://get.docker.com)
$ wget -qO- https://get.docker.com | sh
### 国内脚本(https://get.daocloud.io/docker)
$ curl -sSL https://get.daocloud.io/docker | sh
## 查看docker版本
$ docker version
## 启动docker
$ service docker start
## 设置开机启动
$ systemctl enable docker
```
或者
```
## 在 CentOS 7安装docker要求系统为64位、系统内核版本为 3.10 以上，可以使用以下命令查看
$ uname -r
3.10.0-1127.el7.x86_64

## 官方安装说明：https://docs.docker.com/engine/install/centos/
## 卸载老版本
$ yum list installed | grep docker
$ yum -y remove docker*
## 安装docker
$ yum install -y yum-utils
$ yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
$ yum install docker-ce docker-ce-cli containerd.io
## 查看docker版本
$ docker version
## 启动docker
$ service docker start
## 设置开机启动
$ systemctl enable docker
```

#### 安装docker-compose

```
## 安装python-pip
$ yum -y install epel-release
$ yum -y install python-pip

## 升级python-pip
$ pip install --upgrade pip

## 安装docker-compose
$ yum -y install gcc python-devel
$ pip install six --user -U
$ pip install docker-compose
```



#### 配置docker

```
$ mkdir -p /etc/docker
$ vi /etc/docker/daemon.json
$ less /etc/docker/daemon.json

{
        "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
```

#### 安装nodejs

```
yum -y update
wget https://nodejs.org/dist/v12.18.3/node-v12.18.3-linux-x64.tar.xz
mkdir -p /mnt/nodejs
tar -xvf node-v12.18.3-linux-x64.tar.xz
mv node-v12.18.3-linux-x64  nodejs
ln -s /mnt/nodejs/node-v12.18.3-linux-x64 latest
ln -s latest default
ln -s latest default
ln -s /mnt/nodejs/default/bin/npm /usr/local/bin/
ln -s /mnt/nodejs/default/bin/node /usr/local/bin/

```

修改配置文件vi /etc/profile,修改后使其生效 source /etc/profile

```
export NODE_HOME=/usr/local/bin/node/
export PATH=$NODE_HOME/bin:$PATH
```

检验nodejs是否已变为全局

```
node -v
```





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

top命令按E可以切换显示单位K、M、G、T、P

traceroute命令（路由跟踪）


使用 netstat 查看 端口信息 
```
netstat -tnlp 
```

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



