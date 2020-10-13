---
layout: post
title: git学习总结
date: 2020-04-13
categories: git
tags: git
---
git学习总结

### Git是什么？

#### git的特点

**有助于分布式开发**：git允许并行开发，各人可以在自己的版本库中独立且同时开发，不需要与一个中心版本时刻同步。允许许多开发者在不同的地方甚至离线的情况无障碍的开发

**能够胜任上千开发人员的规模**：支持上千开发人员规模的VCS(Version Control System)版本控制系统

**性能优异**：快速且高效，使用“压缩”和“差异比较”技术节约存储空间，进而节约传输时间。使用分布式开发模型，而非集中式开发模型，确保了网络不确定因素不会影响到日常开发的效率。

**保持完整性和可靠性**：git采用了一个叫做“安全散列函数”(SHA1)的通用加密散列函数来命名和识别数据库中的对象。虽然理论上不是绝对的，但是在实践中已经证实这是足够可靠的方式。

**强化责任**：git对每个有文件改动的提交强制使用“改动日志”。进而可对所有的改动进行责任最终。

**不可变性**：git版本库中存储的对象均为不可变的。一点创建数据对象并把他存储到数据库中，它们便不可修改。这样的好处很多如快速比较相同性。

**原子事务**：git通过记录完整、离散的版本库状态来实现原子事务。

**支持并鼓励基于分支的开发**：git支持分支开发，并提供了一个简单、清晰、快速的合并功能。

**完整的版本库**：每个人的版本库中都有一份关于每个文件的完整历史修订信息。

**一个清晰的内部设计**：

**免费自由**：be free ,as in freedom.

#### git快速入门

##### git安装

到[git官方网站](https://git-scm.com/download)上下载软件进行安装即可。

##### git配置

git自带一个config工具，首次安装好git后，可通过此工具设置控制 Git 外观和行为的配置变量。这些变量存储在三个不同的位置：

* `/etc/gitconfig` 文件: 包含系统上每一个用户及他们仓库的通用配置。如果在执行 `git config` 时带上 `--system` 选项，那么它就会读写该文件中的配置变量。
* `~/.gitconfig` 或 `~/.config/git/config` 文件：只针对当前用户。你可以传递 `--global` 选项让 Git 读写此文件，这会对你系统上 **所有** 的仓库生效。
* 当前使用仓库的 Git 目录中的 `config` 文件（即 `.git/config`）：针对该仓库。 你可以传递 `--local` 选项让 Git 强制读写此文件，虽然默认情况下用的就是它。

优先级顺序为： `.git/config` > `~/.gitconfig`  >  `/etc/gitconfig`

配置用户信息



### Git基本概念

Git版本库不仅仅提供版本库中所有文件的完整副本，还提供 版本库本身的副本。在版本库中，Git维护两个主要的数据结构:对象库(object store)和 索引(index)。所有这些版本库数据存放在工作目录根目录下一个名 为**.git** 的隐藏子目录中。

#### git对象类型

对象库是Git版本库实现的心脏。它包含你的原始数据文件和所有日志 消息、作者信息、日期，以及其他用来重建项目任意版本或分支的信息。

Git放在对象库里的对象只有4种类型:`块(blob)`、`目录树(tree)`、 `提交(commit)`和`标签(tag)`。这4种原子对象构成Git高层数据结构的基 础。

**块(blob)**

文件的每一个版本表示为一个块(blob)。一个blob保存一个文件的数据，但不包含任何关于 这个文件的元数据，甚至连文件名也没有。

**目录树(tree)**

一个目录树(tree)对象代表一层目录信息。它记录blob标识符、路径名和在一个目录里所有文件的一些元数据。它也可以递归引用其他目录树或子树对象，从而建立一个包含文件和子目录的完整层次结构。

**提交(commit)**

一个提交(commit)对象保存版本库中每一次变化的元数据，包括作者、提交者、提交日期和日志消息。每一个提交对象指向一个目录树对象，这个目录树对象在一张完整的快照中捕获提交时版本库的状态。最初的提交或者根提交(root commit)是没有父提交的。大多数提交都有一个父提交。

**标签(tag)** 

一个标签对象分配一个任意的且人类可读的名字给一个特定对象，通常是一个提交对象。虽然9da581d910c9c4ac93557ca4859e767f5caf5169指的 是一个确切且定义好的提交，但是一个更熟悉的标签名(如Ver-1.0- Alpha)可能会更有意义!

随着时间的推移，所有信息在对象库中会变化和增长，项目的编辑、 添加和删除都会被跟踪和建模。为了有效地利用磁盘空间和网络带宽，Git 把对象压缩并存储在打包文件(pack file)里，这些文件也在对象库里。

这里会用一个简单的例子让大家直观感受一下git是怎么储存信息的。

首先初始化一个git版本库

```shell
$ git init
## 初始化后会生成git对象库信息,但是没有对象信息
$ ll .git
total 24
-rw-r--r--   1 hengliang  staff    23B  9 25 10:25 HEAD
drwxr-xr-x   2 hengliang  staff    64B  9 25 10:25 branches
-rw-r--r--   1 hengliang  staff   137B  9 25 10:25 config
-rw-r--r--   1 hengliang  staff    73B  9 25 10:25 description
drwxr-xr-x  12 hengliang  staff   384B  9 25 10:25 hooks
drwxr-xr-x   3 hengliang  staff    96B  9 25 10:25 info
drwxr-xr-x   4 hengliang  staff   128B  9 25 10:25 objects
drwxr-xr-x   4 hengliang  staff   128B  9 25 10:25 refs
```
我们先创建两个文件
```shell
$ echo '111' > a.txt
$ echo '222' > b.txt
$ git add *.txt
## 执行add命令后，仓库里面多了2个object
$ tree .git/objects
.git/objects
├── 58
│   └── c9bdf9d017fcd178dc8c073cbfcbb7ff240d6c
├── c2
│   └── 00906efd24ec5e783bee7f23b5d7c941b0c12c
├── info
└── pack
```

通过`git cat-file` 命令查看文件类型和内容,这里我们遇到第一种Git object，blob类型，它只储存的是一个文件的内容，不包括文件名等其他信息。然后将这些信息经过SHA1哈希算法得到对应的哈希值58c9bdf9d017fcd178dc8c073cbfcbb7ff240d6c，作为这个object在Git仓库中的唯一身份证。

```````shell
## git cat-file -t 可以查看object的类型
$ git cat-file -t 58c9
blob
## git cat-file -p可以查看object储存的具体内容
$ git cat-file -p 58c9
111
```````

现在我们提交一下刚刚创建的两个文件

```shell
$ git commit -m "feat:增加连个文件a.txt和b.txt"
[master (root-commit) 49ac3b9] feat:增加连个文件a.txt和b.txt
 2 files changed, 2 insertions(+)
 create mode 100644 a.txt
 create mode 100644 b.txt

$ tree .git/objects
.git/objects
├── 49
│   └── ac3b91f06b197d6663859ea4deef2c9ddd49ee
├── 4c
│   └── aaa1a9ae0b274fba9e3675f9ef071616e5b209
├── 58
│   └── c9bdf9d017fcd178dc8c073cbfcbb7ff240d6c
├── c2
│   └── 00906efd24ec5e783bee7f23b5d7c941b0c12c
├── info
└── pack

```

当我们commit完成之后，Git仓库里面多出来两个object。同样使用`cat-file`命令，我们看看它们分别是什么类型以及具体的内容是什么。

```shell
$ git cat-file -t 4caa
tree
$ git cat-file -p 4caa
100644 blob 58c9bdf9d017fcd178dc8c073cbfcbb7ff240d6c	a.txt
100644 blob c200906efd24ec5e783bee7f23b5d7c941b0c12c	b.txt

$ git cat-file -t 49ac
commit
$ git cat-file -p 49ac
tree 4caaa1a9ae0b274fba9e3675f9ef071616e5b209
author hengliang <wanghengliang@outlook.com> 1601002121 +0800
committer hengliang <wanghengliang@outlook.com> 1601002121 +0800

feat:增加连个文件a.txt和b.txt

```

4caa为tree、49ac为commit，再看他们的内容发现

tree储存了一个目录结构（类似于文件夹），以及每一个文件（或者子文件夹）的权限、类型、对应的身份证（SHA1值）、以及文件名，如果提交文件带目录则目录也是一个tree。

commit则包含了tree哈希值和提交信息（提交的作者、提交的具体时间和提交的说明信息）。

* 再看看平常接触的分支信息储存在哪里呢？在Git仓库里面，HEAD、分支、普通的Tag可以简单的理解成是一个指针，指向对应commit的SHA1值。

```shell
$ cat .git/HEAD
ref: refs/heads/master
$ cat .git/refs/heads/master
49ac3b91f06b197d6663859ea4deef2c9ddd49ee
## 新建一个dev分支
$ git branch dev
$ cat .git/refs/heads/dev
49ac3b91f06b197d6663859ea4deef2c9ddd49ee
```
* 另起一个Git项目看看带目录的情况

```
$ git init
$ mkdir d1
$ echo "123" > d1/a1.txt
$ git add .
$ git commit -m "feat:增加带文件夹内容的提交"
$ tree .git/objects
.git/objects
├── 19
│   └── 0a18037c64c43e6b11489df4bf0b9eb6d2c9bf
├── 69
│   └── 700c8f3321a65f7499f3198b3ebbbc1f8fa658
├── 7d
│   └── 9ddec14e8e3ca23de8746f11bd6bf58f9ec541
├── dd
│   └── d4d0b0bcd7db4f1b1a0527d124d72188fbfec8
├── info
└── pack
$ cat .git/HEAD
ref: refs/heads/master
$ cat .git/refs/heads/master
7d9ddec14e8e3ca23de8746f11bd6bf58f9ec541
$ git cat-file -p 7d9d
tree 69700c8f3321a65f7499f3198b3ebbbc1f8fa658
author hengliang <wanghengliang@outlook.com> 1601184377 +0800
committer hengliang <wanghengliang@outlook.com> 1601184377 +0800

feat:增加带文件夹内容的提交
$ git cat-file -p 6970
040000 tree ddd4d0b0bcd7db4f1b1a0527d124d72188fbfec8	d1
$ git cat-file -p ddd4
100644 blob 190a18037c64c43e6b11489df4bf0b9eb6d2c9bf	a1.txt
$ git cat-file -p 190a
123
```

现在已经知道了前三种对象类型，最后再简单看看`标签(tag)`,其实和前三种相似。

```shell
$ git tag -a v1.0 -m "第一个版本"
$ cat .git/refs/tags/v1.0
d809be2a64963ad60fbcb05564bd7cc59bff3ca9
$ git cat-file -t d809
tag
$ git cat-file -p d809
object 49ac3b91f06b197d6663859ea4deef2c9ddd49ee
type commit
tag v1.0
tagger hengliang <wanghengliang@outlook.com> 1601172803 +0800

第一个版本
$ 
```

此时的仓库用图形可视化表示看上去像这样

![img](/images/posts/git/git_summary_01.jpg)



#### Git的三个分区

Git分为三个分区，分别为`工作目录`、`索引区域`、`Git仓库`。接下来我们一起了解这三个分区和Git链的内部原理。

**工作目录(working directory)**

操作系统上的文件，所有代码开发编辑都在这上面完成。

**索引区域(index or staging area)**

索引是一个临时的、动态的二进制文件，它描述整个版本库的目录结 构。更具体地说，索引捕获项目在某个时刻的整体结构的一个版本。

**Git仓库(git repository)**

由Git object记录着每一次提交的快照，以及链式结构记录的提交变更历史。

接着上面的例子，目前的仓库状态如下：

![img](/images/posts/git/git_summary_02.jpg)

修改一个文件，修改文件是在工作目录完成（动态来自于网络，其中的哈希值可能无法完全对应）

```
$ echo "333" > a.txt
```

![img](/images/posts/git/git_summary_update_file.gif)

添加到索引,当使用`git add`命令时，

1. Git会给添加的每个文件的内容创建一 个对象，但它并不会马上为树创建一个对象。
2. 更新索引。索引位于**.git/index** 中，它跟踪文件的路径名和相应的blob。每次执行命令(比 如，git add、git rm或者git mv)的时候，Git会用新的路径名和blob信息来 更新索引。查看索引文件内容可以用命令`git ls-files -s`

```shell
$ git ls-files -s
100644 58c9bdf9d017fcd178dc8c073cbfcbb7ff240d6c 0	a.txt
100644 c200906efd24ec5e783bee7f23b5d7c941b0c12c 0	b.txt
$ git add a.txt
$ git ls-files -s
100644 55bd0ac4c42e46cd751eb7405e12a35e61425550 0	a.txt
100644 c200906efd24ec5e783bee7f23b5d7c941b0c12c 0	b.txt
```

![img](/images/posts/git/git_summary_add_to_index.gif)



提交到git仓库，当执行`git commit`命令时：

1. Git首先根据当前的索引生产一个tree object，充当新提交的一个快照。
2. 创建一个新的commit object，将这次commit的信息储存起来，并且parent指向上一个commit，组成一条链记录变更历史。
3. 将master分支的指针移到新的commit结点。

![img](/images/posts/git/git_summary_commit_to_git.gif)

至此我们知道了Git的三个分区分别是什么以及他们的作用，以及历史链是怎么被建立起来的。**基本上Git的大部分指令就是在操作这三个分区以及这条链。**可以尝试的思考一下git的各种命令，试一下你能不能够在上图将它们**“可视化”**出来，这个很重要，建议尝试一下。

### git命令



### git工具



### git工作流

####GitFlow简介





### 参考资料

《Git版本控制管理 第二版》人民邮电出版社

[这才是真正的Git——Git内部原理揭秘！](https://mp.weixin.qq.com/s/UQKrAR3zsdTRz8nFiLk2uQ)

[图解Git](https://marklodato.github.io/visual-git-guide/index-zh-cn.html)

