---
layout: post
title: MySQL安全相关配置
date: 2020-12-04
categories: database
tags: MySQL
---
MySQL安全相关配置



### MySQL设置密码复杂度

MySQL5.6.6版本之后增加了密码强度验证插件validate_password，相关参数设置的较为严格。使用了该插件会检查设置的密码是否符合当前设置的强度规则，若不满足则拒绝设置。

MySQL默认没有安装这个插件，我们可以通过如下方式查看

```mysql
SELECT * from mysql.`plugin`
# 或者
show plugin;
```

#### 安装插件

查看插件文件存放位置

```
SHOW GLOBAL VARIABLES LIKE 'plugin_dir';
```

一般情况是在mysql安装路径下的`lib/plugin`目录，完整安装版默认是带有插件文件`validate_password.dll`的,如没有需要先将插件文件放入改目录下后再进行安装操作。

安装插件

```mysql
-- 添加
INSTALL PLUGIN validate_password SONAME 'validate_password.dll';

-- 卸载
UNINSTALL PLUGIN validate_password；
```

#### 查看默认策略

```mysql
show variables like 'validate_password%';
```

#### 修改策略

```mysql
-- 将策略要求置为LOW，长度要求置为1
set global validate_password_policy=0;
set global validate_password_length=1;
```

#### 各参数说明

* validate_password_policy：密码安全策略，默认MEDIUM策略

| 策略        | 检查规则                                       |
| ----------- | ---------------------------------------------- |
| 0 or LOW    | 长度                                           |
| 1 or MEDIUM | 长度；数字，字母大小写，特殊符号；             |
| 2 or STRONG | 长度；数字，字母大小写，特殊符号；密码策略文件 |

* validate_password_dictionary_file：密码策略文件，策略为STRONG才需要

* validate_password_length：密码最少长度 

* validate_password_mixed_case_count：大小写字符长度，至少1个

* validate_password_number_count ：数字至少1个 

* validate_password_special_char_count：特殊字符至少1个

  

### MySQL添加审计功能

mysql的审计功能，主要可以记录下对数据库的所有操作，包括登录、连接、对表的增删改查等，便于责任追溯，问题查找，当然一定方面也会影响数据库效率。

#### 获取审计插件

获取插件并将其拷贝到到自己的mysql插件库下（位置参考上面validate_password说明），审计的插件的主要有以下三个：

**McAfee MySQL Audit Plugin**：[源码](https://github.com/mcafee/mysql-audit/releases)，[编译好的二进制文件](https://bintray.com/mcafee/mysql-audit-plugin/release/) 只有linux版本，不知怎么编译出windows版本。
**Percona Audit Log Plugin**：[地址](https://www.percona.com/doc/percona-server/5.5/management/audit_log_plugin.html)：不了解
**MariaDB Audit Plugin**：[下载地址](https://downloads.mariadb.org/mariadb/+releases/)：MariaDB版本自带审计功能插件，所有可以通过MariaDB官网下载对应版本（版本对应很重要，不然安装会失败，成功了也可能导致数据库崩溃）的安装包，从安装包中获得版本对应的.dll插件（linux系统.so插件），拷贝到到自己的mysql插件库下，安装插件，开启审计功能，配置my.ini文件。

#### 安装审计插件

```mysql
-- 	安装
INSTALL PLUGIN server_audit SONAME 'server_audit.dll';
-- 卸载
UNINSTALL PLUGIN server_audit;
```

#### 查看参数配置

```MYSQL
show variables like '%audit%';
```

#### 修改参数

```MYSQL
-- 备注：指定哪些操作被记录到日志文件中
set global server_audit_events='CONNECT,QUERY,TABLE,QUERY_DDL'

-- 备注：开启审计功能
set global server_audit_logging=on

-- 备注：默认存放路径，可以不写，默认到data文件下
set global server_audit_file_path =/data/mysql/auditlogs/

-- 备注：设置文件大小
set global server_audit_file_rotate_size=200000000

-- 指定日志文件的数量，如果为0日志将从不轮转
set global server_audit_file_rotations=200

-- 强制日志文件轮转
set global server_audit_file_rotate_now=ON
```

#### 各个参数说明

* server_audit_output_type：指定日志输出类型，可为SYSLOG或FILE
* server_audit_logging：启动或关闭审计
* server_audit_events：指定记录事件的类型，可以用逗号分隔的多个值(connect,query,table)，如果开启了查询缓存(query cache)，查询直接从查询缓存返回数据，将没有table记录
* server_audit_file_path：如server_audit_output_type为FILE，使用该变量设置存储日志的文件，可以指定目录，默认存放在数据目录的server_audit.log文件中
* server_audit_file_rotate_size：限制日志文件的大小
* server_audit_file_rotations：指定日志文件的数量，如果为0日志将从不轮
* server_audit_file_rotate_now：强制日志文件轮转
* server_audit_incl_users：指定哪些用户的活动将记录，connect将不受此变量影响，该变量比server_audit_excl_users优先级高
* server_audit_syslog_facility：默认为LOG_USER，指定facility
* server_audit_syslog_ident：设置ident，作为每个syslog记录的一部分
* server_audit_syslog_info：指定的info字符串将添加到syslog记录
* server_audit_syslog_priority：定义记录日志的syslogd priority
* server_audit_excl_users：该列表的用户行为将不记录，connect将不受该设置影响
* server_audit_mode：标识版本，用于开发测试







  

  