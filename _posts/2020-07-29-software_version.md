---
layout: post
title: APP、软件版本号的命名规范与原则
date: 2020-07-29
categories: 
tags: 
---
软件版本号的命名规范与原则



### 版本号的命名规范与原则

软件版本号有四部分组成：

<主版本号.><子版本号>.<阶段版本号>.<日期版本号加希腊字母版本号>

* 主版本号：当功能模块有较大的变动，比如增加多个模块或者整体架构发生变化。
* 子版本号：当功能有一定的增加或变化。
* 阶段版本号：一般是 Bug 修复或是一些小的变动，要经常发布修订版，时间间隔不限，修复一个严重的bug即可发布一个修订版。
* 日期版本号：用于记录修改项目的当前日期，每天对项目的修改都需要更改日期版本号。

* 希腊字母版本号：此版本号用于标注当前版本的软件处于哪个开发阶段，当软件进入到另一个阶段时需要修改此版本号。共有5种：base、alpha、beta、RC、Release。 例如：1.1.1.161109_beta

通常，完全的版本号定义，分三项： <主版本号.><子版本号>.<阶段版本号>



### 软件的版本阶段

- Alpha版：也叫α版，此版本主要是以实现软件功能为主，通常只在软件开发者内部交流，一般而言，该版本软件的Bug较多，需要继续修改；
- Beta版：此版本相对于α版已经有了很大的改进，消除了严重的错误，但还是存在着一些缺陷，需要经过多次测试来进一步消除，此版本主要的修改对像是软件的UI；
- RC版 （候选版本(Release Candidate)）：此版本已经相当成熟了，基本上不存在导致错误的BUG，与即将发行的正式版相差无几，测试人员基本通过的版本。
- Release版：此版本意味着“最终版本”、“上线版本”，在前面版本的一系列测试版之后，终归会有一个正式版本，是最终交付用户使用的一个版本。该版本有时也称为标准版。一般情况下，Release不会以单词形式出现在软件封面上，取而代之的是符号(R)；
