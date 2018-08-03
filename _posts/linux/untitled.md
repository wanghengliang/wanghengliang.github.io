mkdir /usr/local/mysql3308
mkdir /home/mctd/data/mysql3308
chown -R mysql:mysql /usr/local/mysql3308
chown -vR mysql:mysql /home/mctd/data/mysql3308
chown -R root:root /home/mctd/data/mysql


cp -av /var/lib/mysql/* /home/mctd/data/mysql

mysqld --initialize --user=mysql --datadir=/home/mctd/data/mysql



cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql3308 \
-DMYSQL_DATADIR=/home/mctd/data/mysql3308 \
-DMYSQL_UNIX_ADDR=/home/mctd/data/mysql3308/mysql.sock \
-DSYSCONFDIR=/etc/mysql3308 \
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



G!pdfa.(U8-j

mysql5.7.21(js

mysqld --initialize --user=mysql --datadir=/home/mctd/data/mysql

socket=/var/lib/mysql/mysql.sock
default-character-set=utf8

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock


