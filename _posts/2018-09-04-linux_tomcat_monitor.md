---
layout: post
title: Linux监测Tomcat运行情况
date: 2018-09-04
categories: 
tags: linux Tomcat
---
Linux监测Tomcat运行情况

直接上shell代码，新建shell文件tomcatMonitor.sh，将以下内容加入其中，设置定时任务执行此shell即可

```
#!/bin/bash

# func:自动监控tomcat并且在异常时执行重启操作


# 获取tomcat进程ID
TomcatID=$(ps -ef |grep tomcat |grep -w 'tomcat/server'|grep -v 'grep'|awk '{print $2}')

# tomcat启动程序
StartTomcat=/usr/local/tomcat/server/bin/startup.sh

# 定义要监控的页面地址 
WebUrl=http://localhost:8082/index.jsp


# 日志输出
GetPageInfo=/data/wwwlogs/GetPageInfo.log
TomcatMonitorLog=/data/wwwlogs/TomcatMonitor.log

Monitor(){
	echo "[info]开始监控tomcat...[$(date +'%F %H:%M:%S')]"
	if [ $TomcatID ] ;then # 这里判断TOMCAT进程是否存在
		echo "[info]当前tomcat进程ID为:$TomcatID,继续检测页面..."
		# 检测是否启动成功(成功的话页面会返回状态"200")
		TomcatServiceCode=$(curl -s -o $GetPageInfo -m 10 --connect-timeout 10 $WebUrl -w %{http_code})
		if [ $TomcatServiceCode -eq 200 ] ;then
			echo "[info]页面返回码为$TomcatServiceCode,tomcat启动成功,测试页面正常......"
		else
			echo "[error]tomcat页面出错,请注意......状态码为$TomcatServiceCode,错误日志已输出到$GetPageInfo"
			echo "[error]页面访问出错,开始重启tomcat"
			kill -9 $TomcatID  # 杀掉原tomcat进程
			sleep 3
			$StartTomcat
		fi
	else
		echo "[error]tomcat进程不存在!tomcat开始自动重启..."
		echo "[info]$StartTomcat,请稍候......"
		$StartTomcat
	fi
	echo "------------------------------"
}
Monitor>>$TomcatMonitorLog

```
