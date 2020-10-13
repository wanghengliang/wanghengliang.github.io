---
layout: post
title: Tomcat安装
date: 2016-12-15
categories: 
tags: linux Tomcat 服务器架设
---

### 下载Tomcat
下载地址:http://tomcat.apache.org/

### 安装Tomcat

```
# mkdir /usr/local/tomcat
# cd /usr/local/tomcat
# tar -zxvf /opt/apache-tomcat-7.0.54.tar.gz
```

生成链接以便版本升级

```
# ln -s apache-tomcat-7.0.54 server
```

升级时候先删除原来的后重新生成新的

```
# rm -rf ./server
# ln -s apache-tomcat-7.0.92 server
```

### 配置Tomcat

##### 修改日志文件路径

修改catalina.out路径日志
tomcat/bin目录下修改catalina.sh改变catalina.out的目录

```/data/wwwlogs/tomcat-web
# vi /usr/local/tomcat/server/bin/catalina.sh
//命令模式下输入/CATALINA_OUT 查找,按n查找下一个

CATALINA_OUT="$CATALINA_BASE"/logs/catalina.out; //此行内的"$CATALINA_BASE",更改为想要更换的目录如：CATALINA_OUT=/data/wwwlogs/catalina.out

```
或者
```
sed -i 's/CATALINA_OUT="$CATALINA_BASE"\/logs\/catalina.out/CATALINA_OUT=\/data\/wwwlogs\/tomcat-web\/catalina.out/g' /usr/local/tomcat/server/bin/catalina.sh
```

修改localhost、catalina、manager、host-manager日志路径
打开Tomcat目录conf/logging.properties，修改

```
# vi /usr/local/tomcat/server/conf/logging.properties
//分别修改其路径，将${catalina.base}更改为想要更换的目录
1catalina.org.apache.juli.AsyncFileHandler.directory = ${catalina.base}/logs
2localhost.org.apache.juli.AsyncFileHandler.directory = ${catalina.base}/logs
3manager.org.apache.juli.AsyncFileHandler.directory = ${catalina.base}/logs
4host-manager.org.apache.juli.AsyncFileHandler.directory = ${catalina.base}/logs
```
或者
```
sed -i 's/${catalina.base}\/logs/\/data\/wwwlogs\/tomcat-web/g' /usr/local/tomcat/server/bin/catalina.sh

```

修改localhost_access_log日志路径
打开Tomcat目录conf/server.xml,修改

```
# vi /usr/local/tomcat/server/conf/server.xml
//修改directory为想要更换的目录
<Valve className="org.apache.catalina.valves.AccessLogValve" directory="/usr/local/tomcats/logs" ...>
```
或者
```

```

##### 删除自带的项目

```
# cd /usr/local/tomcat/server/webapps
# rm -rf *
```


##### 配置虚拟主机
###### 方法1，直接配置conf/server.xml配置虚拟主机

```
<Engine name="Catalina" defaultHost="wwww.aaa.com">
    <Host name="www.aaa.com" appBase="webapps_1" autoDeploy="true" unpackWARs="true" xmlNamespaceAware="false" xmlValidation="false">
        <Alias>aaa.com</Alias>
        <Context path="/" docBase="./war/aaa.war" reloadable="true" />
    </Host>
    <Host name="www.bbb.com" appBase="webapps_2" autoDeploy="true" unpackWARs="true" xmlNamespaceAware="false" xmlValidation="false">
        <Context path="/" docBase="./war/bbb.war" reloadable="true" />
    </Host>
    <Host name="www.ccc.com" appBase="webapps_3" autoDeploy="true" unpackWARs="true" xmlNamespaceAware="false" xmlValidation="false">
        <Context path="/" docBase="./war/ccc.war" reloadable="true" />
    </Host>
</Engine>
```

###### 方法2，conf/server.xml引入子文件配置虚拟主机
在<server>元素前添加如下格式：

```
<!DOCTYPE server-xml [
  <!ENTITY localhost-vhost SYSTEM "file:///usr/local/tomcat/conf/vhost/localhost.xml">
]>
```

并在<Engine>...</Engine>引用它（localhost-vhost，注：不能以数字开头）即可。

完整代码如下：

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE server-xml [
<!ENTITY vhost-wwww.aaa.com SYSTEM "file:///usr/local/tomcat/conf/vhost/wwww.aaa.com.xml">
<!ENTITY vhost-wwww.bbb.com SYSTEM "file:///usr/local/tomcat/conf/vhost/wwww.bbb.com.xml">
]>

<Server port="8005" shutdown="SHUTDOWN">
  ...
  <Service name="Catalina">
    <Connector port="8080" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8443" />
    <Engine name="Catalina" defaultHost="localhost">
      ...
      &vhost-wwww.aaa.com;
      &vhost-wwww.bbb.com;
    </Engine>
  </Service>
</Server>
```

每个单独虚拟主机文件内容如下:
/usr/local/tomcat/conf/vhost/www.aaa.com.xml

```
<Host name="wwww.aaa.com" appBase="webapps" unpackWARs="true" autoDeploy="true">
    <Alias>www.aaa.cn</Alias>
    <Context path="" docBase="/data/wwwroot/aaa" debug="0" reloadable="false" crossContext="true"/>
    <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs" prefix="wwww.aaa.com_access_log." suffix=".txt" pattern="%h %l %u %t &quot;%r&quot; %s %b" />
</Host>
```

/usr/local/tomcat/conf/vhost/www.bbb.com.xml

```
<Host name="wwww.bbb.com" appBase="webapps" unpackWARs="true" autoDeploy="true">
    <Context path="" docBase="/data/wwwroot/bbb" debug="0" reloadable="false" crossContext="true"/>
    <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs" prefix="wwww.bbb.com_access_log." suffix=".txt" pattern="%h %l %u %t &quot;%r&quot; %s %b" />
</Host>
```

##### 一台机器安装多个Tomcat

```
修改 <Server port="8005" shutdown="SHUTDOWN"> 
为 <Server port="8006" shutdown="SHUTDOWN">

修改 <Connector port="8080" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8443" />
为 <Connector port="8086" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8446" />

修改 <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
为 <Connector port="8007" protocol="AJP/1.3" redirectPort="8446" />

修改 <Server port="8005" shutdown="SHUTDOWN"> 
为 <Server port="8008" shutdown="SHUTDOWN">

修改 <Connector port="8080" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8446" />
为 <Connector port="8088" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8448" />

修改 <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
为 <Connector port="8009" protocol="AJP/1.3" redirectPort="8448" />
```

