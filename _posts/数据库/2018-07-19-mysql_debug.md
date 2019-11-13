---
layout: post
title: MySQL调试技巧
date: 2018-07-19
categories: 数据库
tags: 数据库 MySQL
---
MySQL调试技巧

### MySQL查询最近执行SQL

1. 进入MySQL,略

2. 启用Log功能

```
# 查询是否启用Log功能
mysql> SHOW VARIABLES LIKE "general_log%";
+--------------------+--------------------------------------------------+
| Variable_name      |    Value                                         |
+--------------------+--------------------------------------------------+
| general_log        | OFF                                              |
| general_log_file   | /usr/local/mysql/data/MacBook-Pro.log            |
+--------------------+--------------------------------------------------+
# 启用Log功能
mysql> SET GLOBAL general_log = 'ON';

```

3. 设置Log文件地址(所有Sql语句都会在general_log_file里)，采用默认则不设置

```
mysql> SET GLOBAL general_log_file = 'c:\mysql.log';
```

4. 执行mysql命令然后查看设置的Log文件，也可用其他可视化工具进行查看。



### Mysql 查看连接数,状态 最大并发数

Threads_connected 跟show processlist结果相同，表示当前连接数。准确的来说，Threads_running是代表当前并发数

```
show variables like '%max_connections%'; 查看最大连接数
set global max_connections=1000 重新设置

mysql> show status like 'Threads%';
+-------------------+-------+
| Variable_name     | Value |
+-------------------+-------+
| Threads_cached    | 58    |
| Threads_connected | 57    |   ###这个数值指的是打开的连接数
| Threads_created   | 3676  |
| Threads_running   | 4     |   ###这个数值指的是激活的连接数，这个数值一般远低于connected数值
+-------------------+-------+
```


### Mysql 查询视图定义语句

```
SELECT table_name,table_schema,view_definition,check_option,is_updatable 
FROM information_schema.views
WHERE table_name = 'view_name';
```

### 查询数据库中的存储过程和函数

```
show procedure status;
show function status;
```

### 查看存储过程或函数的创建代码

```
show create procedure proc_name;
show create function func_name;
```
