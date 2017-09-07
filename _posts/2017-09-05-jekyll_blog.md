---
layout: post
title: Jekyll搭建个人博客过程记录
date: 2017-09-05 
categories: 技术开发
tags: jekyll
---

一直想搭建一个自己的博客系统，网上搜了一下发现了[Hexo](https://hexo.io/)! 但是没有找到一个自己满意的模板，后来发现<a href="http://baixin.io/" target="_blank">潘柏信</a>的博客,非常喜欢这个模板，作者也愿意共享此模板并提供源码，但发现采用的不是Hexo而是Jekyll，了解了一下这两个Blog系统，发现Jekyll还有个优点就是所有的Markdown文档也是放到一起的，而用Hexo则需要将Markdown单独存放，如果想多端同步更新blog则需要建立两个Github项目进行存放，关于Hexo和Jekyll的优缺点自行对比，以上为个人关注的优缺点。最终决定采用Jekyll搭建个人blog，然后主要按照<a href="http://baixin.io/2016/10/jekyll_tutorials1/" target="_blank">Jekyll搭建个人博客</a>进行搭建，在此记录一下搭建过程遇到的问题和有一些细节.

## 安装Jekyll

### 更新Ruby
Jekyll 是基于 Ruby 开发的，而且要求Ruby不低于2.1版本，但是MacOS的默认的Ruby版本为2.0，故需要升级Ruby。升级过程发现不成功，原因为我的系统升级为了OSX 10.12，Mac系统升级osx 10.11后，brew在使用的时候就会直接报错了，会影响Ruby升级操作，因为从10.11开始，对几个重要目录的权限苹果有了新的限制，特别是/usr目录，经过各种搜索，最终采用rvm进行安装升级Ruby，详细步骤请查看<a href="http://wanghengliang.cn/2017/09/rvm_install_ruby/" target="_blank">Mac OS10.12采用rvm更新安装ruby</a>。

### 安装Jekyll

``` bash
$ gem install jekyll
```

### 创建博客
此处有两种方式：1直接创建，2通过已有模板创建

#### 直接创建

```
$ jekyll new myBlog
```

#### 通过已有模板创建
1.为了将最终blog放到Github Pages，先进行创建Github Pages项目。

建立与你用户名对应的仓库，仓库名必须为【your_user_name.github.io】固定写法,如我的 github 账户名叫 wanghengliang，我的 Github Pages 仓库名就叫 wanghengliang.github.io;然后clone到本地,可以通过HTTPS，如果为Github添加了SSH keys可以采用SSH方式，如clone我的项目命令如下：

```
git clone git@github.com:wanghengliang/wanghengliang.github.io.git
```

2.下载模板，可采用潘柏信提供的<a href="https://github.com/leopardpan/leopardpan.github.io" target="_blank">leopardpan</a>模板，，或者我修改后的<a href="https://github.com/wanghengliang/wanghengliang.github.io" target="_blank">模板</a>(只增加了分类信息)，下载zip版本，并将内容解压到Github Pages本地目录。

3.修改Blog配置

>* 删除模板原有文章并创建自己的文章，
>* 修改配置文件_config.yml里面的内容为你自己的。

### 编写文章
所有的文章都在_posts目录下面，文章格式为 mardown 格式，文章文件名可以是 .mardown 或者 .md；

文章名的格式:前面必须为日期开头如：2016-10-16-welcome_jekyll.md

文章head格式

```
---
layout: post
title:  "Welcome to Jekyll!"
date:   2016-10-16 11:29:08 +0800
categories: jekyll update
tag: jekyll
---
正文...

```

### 启动博客系统

``` bash
$ jekyll server
```

#### 如果你本机没配置过任何jekyll的环境，可能会报错

```
/Users/xxxxxxxx/.rvm/rubies/ruby-2.2.2/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require': cannot load such file -- bundler (LoadError)
	from /Users/xxxxxxxx/.rvm/rubies/ruby-2.2.2/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/xxxxxxxx/.rvm/gems/ruby-2.2.2/gems/jekyll-3.3.0/lib/jekyll/plugin_manager.rb:34:in `require_from_bundler'
	from /Users/xxxxxxxx/.rvm/gems/ruby-2.2.2/gems/jekyll-3.3.0/exe/jekyll:9:in `<top (required)>'
	from /Users/xxxxxxxx/.rvm/gems/ruby-2.2.2/bin/jekyll:23:in `load'
	from /Users/xxxxxxxx/.rvm/gems/ruby-2.2.2/bin/jekyll:23:in `<main>'
	from /Users/xxxxxxxx/.rvm/gems/ruby-2.2.2/bin/ruby_executable_hooks:15:in `eval'
	from /Users/xxxxxxxx/.rvm/gems/ruby-2.2.2/bin/ruby_executable_hooks:15:in `<main>'
```

原因： 没有安装 bundler ，执行安装 bundler 命令

```
$ gem install bundler
```

提示： 

```
Fetching: bundler-1.13.5.gem (100%)
Successfully installed bundler-1.13.5
Parsing documentation for bundler-1.13.5
Installing ri documentation for bundler-1.13.5
Done installing documentation for bundler after 5 seconds
1 gem installed

```

再次执行 $ jekyll server  ，提示

```

Could not find proper version of jekyll (3.1.1) in any of the sources
Run `bundle install` to install missing gems.

```

跟着提示运行命令

```
$ bundle install
```

这个时候你可能会发现 bundle install 运行卡主不动了。

如果很长时间都没任何提示的话，你可以尝试修改 gem 的 source

```
$ gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
$ gem sources -l
*** CURRENT SOURCES ***

https://gems.ruby-china.org

```

再次执行命令 $ bundle install，发现开始有动静了

```
Fetching gem metadata from https://rubygems.org/...........
Fetching version metadata from https://rubygems.org/..
Fetching dependency metadata from https://rubygems.org/.
。。。
Installing jekyll-watch 1.3.1
Installing jekyll 3.1.1
Bundle complete! 3 Gemfile dependencies, 17 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.

```

bundler安装完成，后再次启动本地服务 

```
$ jekyll server

```

继续报错

```
Configuration file: /Users/tendcloud-Caroline/Desktop/leopardpan.github.io/_config.yml
  Dependency Error: Yikes! It looks like you don't have jekyll-sitemap or one of its dependencies installed. In order to use Jekyll as currently configured, you'll need to install this gem. The full error message from Ruby is: 'cannot load such file -- jekyll-sitemap' If you run into trouble, you can find helpful resources at http://jekyllrb.com/help/! 
jekyll 3.1.1 | Error:  jekyll-sitemap

```
表示 当前的 jekyll 版本是 3.1.1 ，无法使用 jekyll-sitemap 

解决方法有两个

> 1、打开当前目录下的 _config.yml 文件，把 gems: [jekyll-paginate,jekyll-sitemap] 换成 gems: [jekyll-paginate] ，也就是去掉jekyll-sitemap。

> 2、升级 jekyll 版本。

修改完成后保存配置，再次执行

```
$ jekyll server

```
提示

```
Configuration file: /Users/baixinpan/Desktop/OpenSource/Mine/Page-Blog/leopardpan.github.io-github/_config.yml
            Source: /Users/baixinpan/Desktop/OpenSource/Mine/Page-Blog/leopardpan.github.io-github
       Destination: /Users/baixinpan/Desktop/OpenSource/Mine/Page-Blog/leopardpan.github.io-github/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
                    done in 0.901 seconds.
 Auto-regeneration: enabled for '/Users/baixinpan/Desktop/OpenSource/Mine/Page-Blog/leopardpan.github.io-github'
Configuration file: /Users/baixinpan/Desktop/OpenSource/Mine/Page-Blog/leopardpan.github.io-github/_config.yml
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.

```

表示本地服务部署成功。

在浏览器输入 [127.0.0.1:4000](127.0.0.1:4000) ， 就可以看到[wanghengliang.cn](http://wanghengliang.cn)博客效果了。


发现markdown中代码部分显示不正常，原因是jekyllMarkdown的解析器版本太旧，通过如下命令更新：

```
$ bundle update
```

### 发布博客
然后使用 git push 到你自己的仓库里面去，检查你远端仓库，在浏览器输入 username.github.io 就会发现，你有一个漂亮的主题模板了。  

### 绑定自己的域名
CNAME里面的wanghengliang.cn修改成你自己的域名，如果你暂时没有域名，直接把CNAME文件删除即可。    
