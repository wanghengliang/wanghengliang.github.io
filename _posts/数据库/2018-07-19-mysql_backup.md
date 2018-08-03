---
layout: post
title: MySQL备份
date: 2018-07-19
categories: 数据库
tags: 数据库 MySQL
---
MySQL备份

### mysql 导出excel方法
1.执行如下命令，可将执行结果导出到excel中：

```
mysql iptv_pet -uroot -p -e "call SP_PET_STATISTICS(1)" > /data/tj_20160819.xls
```

```
mysql iptv_pet -uroot -p -e "select user_id,code ,create_time from tbl_statistics_order where code like '%result_0' and TO_DAYS(NOW())-TO_DAYS(CREATE_TIME) = 1 order by create_time desc " > /data/order_tj_20160822.xls
```

2.因为office默认的是gb2312编码，服务器端生成的很有可能是utf-8编码，采用如下命令可将其转换为gb2312编码：

```
iconv -futf8 -tgb2312 -otj_20160819_gb2312.xls tj_20160819.xls
```

shell脚本如下：
```
#!/bin/bash

ctime=$(date +%Y%m%d)
mysql iptv_pet -uroot -p****** -e "call SP_PET_STATISTICS(1)" > /data/backup/tj_${ctime}.xls
#mysql iptv_pet -uroot -p****** -e "select user_id,code ,create_time from tbl_statistics_order where code like '%result_0' and TO_DAYS(NOW())-TO_DAYS(CREATE_TIME) = 1 order by create_time desc " > /data/backup/tj_order_${ctime}.xls
iconv -futf8 -tgb2312 -otj_${ctime}_gb2312.xls tj_${ctime}.xls
#iconv -futf8 -tgb2312 -otj_order_${ctime}_gb2312.xls tj_order_${ctime}.xls
```

```
#!/bin/bash

ctime=$(date +%Y%m%d)
mysql iptv_pet -uroot -p****** -e "call SP_PET_STATISTICS(1)" > /data/backup/tj_${ctime}_utf8.xls
#mysql iptv_pet -uroot -p****** -e "select user_id,code ,create_time from tbl_statistics_order where code like '%result_0' and TO_DAYS(NOW())-TO_DAYS(CREATE_TIME) = 1 order by create_time desc " > /data/backup/tj_order_${ctime}_utf8.xls
sleep 1
if [ ! -f "/data/backup/tj_${ctime}_utf8.xls" ]; then
iconv -futf8 -tgb2312 -o/data/backup/tj_${ctime}.xls /data/backup/tj_${ctime}_utf8.xls
fi
```


### mysql 备份
#### 1.导出数据库：
##### 1.1 执行如下命令，可导出数据库所有表的数据：
```
/usr/local/mysql/bin/mysqldump -uroot -p iptv_pet > db_bak_iptv_pet_20160822.sql
```
##### 1.1.1 执行如下命令，可导出数据库中某个表的数据：
```
/usr/local/mysql/bin/mysqldump -uroot -p iptv_pet cms_channel > db_bak_iptv_pet_cmschannel_20160822.sql

/usr/local/mysql/bin/mysqldump -uroot -p iptv_pet cms_channel cms_document > db_bak_iptv_pet_cmschannel_20160822.sql

/usr/local/mysql/bin/mysqldump -uroot -p iptv_pet tbl_stat_order tbl_stat_click tbl_stat_click_manage > db_bak_tbl_stat_20170301.sql
```

##### 1.1.2 执行如下命令，可导出数据库中某个表的部分数据
```
/usr/local/mysql/bin/mysqldump -uroot -p iptv_pet tbl_statistics_player_201705 --where=" TO_DAYS(NOW()) - TO_DAYS(CREATE_TIME) = 1" > db_bak_tbl_statistics_player_20170505.sql
```

##### 1.2 执行如下命令，可导出数据库存储过程：
注意：--events必须在数据库名称后面
```
/usr/local/mysql/bin/mysqldump -uroot -p -n -t -d -R --triggers=false iptv_pet --events > db_bak_iptv_pet_sp_20160822.sql
```

#### 2.编写shell文件，定时备份
##### 2.1 需求如下：
2.1.1 每天4点备份mysql数据

2.1.2 为节省空间，删除超过3个月的所有备份数据；

2.1.3 删除超过7天的备份数据，保留3个月里的 10号 20号 30号的备份数据；

##### 2.2 实现方式如下：
2.2.1 创建shell文件
```
vim backup_mysql.sh
```
2.2.2 编辑shell文件，内容如下：
```
mysqldump -uroot -p123456 --all-databases > /data/dbdata/mysqlbak/`date +%Y%m%d`.sql
find /data/dbdata/mysqlbak/ -mtime +7 -name '*[1-9].sql' -exec rm -rf {} \;
find /data/dbdata/mysqlbak/ -mtime +92 -name '*.sql' -exec rm -rf {} \;
```
2.2.3 创建定时任务
```
crontab –e
0 4 * * * /data/dbdata/backup_mysql.sh
```

### mysql 还原
导入数据
```
mysql> source /home/qinglan/data/mysql/iptv_health.sql
Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected, 1 warning (0.00 sec)

```

### 日常操作语句归纳
mysql 添加表字段
```
alter table tbl_exp_card add activation_user varchar(50) NULL COMMENT '激活用户';
```

