---
layout: post
title: Arcgis安装(linux10.4版本)
date: 2021-03-17
categories: arcgis
tags: arcgis
---
### Arcgis安装(linux10.4版本)

#### 配置网络

配置固定ip

```

```

修改host文件

```
$ vim /etc/hosts

127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.8.236 arcgis.cdkttc.com dev236
```

开启防火墙

```
firewall-cmd --zone=public --add-port=6080/tcp --permanent
firewall-cmd --zone=public --add-port=6443/tcp --permanent
firewall-cmd --zone=public --add-port=600-619/tcp --permanent
firewall-cmd --reload
```

#### 配置arcgis用户

创建arcgis 用户组和用户,设置密码(8位以上，要有大小写区分，例如 ArcgisServer、Arcgis123)

```
$ groupadd arcgis
$ useradd -g arcgis ags
$ passwd ags
```

修改用户权限

```
$ vim /etc/security/limits.conf

ags soft nofile 65535
ags hard nofile 65535
ags soft nproc 25059
ags hard nproc 25059
```

#### 安装arcgis server

切换到ags用户下，进入ags 文件目录操作解压并安装

```
$ su ags
$ cd ags
$ tar -xzf ArcGIS_for_Server_Linux_104_149446.tar
$ cd ArcGISServer
$ ./Setup -m silent -l yes -a /data/ArcGISServer10.4.1.ecp

```

错误处理

```
$ ./Setup
[ArcGIS 10.4 License Manager Setup Error]
The ArcGIS 10.4 License Manager setup requires the 32-bit glibc package. Please install this package and run this setup again.
Exiting.

## 解决办法，安装glibc32位版本
$ yum install glibc.i686
```

```
$ ./startserver.sh
Attempting to start ArcGIS Server... ln: failed to create symbolic link '/home/ags/arcgis/server/framework/runtime/.wine/drive_c/users/ags/Local Settings/Temporary Internet Files': No such file or directory

ERROR: Unable to start Xvfb on any port in the range 600 - 619.

## 解决办法,重新安装xvfb
$ yum -y install xorg-x11-server-Xvfb
```

### 将 Oracle 数据库注册到服务器

#### 安装oracle客户端

下载安装包：http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html，根据实际情况下载，我下载linux版本zip版本，包括instantclient-basic-linux.x64-11.2.0.4.0.zip和instantclient-sqlplus-linux.x64-11.2.0.4.0.zip两个文件。

解压缩安装到/usr/local/oracle

```
$ unzip instantclient-basic-linux.x64-11.2.0.4.0.zip
$ unzip instantclient-sqlplus-linux.x64-11.2.0.4.0.zip

```

配置连接

在解压后的instantclient_11_2文件夹下创建配置文件

```
$ mkdir -p network/admin
$ cd network/admin
$ vi tnsnames.ora
history_162 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.1.197.1)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SID =xxx)
    )
  )
$ source .bash_profile
```

配置环境变量

```
$ vi ~/.bash_profile
export ORACLE_HOME=/usr/local/oracle/instantclient_11_2
export TNS_ADMIN=$ORACLE_HOME/network/admin
##export NLS_LANG=AMERICAN_AMERICA.ZHS16GBK
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export LD_LIBRARY_PATH=$ORACLE_HOME
export PATH=$ORACLE_HOME:$PATH

$ source ~/.bash_profile
```

连接数据库

```
$ sqlplus sw/sw123@history_162
```

错误处理

```
sqlplus: error while loading shared libraries: libnsl.so.1: cannot open shared object file: No such file or directory

解决办法：
安装libnsl
$ yum install libnsl.x86_64
$ sqlplus sw/sw123@history_162

```

#### 更改 init_user_param.sh 脚本

```
$ cd /home/ags/arcgis/server/usr/
$ vi init_user_param.sh
##如果采用Oracle并且安装本机安装的Oracle，则移除Oracle部分以 export 开头的行中的注释标记 (#)。
#
# For connection with Oracle Runtime or Administrator Client
#
#export ORACLE_BASE=<Oracle_Installdir>/app
#export ORACLE_HOME=$ORACLE_BASE/<Oracle_Release>/product/<Oracle_Version>/<client_Version>
#export ORACLE_SID=<set when applicable>
#export TNS_ADMIN=<set when applicable. e.g.$ORACLE_HOME/network/admin>
#export PATH=$ORACLE_HOME/bin:$PATH
#export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH

##如果使用Oracle数据库即时客户端库，您只需取消注释并设置 $LD_LIBRARY_PATH
#
# For connection with Oracle Instant Client
#
export LD_LIBRARY_PATH=/usr/local/oracle/instantclient_11_2/:$LD_LIBRARY_PATH

```

重启arcgis server

```
$ cd /home/ags/arcgis/server/
$ ./startserver.sh
```

#### 测试arcgis server

浏览器打开 http://localhost:6080/arcgis/manager



#### 关闭https服务

浏览器打开 http://localhost:6080/arcgis/admin/

账号，密码采用manager账号密码进行登录

选择，Home**>** security **>** config **>** update，进入修改页面

修改**Protocol:**为HTTP Only，然后保存，搞定。





