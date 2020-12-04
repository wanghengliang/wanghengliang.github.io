---
layout: post
title: 保留旧版本安装新版本MySQL
date: 2017-10-19
categories: database
tags: linux MySQL 服务器架设
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
# mkdir /usr/local/mysql5728
# mkdir /data/mysql5728
# 小版本更新可以直接复制原来版本的数据文件
# cp -r /data/mysql5728 /data/mysql5728bak    安装好新版本后重命名 mv /data/mysql5727 /data/mysql5728
# 
# chown -R mysql:mysql /usr/local/mysql5728
# chown -R mysql:mysql /data/mysql5728

# mkdir /etc/mysql5728
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
# tar -xzvf mysql-boost-5.7.28.tar.gz
# cd mysql-boost-5.7.28

# cmake . \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql5728 \
-DMYSQL_DATADIR=/data/mysql \
-DMYSQL_UNIX_ADDR=/data/mysql/mysql.sock \
-DSYSCONFDIR=/etc/mysql5728 \
-DMYSQL_USER=mysql \
-DMYSQL_TCP_PORT=3306 \
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

# echo $?  //查看下最后的make install是否有报错，0表示没有问题
```

> DWITH_BOOST参数对应的是刚刚解压后的boost目录

> DSYSCONFDIR参数为配置文件my.cnf存放路径


添加mysql配置文件

```
# vi /etc/mysql5728/my.cnf
...
```

添加启动项配置并删除原来的启动项

```
# cd /usr/local/mysql5728/support-files
# cp mysql.server /etc/init.d/mysql5728
```

修改/etc/init.d/mysql5728文件中的如下代码

```
# vi /etc/init.d/mysql5728


basedir=/usr/local/mysql5728
datadir=/data/mysql
```

设置为系统服务并删除原来的服务

```
# chkconfig --add mysql5728
```

 修改alias重新指定mysql启动程序

 ```
# vi ~ /.bash_profile

alias mysql="/usr/local/mysql5728/bin/mysql"
alias mysqldump="/usr/local/mysql5728/bin/mysqldump"


# source ~ /.bash_profile
 ```


#### 小版本升级

```
## 停止老版本
# service mysql5727 stop

## 拷贝数据文件(保留原版本数据)
# cp -r /data/mysql5727 /data/mysql
# chown -R mysql:mysql /usr/local/mysql5728
# chown -R mysql:mysql /data/mysql

## 启动新版本
# service mysql5728 start

## 更新信息
# cd /usr/local/mysql5728/bin
# ./mysqld_safe --user=mysql --socket=/data/mysql/mysql.sock -p --skip-grant-tables  --datadir=/data/mysql/data
# ./mysql_upgrade -uroot -p -S /data/mysql/mysql.sock
## 重启新版本
# service mysql5728 restart
...

## 因为用的原来数据,密码还是原来的密码
# /usr/local/mysql5728/bin/mysql -uroot -p
Enter password: 
...
mysql>

```



#### 大版本升级

初始化mysqld
```
# bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql5725 --datadir=/data/mysql5725
```

> 初始化后会生成默认临时密码，记住密码一会儿登录时需要：A temporary password is generated for root@localhost: ET#&dQs_p22%

启动新版本

```
service mysql5726 start
```

输入之前初始化时候的密码进入，首次使用会有提示修改密码

```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'abc1';
mysql> FLUSH PRIVILEGES;
```

删除原来的服务
```
# cp /etc/init.d/mysql5727 /data/db_bak/
# chkconfig --del mysql5727
```



### 测试MySQL
重启并测试

```
# service mysql5728 restart
...

# /usr/local/mysql5728/bin/mysql -uroot -p     
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