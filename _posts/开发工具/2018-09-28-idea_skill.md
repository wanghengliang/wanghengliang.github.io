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