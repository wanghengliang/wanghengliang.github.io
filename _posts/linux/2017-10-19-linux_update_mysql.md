---
layout: post
title: 保留旧版本安装新版本MySQL
date: 2017-10-19
categories: linux
tags: MySQL 服务器架设
---
保留旧版本安装新版本mysql

### 准备工作

#### 下载新版本MySQL
下载地址：http://www.mysql.com/downloads/

依次选择 MySQL Community Edition (GPL) MySQL社区版（GPL）--> MySQL Community Server (GPL) MySQL社区服务器（GPL）

操作系统选择：Source Code

下载如下版本：Generic Linux (Architecture Independent), Compressed TAR Archive Includes Boost Headers
> 选择包含Boost的Generic Linux版本，应为每个版本对应的Boost版本有要求，直接选择包含Boost的版本不会出现版本不对应的情况

#### 添加系统mysql组和mysql用户

查看是否有mysql组和mysql用户，没有则添加

```
# cat /etc/passwd
# cat /etc/group
# groupadd mysql
# useradd -r -g mysql mysql
```

#### 创建安装目录并修改目录拥有者

```
# mkdir /usr/local/mysql5725
# mkdir /data/mysql5725
# 小版本更新可以直接复制原来版本的数据文件
# cp -r /data/mysql5723 /data/mysql5725
# 
# chown -R mysql:mysql /usr/local/mysql5725
# chown -R mysql:mysql /data/mysql5725

# mkdir /etc/mysql5725
```


#### 备份MySQL

```
/usr/local/mysql/bin/mysqldump -uroot -p db_name > db_bak_db_name_20160822.sql
```

### 安装cmake

```
# wget https://cmake.org/files/v3.13/cmake-3.13.3.tar.gz
# tar -xzvf cmake-3.13.3.tar.gz
# cd cmake-3.13.3
./bootstrap
gmake && gmake install
```

### 安装新版本MySQL
然后解压并跳转到解压目录进行编译安装

```
# tar -xzvf mysql-boost-5.7.19.tar.gz
# cd mysql-boost-5.7.19

# cmake . \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql5725 \
-DMYSQL_DATADIR=/data/mysql5725 \
-DMYSQL_UNIX_ADDR=/data/mysql5725/mysql.sock \
-DSYSCONFDIR=/etc/mysql5725 \
-DMYSQL_USER=mysql \
-DMYSQL_TCP_PORT=3308 \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_general_ci \
-DEXTRA_CHARSETS=all \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_EMBEDDED_SERVER=1 \
-DWITH_BOOST=boost/boost_1_59_0

# make && make install
```

> DWITH_BOOST参数对应的是刚刚解压后的boost目录

> DSYSCONFDIR参数为配置文件my.cnf存放路径

初始化mysqld
小版本升级时采用原来的数据时请忽略此操作
```
# bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql5725 --datadir=/data/mysql5725
```

> 初始化后会生成默认临时密码，记住密码一会儿登录时需要：A temporary password is generated for root@localhost: ET#&dQs_p22%

添加mysql配置文件

```
# vi /etc/mysql5725/my.cnf
...
```

添加启动项配置

```
# cd /usr/local/mysql5725/support-files
# cp mysql.server /etc/init.d/mysql5725
```

修改/etc/init.d/mysql5725文件中的如下代码

```
basedir=/usr/local/mysql5725
datadir=/data/mysql5725
```

设置为系统服务

```
# chkconfig --add mysql5725
```

启动服务

```
# service mysql5725 restart
...

# /usr/local/mysql5725/bin/mysql -uroot -p
Enter password: 
...
mysql>
```
输入之前初始化时候的密码进入，首次使用会有提示修改密码

```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'abc1';
mysql> FLUSH PRIVILEGES;
```

小版本升级并采用原来数据文件时，请采用下面命令进行升级操作(密码还是原来的密码，应为用的原来数据)

```
# cd /usr/local/mysql5725/bin
# ./mysqld_safe --user=mysql --socket=/data/mysql5725/mysql.sock -p --skip-grant-tables  --datadir=/data/mysql5725/data
# ./mysql_upgrade -uroot -p -S /data/mysql5725/mysql.sock
# 重启
# service mysql5725 restart

```


### 测试MySQL
重启并测试

```
# service mysql5725 restart
...

# /usr/local/mysql5725/bin/mysql -uroot -p     
Enter password: 
...
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)

```

旧版本测试

```
# mysql -uroot -p
Enter password: 
...
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)
```

通过如下命令可查看两个mysql的端口和连接数信息

查询端口

```
mysql> show global variables like 'port';
```

查询连接数

```
mysql> show processlist;
```

### 删除旧版本
如果是升级可迁移数据后删除旧版本

```
# rpm -qa | grep mysql
mysql-connector-odbc-5.1.5r1144-7.el6.x86_64
mysql-libs-5.1.71-1.el6.x86_64
mysql-5.1.71-1.el6.x86_64
mysql-server-5.1.71-1.el6.x86_64
```

逐一卸载

```
# rpm -e mysql-connector-odbc-5.1.5r1144-7.el6.x86_64
# rpm -e mysql-libs-5.1.71-1.el6.x86_64
# rpm -e mysql-5.1.71-1.el6.x86_64
# rpm -e mysql-server-5.1.71-1.el6.x86_64
```






备份原来数据库数据

下载通用安装二进制包

建立用户和目录

解压

mkdir -p /data/db

cd /data/db
tar -xzvf mysql mysql-5.7.25-el7-x86_64.tar.gz
ln -s mysql-5.7.25-el7-x86_64 mysql
cd mysql
mkdir data //如果mysql目录下没有data目录，手动建一个
mkdir tmp //如果mysql目录下没有tmp目录，手动建一个
chown mysql:mysql -R .

//初始化
bin/mysqld --initialize --user=mysql --datadir=/data/db/mysql/data --basedir=/data/db/mysql

bin/mysql_install_db --user=mysql --datadir=/data/db/mysql/data  --basedir=/data/db/mysql

//配置
cp /support-files/my-default.cnf /etc/my.cnf

my.cnf中关键配置：
[mysqld]
basedir = /data/db/mysql
datadir = /data/db/mysql/data
port = 3306
socket = /data/db/mysql/tmp/mysql.sock

//设置mysql以服务运行并且开机启动
修改support-files/mysql.server中的basedir和datadir为相应路径
vi support-files/mysql.server
  basedir = /data/db/mysql
  datadir = /data/db/mysql/data

cp support-files/mysql.server /etc/init.d/mysql
chmod +x /etc/init.d/mysql

//把mysql注册为开机启动的服务
chkconfig --add mysql

//启动
service mysql start

//查看mysql的root用户当前密码
cat /root/.mysql_secret


//登陆mysql
mysql -uroot -p
-bash: mysql: command not found
//原因:这是由于系统默认会查找/usr/bin下的命令，如果这个命令不在这个目录下，当然会找不到命令，我们需要做的就是映射一个链接到/usr/bin目录下，相当于建立一个链接文件。
ln -s /data/db/mysql/bin/mysql /usr/bin


```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'abc1';
mysql> FLUSH PRIVILEGES;
```



逐一卸载
```
# rpm -e mysql-community-server-5.7.22-1.el7.x86_64
# rpm -e mysql-community-client-5.7.22-1.el7.x86_64
# rpm -e mysql-community-libs-5.7.22-1.el7.x86_64
# rpm -e mysql-community-common-5.7.22-1.el7.x86_64
```