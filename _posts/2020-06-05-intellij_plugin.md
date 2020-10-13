---
layout: post
title: IntelliJ插件开发
date: 2020-06-05
categories: 
tags: IntelliJIDEA plugin
---
IntelliJ插件开发



### 插件开发准备

#### gradle安装



#### sdk下载

下载地址（不同版本直接在后面的版本号），建议使用迅雷先下载：

[ideaIC-2019.3.3.zip](https://cache-redirector.jetbrains.com/www.jetbrains.com/intellij-repository/releases/com/jetbrains/intellij/idea/ideaIC/2019.3.3/ideaIC-2019.3.3.zip)

[ideaIC-2020.1.1.zip](https://cache-redirector.jetbrains.com/www.jetbrains.com/intellij-repository/releases/com/jetbrains/intellij/idea/ideaIC/2020.1.1/ideaIC-2020.1.1.zip)

下载后安装到本地maven仓库

```shell
## 注意修改路径到你的真实路径
$ mvn install:install-file -Dfile="/plugins/sdk/ideaIC-2019.3.3.zip" -DgroupId=com.jetbrains.intellij.idea -DartifactId=ideaIC -Dpackaging=zip -Dversion=2019.3.3 -DgeneratePom=true

$ mvn install:install-file -Dfile="/plugins/sdk/ideaIC-2020.1.1.zip" -DgroupId=com.jetbrains.intellij.idea -DartifactId=ideaIC -Dpackaging=zip -Dversion=2020.1.1 -DgeneratePom=true
```



