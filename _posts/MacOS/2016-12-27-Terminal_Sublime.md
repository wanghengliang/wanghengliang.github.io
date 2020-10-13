---
layout: post
title: Mac终端用Sublime打开指定文件或文件夹
date: 2016-12-27
categories: MacOS
tags: Sublime
---
经常使用Mac终端或iTerm,但是编辑工具习惯了使用Sublime，所以希望从终端用sublime打开指定文件或文件夹，方法如下：

### 1.建立Sublime的别名软连接
```
mkdir ~/bin
sudo ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl
```
### 2.将~/bin添加到环境变量中
```
vi ~/.bash_profile
   export PATH="~/bin:$PATH"

source ~/.bash_profile
```
### 3.使用mac终端用Sublime打开指定文件或文件夹
```
subl xx
```