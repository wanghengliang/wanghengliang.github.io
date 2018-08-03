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
