---
layout: post
title: 执行brew install命令长时间卡在 Updating Homebrew 的解决方法
date: 2019-11-13
categories: MacOS
tags: MacOS brew
---
执行brew install命令长时间卡在 Updating Homebrew 的解决方法

在国内的网络环境下使用 Homebrew 安装软件的过程中可能会长时间卡在 Updating Homebrew 这个步骤。

### 解决方法一
方法 1：按住 control + c 取消本次更新操作,这个方法是临时的、一次性的

按住 control + c 之后命令行会显示 ^C，就代表已经取消了 Updating Homebrew 操作,大概不到 1 秒钟之后就会去执行我们真正需要的安装操作了

### 解决方法二
方法 2：国内镜像源进行加速

平时我们执行 brew 命令安装软件的时候，跟以下 4 个仓库地址有关：
1. brew.git
2. homebrew-core.git
3. homebrew-cask.git
4. homebrew-bottles

通过以下操作将这 4 个仓库地址全部替换为国内镜像源

```
# 替换成阿里巴巴的 brew.git 仓库地址:
cd "$(brew --repo)"
git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git

# 替换成阿里巴巴的 homebrew-core.git 仓库地址:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git

# 替换成中国科学技术大学的 homebrew-cask 仓库地址：
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-cask"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git

# 替换 homebrew-bottles 访问 URL:
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile

```

还原官方镜像源

```
# 还原为官方提供的 brew.git 仓库地址
cd "$(brew --repo)"
git remote set-url origin https://github.com/Homebrew/brew.git

# 还原为官方提供的 homebrew-core.git 仓库地址
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://github.com/Homebrew/homebrew-core.git

# 还原为官方提供的 homebrew-cask.git 仓库地址
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-cask"
git remote set-url origin https://github.com/Homebrew/homebrew-cask.git

# 还原为官方提供的 homebrew-bottles 访问地址
vi ~/.bash_profile
# 然后，删除 HOMEBREW_BOTTLE_DOMAIN 这一行配置
source ~/.bash_profile
```




