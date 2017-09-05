---
layout: post
title: Mac OS10.12采用rvm更新安装Ruby
date: 2017-09-04
categories: MacOS
tags: rvm Ruby MacOS10.12
---
因为很多软件需要Ruby高版本支持，但Mac默认安装的版本为2.0，故需要升级Ruby，升级步骤如下：

注意事项：升级osx 10.11后，brew在使用的时候就会直接报错了，会影响以下操作，因为从10.11开始，对几个重要目录的权限苹果有了新的限制，特别是/usr目录，解决办法：

```
sudo chown -R $(whoami):admin /usr/local
```

## 第一步：安装rvm
rvm是什么？为什么要安装rvm呢，因为rvm可以让你拥有多个版本的Ruby，并且可以在多个版本之间自由切换。

安装命令：

```
$ curl -L get.rvm.io | bash -s stable
$ source ~/.rvm/scripts/rvm
```
检查是否安装成功：

```
rvm -v
```
如果能显示版本好则安装成功了

## 第二步：安装ruby
列出ruby可安装的版本信息

```
rvm list known
```

安装一个ruby版本

```
rvm install 2.3.3
```

设置默认版本

```
rvm use 2.3.3 --default
```

查看已安装的ruby

```
rvm list
```

卸载一个已安装ruby版本

```
rvm remove 2.3.3
```

## 第三步：更换源
查看已有的源

```
gem source -l
*** CURRENT SOURCES ***

https://rubygems.org/
```
然后我们需要来修改更换源（由于国内被墙）所以要把源切换至国内镜像服务器 在终端执行以下命令

以下命令酌情执行，我未执行也成功
```
$ gem update --system
$ gem uninstall ruby gems -update
```

以下命令必须执行，并确保最终输出结果只有 gems.ruby-china.org

```
$ gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
$ gem sources -l
*** CURRENT SOURCES ***

https://gems.ruby-china.org
```
