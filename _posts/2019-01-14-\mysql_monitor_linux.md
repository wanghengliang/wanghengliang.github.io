---
layout: post
title: Linux监测MySQL运行情况
date: 2019-01-14
categories: 
tags: linux MySQL
---
Linux监测MySQL运行情况


有两种方式实现，直接上shell代码，新建shell文件mysqlMonitor.sh，将以下内容加入其中，设置定时任务执行此shell即可（具体代码暂未来得及测试，思路和原理已测试可行）

### 第一种方式

```
MYSQL_PING=`/usr/local/mysql/bin/mysqladmin -u root -p123123 ping`
MYSQL_OK="mysqld is alive"

if [[ "$MYSQL_PING" != "$MYSQL_OK" ]]
    then
        echo "mysql not ok"
        service mysqld restart
    else
        echo "mysql is ok"
fi
```

### 第二种方式

```
PORT="0"
PORT=`netstat -lnt | grep 3306 | wc -l `
echo $PORT
if [ $PORT -eq 1 ]
 then
echo "mysql is running"
else
echo "mysql is not running"
echo "progrome reeady to start mysql"

sudo service mysql start
./check_mysql.sh
fi
```
