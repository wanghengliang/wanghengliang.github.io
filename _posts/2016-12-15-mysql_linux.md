---
layout: post
title: MySQL安装
date: 2016-12-15
categories: 
tags: linux MySQL 服务器架设
---

### mysql 下载
#### 下载地址:
[MySQL](http://www.mysql.com/downloads/)

#### 版本（mysql包括三个版本）

MySQL Enterprise Edition (commercial) MySQL企业版（商业）

MySQL Cluster CGE (commercial) MySQL集群CGE（商业）

MySQL Community Edition (GPL) MySQL社区版（GPL）

-->MySQL Community Server (GPL) MySQL社区服务器（GPL）

-->MySQL Cluster (GPL) MySQL集群（GPL）

-->MySQL Fabric (GPL) MySQL的织物（GPL）

选择MySQL Community Server (GPL) MySQL社区服务器（GPL）
有几种选择

1. RPM Bundle（是该版本所有包的集合）
2. RPM PACKAGE（是某个特定的包，比如server,client,shared lib等）
3. Compressed TAR Archive，是编译好的版本，解压可直接使用。
4. 源码安装，选择操作系统下拉框中选择Source Code，然后选择Generic Linux，带boost库的mysql下载。

这里下载RPM Bundle，然后解压并安装

```
tar -xvf mysql-5.7.18-1.el7.x86_64.rpm-bundle.tar
```
### mysql 安装
#### 安装前需要先卸载mariadb-lib

```
# rpm -qa|grep mariadb
mariadb-libs-5.5.44-2.el7.centos.x86_64
# rpm -e mariadb-libs-5.5.44-2.el7.centos.x86_64 --nodeps
```
#### 解压出rpm-bundle.tar,实际上只需要安装以下几个包
```
# rpm -ivh mysql-community-common-5.7.16-1.el7.x86_64.rpm
# rpm -ivh mysql-community-libs-5.7.16-1.el7.x86_64.rpm
# rpm -ivh mysql-community-client-5.7.16-1.el7.x86_64.rpm
# rpm -ivh mysql-community-server-5.7.16-1.el7.x86_64.rpm
```
上面几个包有依赖关系，执行有先后。

使用rpm安装方式安装mysql，安装的路径如下：

* a 数据库目录 /var/lib/mysql/
* b 配置文件 /usr/share/mysql(mysql.server命令及配置文件)
* c 相关命令 /usr/bin(mysqladmin mysqldump等命令)
* d 启动脚本 /etc/rc.d/init.d/(启动脚本文件mysql的目录)

#### mysql 配置

```
# vi /etc/my.cnf
[client]
port=3306
socket=/var/lib/mysql/mysql.sock
default-character-set=utf8

[mysqld]
port=3306
socket=/var/lib/mysql/mysql.sock

basedir = /usr/local/mysql
datadir = /data/mysql
pid-file = /data/mysql/mysql.pid
log_error = /data/mysql/mysql-error.log
slow_query_log = 1
long_query_time = 2
slow_query_log_file = /data/mysql/mysql-slow.log

character-set-server=utf8
lower_case_table_names=1
#MySQL服务器默认的“wait_timeout”是28800秒即8小时，意味着如果一个连接的空闲时间超过8个小时，MySQL将自动断开该连接,需要同时修改wait_timeout和interactive_timeout这两个参数
wait_timeout=288000
interactive_timeout=288000
#开启计划
event_scheduler=1
```

#### 数据库初始化
为了保证数据库目录为与文件的所有者为 mysql 登陆用户，如果你是以 root 身份运行 mysql 服务，需要执行下面的命令初始化

```
# mysqld --initialize --user=mysql
```
如果是以 mysql 身份运行，则可以去掉 --user 选项。

如果 datadir 指向的目标目录下已经有数据文件，则会有类似提示：

```
# mysqld --initialize --user=mysql
2017-05-03T02:18:00.758981Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
2017-05-03T02:18:00.761364Z 0 [ERROR] --initialize specified but the data directory has files in it. Aborting.
2017-05-03T02:18:00.761398Z 0 [ERROR] Aborting
```
因此，需要先确保 datadir 目标目录下是空的，避免误操作破坏已有数据。

另外 --initialize 选项默认以“安全”模式来初始化，则会为 root 用户生成一个密码并将该密码标记为过期，登陆后你需要设置一个新的密码，

而使用 --initialize-insecure 命令则不使用安全模式，则不会为 root 用户生成一个密码。

这里演示使用的 --initialize 初始化的，会生成一个 root 账户密码，密码在log文件里,root@localhost:后面都是

```
# cat /var/log/mysqld.log | grep password
2017-05-03T02:26:10.001375Z 1 [Note] A temporary password is generated for root@localhost: (tfywy9JHk7J
```
或者

```
# cat /data/mysql/mysql-error.log | grep password
2018-07-19T10:45:38.681364Z 1 [Note] A temporary password is generated for root@localhost: Kz(tF>cK4Zr>
```

### 数据库测试
启动服务器并登录测试

```
# service mysqld start
Redirecting to /bin/systemctl start mysqld.service
# mysql -uroot -p
Enter password: 
...
mysql>
```
首次使用会有类似提示

```
mysql> show databases;
ERROR 1820 (HY000): You must reset your password using ALTER USER statement before executing this statement.
mysql> use mysql;
ERROR 1820 (HY000): You must reset your password using ALTER USER statement before executing this statement.

或
ERROR 1820 (HY000): You must SET PASSWORD before executing this statement 
```
因为新用户登入后需要立刻修改密码，否则无法继续后续的工作：

```
mysql> set password = password('mysql5.7.21(js');
Query OK, 0 rows affected, 1 warning (0.00 sec)
```
或者

```
alter user user() identified by "mysql5.7.21(js";
Query OK, 0 rows affected (0.00 sec)
```
重启并测试

```
# service mysqld stop
Redirecting to /bin/systemctl stop  mysqld.service
# service mysqld start
Redirecting to /bin/systemctl start  mysqld.service
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


### mysql 创建数据库和用户

```
mysql> CREATE DATABASE IF NOT EXISTS `db_test` DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
Query OK, 1 row affected (0.00 sec)

mysql> CREATE USER 'testusr'@'%' IDENTIFIED BY 'testusr-a123';
Query OK, 0 rows affected (0.00 sec)

mysql> GRANT all ON db_test.* TO 'testusr'@'%';
Query OK, 0 rows affected (0.00 sec)

mysql> exit
Bye

# mysql -utestusr -p
Enter password: 
...
mysql> use db_test;
Database changed
mysql>
```