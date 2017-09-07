---
layout: post
title: Tomcat安装
date: 2016-12-15
categories: 服务器架设
tags: Tomcat
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

### 配置Tomcat

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
<!ENTITY vhost-localhost SYSTEM "file:///usr/local/tomcat/conf/vhost/localhost.xml">
<!ENTITY vhost-www.wanghengliang.cn SYSTEM "file:///usr/local/tomcat/conf/vhost/www.wanghengliang.cn.xml">
]>

<Server port="8005" shutdown="SHUTDOWN">
  ...
  <Service name="Catalina">
    <Connector port="8080" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8443" />
    <Engine name="Catalina" defaultHost="localhost">
      ...
      &vhost-localhost;
      &vhost-www.wanghengliang.cn;
    </Engine>
  </Service>
</Server>
```

每个单独虚拟主机文件内容如下:
/usr/local/tomcat/conf/vhost/www.wanghengliang.cn.xml

```
<Host name="www.wanghengliang.cn" appBase="webapps" unpackWARs="true" autoDeploy="true">
    <Alias>wanghengliang.cn</Alias>
    <Context path="" docBase="/data/wwwroot/wechat" debug="0" reloadable="false" crossContext="true"/>
    <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs" prefix="www.wanghengliang.cn_access_log." suffix=".txt" pattern="%h %l %u %t &quot;%r&quot; %s %b" />
</Host>
```
