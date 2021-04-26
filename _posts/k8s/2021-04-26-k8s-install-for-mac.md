---
layout: post
title: MacOS安装docker及kubernetes
date: 2021-04-26
categories: k8s
tags: kubernetes
---
MacOS安装docker及kubernetes



### 安装Docker for Mac

直接在 [官网](https://www.docker.com/products/docker-desktop)、[官网Hub](https://hub.docker.com/editions/community/docker-ce-desktop-mac) 下载安装。

### 安装Kubernetes

正常情况下，在Mac中安装了Docker桌面版之后，可以通过Docker安装Kubernetes，我们只需要在Docker的Preferrences->Kubernetes中勾选Enable Kubernetes，然后点击`Apply & Restart`钮即可。
但由于国内网络原因，有一些Kubernetes依赖的镜像不能正常的下载，如果您是直接在Docker中启用Kubernetes，Kubernetes的状态会一直都是kubernetes is starting...

**解决办法**：

利用 [GitHub Actions](https://developer.github.com/actions/creating-github-actions/) 实现 `k8s.gcr.io` 上 `kubernetes` 依赖镜像自动同步到 [Docker Hub](https://hub.docker.com/) 上指定的仓库中。 再将所需镜像从 `Docker Hub` 的同步仓库中取回，并重新打上原始的`tag`.

Github上有个开源项目就是这样做的，所有我们可以通过此开源项目拉取kubernetes镜像，具体操作如下：

* 克隆此开源项目

```
$ git clone git@github.com:maguowei/k8s-docker-desktop-for-mac.git
```

* 查看kubernetes版本号

进入此开源项目查看images文件，查看版本是否和docker对应的kubernetes版本相同，Docker的Preferrences->Kubernetes可查看对应版本，我的是v1.19.7版本

```
$ cd k8s-docker-desktop-for-mac
$ cat images
k8s.gcr.io/kube-proxy:v1.19.7=gotok8s/kube-proxy:v1.19.7
k8s.gcr.io/kube-controller-manager:v1.19.7=gotok8s/kube-controller-manager:v1.19.7
k8s.gcr.io/kube-scheduler:v1.19.7=gotok8s/kube-scheduler:v1.19.7
k8s.gcr.io/kube-apiserver:v1.19.7=gotok8s/kube-apiserver:v1.19.7
k8s.gcr.io/coredns:1.7.0=gotok8s/coredns:1.7.0
k8s.gcr.io/pause:3.2=gotok8s/pause:3.2
k8s.gcr.io/etcd:3.4.13-0=gotok8s/etcd:3.4.13-0
```

如果你的版本不同，可通过以下命令修改版本为v1.15.5

```
$ sed -i '' "s/v1.19.7/v1.15.5/g" images
```

* 拉取kubernetes镜像
然后通过此开源项目提供的脚本从 Docker Hub 的同步仓库中取回kubernetes镜像，并重新打上原始的tag.


```
$ ./load_images.sh
```

* 拉取完成后再通过Docker设置中启用 Kubernetes 选项, 并等待一会儿，直到 Kubernetes 开始运行。

Docker的Preferrences->Kubernetes中勾选Enable Kubernetes，然后点击`Apply & Restart`钮即可

![img](http://wanghengliang.cn/images/posts/k8s/mac_docker_kubernetes.png)

* 验证 `Kubernetes` 集群状态

```
$ kubectl cluster-info
$ kubectl get nodes
$ kubectl describe node
```

