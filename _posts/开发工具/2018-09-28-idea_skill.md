---
layout: post
title: IntelliJ IDEA使用小技巧 
date: 2018-09-28
categories: 开发工具
tags: IntelliJIDEA
---
IntelliJ IDEA使用小技巧

### 解决idea工具下tomcat中文乱码问题

1. 在运行/调试 配置对话框的Startup/Connection面板中，勾选Pass environment variables
并添加一个environment variable，Name填 JAVA_TOOL_OPTIONS, Value填 -Dfile.encoding=UTF-8

![](/images/posts/tools/idea-tomcat.png)

### 自动优化导包（自动删除、导入包）

1. Editor→General→Auto Import

![](/images/posts/tools/idea-auto-import.jpg)

### SpringBoot 在IDEA中实现热部署

1. 

![](/images/posts/tools/idea-auto-matically1.jpg)

![](/images/posts/tools/idea-auto-matically2.jpg)

