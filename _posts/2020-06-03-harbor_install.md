---
dolayout: post
title: Harbor安装
date: 2020-06-03
categories: 
tags: docker harbor
---
利用Harbor搭建docker 私有仓库

### 下载harbor 

[harbor github 地址](https://github.com/goharbor/harbor)
直接下载编译好的包[下载地址](https://github.com/goharbor/harbor/releases)

包括有两个包**Harbor offline installer** 和 **Harbor online installer**，此处下载offline版本。

* **Online installer :** 在线安装版直接从DockerHub下载Harbor镜像。
* **Offline installer :** 如果部署Harbor的主机不能联网可选择离线安装版，离线安装版包括Harbor镜像文件。

### 解压安装harbor

解压安装包

```
#使用tar命令解压到/usr/local/目录下
tar -zxvf harbor-online-installer-v1.10.2.tgz -C /usr/local/
```

安装harbor

```
$ cd /usr/local/harbor
## 编辑harbor的配置文件
$ vi harbor.yml
	#修改以下内容
	hostname = 192.168.159.134 #修改harbor的启动ip，这里需要依据系统ip设置
	port: 80 #harbor的端口,有两个端口,http协议(80)和https协议(443)
	harbor_admin_password = admin #修改harbor的admin用户的密码
	data_volume: /data/harbor	#修改harbor存储位置
	#注释掉https配置，包括端口及证书路径
	# https:
	#   port: 443
	#   certificate: /your/certificate/path
  #   private_key: /your/private/key/path
  
$ ./prepare #配置Harbor
$ ./install.sh #安装Harbor
```

配置harbor

```
## 设置Harbor开机启动
$ vi /lib/systemd/system/harbor.service

[Unit]
Description=Harbor
After=docker.service systemd-networkd.service systemd-resolved.service
Requires=docker.service
Documentation=http://github.com/vmware/harbor

[Service]
Type=simple
Restart=on-failure
RestartSec=5
#需要注意harbor的安装位置
ExecStart=/usr/bin/docker-compose -f  /usr/local/harbor/docker-compose.yml up
ExecStop=/usr/bin/docker-compose -f /usr/local/harbor/docker-compose.yml down	

[Install]
WantedBy=multi-user.target

$ systemctl enable harbor
```

开放2375端口

注意:在外网开放有安全风险，只推荐在内网对外开放

```
$ vi /lib/systemd/system/docker.service
## 修改[Service]节点，增加 -H tcp://0.0.0.0:2375
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock

$ systemctl daemon-reload
$ systemctl restart docker
$ systemctl restart harbor
```



### harbor操作说明

```
## 关闭harbor服务
$ docker-compose down -v

## 启动Harbor服务
$ docker-compose up -d

## 重启harbor
$ docker-compose down -v && docker-compose up -d

## 常用debug方式
## 查看docker程序的配置信息
$ docker info  
## 查看harbor相关的容器信息
$ docker-compose ps

## 注意：如果更改了harbor.yml文件，必须要重新执行install脚本,或者执行./prepare脚本，生成新的配置文件；
```



### harbor测试

修改docker配置文件，使docker支持harbor

编辑客户机`/etc/docker/daemon.json`文件

```
$ vi /etc/docker/daemon.json
{ "insecure-registries": [ "192.168.159.134" ] }

$ systemctl daemon-reload && systemctl restart docker

$ docker login 192.168.159.134
Username: admin
Password:
Login Succeeded
$ docker pull 192.168.159.134/blade/demo:latest

```





### 附: VirtualBox虚拟机增加磁盘空间

之前采用默认分配了8G空间，后来发现空间不够，需增加磁盘空间，方法如下：

修改磁盘大小，停掉虚拟机，在VirtualBox设置-存储中查看磁盘位置，通过VBoxManage命令修改磁盘大小

```
## 增加磁盘空间到20G，resize参数单位为M，20G=20480M
$ VBoxManage modifyhd /Volumes/wd/vbox/harbor/harbor-disk1.vdi --resize 20480
```

扩容核心操作，启动虚拟机并进入，执行下面命令

```
-------------------------------------------------------------------------
[root@harbor ~]# fdisk -l

磁盘 /dev/sda：21.5 GB, 21474836480 字节，41943040 个扇区
Units = 扇区 of 1 * 512 = 512 bytes
扇区大小(逻辑/物理)：512 字节 / 512 字节
I/O 大小(最小/最佳)：512 字节 / 512 字节
磁盘标签类型：dos
磁盘标识符：0x0003864b

   设备 Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048     2099199     1048576   83  Linux
/dev/sda2         2099200    16777215     7339008   8e  Linux LVM

磁盘 /dev/mapper/centos-root：6652 MB, 6652166144 字节，12992512 个扇区
Units = 扇区 of 1 * 512 = 512 bytes
扇区大小(逻辑/物理)：512 字节 / 512 字节
I/O 大小(最小/最佳)：512 字节 / 512 字节


磁盘 /dev/mapper/centos-swap：859 MB, 859832320 字节，1679360 个扇区
Units = 扇区 of 1 * 512 = 512 bytes
扇区大小(逻辑/物理)：512 字节 / 512 字节
I/O 大小(最小/最佳)：512 字节 / 512 字节

-------------------------------------------------------------------------
[root@harbor ~]# fdisk /dev/sda
欢迎使用 fdisk (util-linux 2.23.2)。

更改将停留在内存中，直到您决定将更改写入磁盘。
使用写入命令前请三思。

命令(输入 m 获取帮助)：m
命令操作
   a   toggle a bootable flag
   b   edit bsd disklabel
   c   toggle the dos compatibility flag
   d   delete a partition
   g   create a new empty GPT partition table
   G   create an IRIX (SGI) partition table
   l   list known partition types
   m   print this menu
   n   add a new partition
   o   create a new empty DOS partition table
   p   print the partition table
   q   quit without saving changes
   s   create a new empty Sun disklabel
   t   change a partition's system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit
   x   extra functionality (experts only)

命令(输入 m 获取帮助)：n
Partition type:
   p   primary (2 primary, 0 extended, 2 free)
   e   extended
Select (default p): p
分区号 (3,4，默认 3)：3
起始 扇区 (16777216-41943039，默认为 16777216)：
将使用默认值 16777216
Last 扇区, +扇区 or +size{K,M,G} (16777216-41943039，默认为 41943039)：
将使用默认值 41943039
分区 3 已设置为 Linux 类型，大小设为 12 GiB

命令(输入 m 获取帮助)：t
分区号 (1-3，默认 3)：3
Hex 代码(输入 L 列出所有代码)：l

 0  空              24  NEC DOS         81  Minix / 旧 Linu bf  Solaris
 1  FAT12           27  隐藏的 NTFS Win 82  Linux 交换 / So c1  DRDOS/sec (FAT-
 2  XENIX root      39  Plan 9          83  Linux           c4  DRDOS/sec (FAT-
 3  XENIX usr       3c  PartitionMagic  84  OS/2 隐藏的 C:  c6  DRDOS/sec (FAT-
 4  FAT16 <32M      40  Venix 80286     85  Linux 扩展      c7  Syrinx
 5  扩展            41  PPC PReP Boot   86  NTFS 卷集       da  非文件系统数据
 6  FAT16           42  SFS             87  NTFS 卷集       db  CP/M / CTOS / .
 7  HPFS/NTFS/exFAT 4d  QNX4.x          88  Linux 纯文本    de  Dell 工具
 8  AIX             4e  QNX4.x 第2部分  8e  Linux LVM       df  BootIt
 9  AIX 可启动      4f  QNX4.x 第3部分  93  Amoeba          e1  DOS 访问
 a  OS/2 启动管理器 50  OnTrack DM      94  Amoeba BBT      e3  DOS R/O
 b  W95 FAT32       51  OnTrack DM6 Aux 9f  BSD/OS          e4  SpeedStor
 c  W95 FAT32 (LBA) 52  CP/M            a0  IBM Thinkpad 休 eb  BeOS fs
 e  W95 FAT16 (LBA) 53  OnTrack DM6 Aux a5  FreeBSD         ee  GPT
 f  W95 扩展 (LBA)  54  OnTrackDM6      a6  OpenBSD         ef  EFI (FAT-12/16/
10  OPUS            55  EZ-Drive        a7  NeXTSTEP        f0  Linux/PA-RISC
11  隐藏的 FAT12    56  Golden Bow      a8  Darwin UFS      f1  SpeedStor
12  Compaq 诊断     5c  Priam Edisk     a9  NetBSD          f4  SpeedStor
14  隐藏的 FAT16 <3 61  SpeedStor       ab  Darwin 启动     f2  DOS 次要
16  隐藏的 FAT16    63  GNU HURD or Sys af  HFS / HFS+      fb  VMware VMFS
17  隐藏的 HPFS/NTF 64  Novell Netware  b7  BSDI fs         fc  VMware VMKCORE
18  AST 智能睡眠    65  Novell Netware  b8  BSDI swap       fd  Linux raid 自动
1b  隐藏的 W95 FAT3 70  DiskSecure 多启 bb  Boot Wizard 隐  fe  LANstep
1c  隐藏的 W95 FAT3 75  PC/IX           be  Solaris 启动    ff  BBT
1e  隐藏的 W95 FAT1 80  旧 Minix
Hex 代码(输入 L 列出所有代码)：8e
已将分区“Linux”的类型更改为“Linux LVM”

命令(输入 m 获取帮助)：w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: 设备或资源忙.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
正在同步磁盘。

## 重启后执行sudo fdisk -l查看设备Boot（我的为 /dev/sda3 ）
-------------------------------------------------------------------------
[root@harbor ~]# reboot
[root@harbor ~]# fdisk -l

磁盘 /dev/sda：21.5 GB, 21474836480 字节，41943040 个扇区
Units = 扇区 of 1 * 512 = 512 bytes
扇区大小(逻辑/物理)：512 字节 / 512 字节
I/O 大小(最小/最佳)：512 字节 / 512 字节
磁盘标签类型：dos
磁盘标识符：0x0003864b

   设备 Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048     2099199     1048576   83  Linux
/dev/sda2         2099200    16777215     7339008   8e  Linux LVM
/dev/sda3        16777216    41943039    12582912   8e  Linux LVM

磁盘 /dev/mapper/centos-root：6652 MB, 6652166144 字节，12992512 个扇区
Units = 扇区 of 1 * 512 = 512 bytes
扇区大小(逻辑/物理)：512 字节 / 512 字节
I/O 大小(最小/最佳)：512 字节 / 512 字节


磁盘 /dev/mapper/centos-swap：859 MB, 859832320 字节，1679360 个扇区
Units = 扇区 of 1 * 512 = 512 bytes
扇区大小(逻辑/物理)：512 字节 / 512 字节
I/O 大小(最小/最佳)：512 字节 / 512 字节

## 将分区格式化为ext4格式
-------------------------------------------------------------------------
[root@harbor ~]# mkfs.ext4 /dev/sda3
mke2fs 1.42.9 (28-Dec-2013)
文件系统标签=
OS type: Linux
块大小=4096 (log=2)
分块大小=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
786432 inodes, 3145728 blocks
157286 blocks (5.00%) reserved for the super user
第一个数据块=0
Maximum filesystem blocks=2151677952
96 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks:
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208

Allocating group tables: 完成
正在写入inode表: 完成
Creating journal (32768 blocks): 完成
Writing superblocks and filesystem accounting information: 完成

## 创建新的物理分区
-------------------------------------------------------------------------
[root@harbor ~]# sudo pvcreate /dev/sda3
WARNING: ext4 signature detected on /dev/sda3 at offset 1080. Wipe it? [y/n]: y
  Wiping ext4 signature on /dev/sda3.
  Physical volume "/dev/sda3" successfully created.
[root@harbor ~]# sudo vgextend centos /dev/sda3
  Volume group "centos" successfully extended


查看LVM信息
1.pvdisplay 查看物理卷
2.vgdisplay 查看虚拟卷
3.lvdisplay 查看逻辑卷
-------------------------------------------------------------------------
[root@harbor ~]# pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda2
  VG Name               centos
  PV Size               <7.00 GiB / not usable 3.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              1791
  Free PE               0
  Allocated PE          1791
  PV UUID               jhAzWm-Cbsk-UjUg-328S-Ckk4-IHyQ-e2AnR8

  --- Physical volume ---
  PV Name               /dev/sda3
  VG Name               centos
  PV Size               12.00 GiB / not usable 4.00 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              3071
  Free PE               3071
  Allocated PE          0
  PV UUID               DqL9Bo-HC7B-HMde-cG9o-eAXy-MSQ5-fedoxS

查看LVM信息
2.vgdisplay 查看虚拟卷
-------------------------------------------------------------------------
[root@harbor ~]# vgdisplay
  --- Volume group ---
  VG Name               centos
  System ID
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  4
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                2
  Open LV               2
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               18.99 GiB
  PE Size               4.00 MiB
  Total PE              4862
  Alloc PE / Size       1791 / <7.00 GiB
  Free  PE / Size       3071 / <12.00 GiB
  VG UUID               Cn32hR-TEcI-Z5zC-Rmrf-cIwI-fUwW-QymcyG

## 扩展到卷 组（centos便是下图中的VG Name）
-------------------------------------------------------------------------
[root@harbor ~]# vgextend centos /dev/sda3
信息缺失。。。

查看LVM信息
3.lvdisplay 查看逻辑卷，根据大小判定/dev/centos/root即是根分区
-------------------------------------------------------------------------
[root@harbor ~]# lvdisplay
  --- Logical volume ---
  LV Path                /dev/centos/swap
  LV Name                swap
  VG Name                centos
  LV UUID                hNLuJD-KQZI-QziE-dXSg-orES-qVqj-gRyX4X
  LV Write Access        read/write
  LV Creation host, time db-mysql, 2020-06-02 16:12:47 +0800
  LV Status              available
  # open                 2
  LV Size                820.00 MiB
  Current LE             205
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:1

  --- Logical volume ---
  LV Path                /dev/centos/root
  LV Name                root
  VG Name                centos
  LV UUID                kE4nqp-3z3Q-JhDB-fBcK-FnYZ-WiFc-fLef6w
  LV Write Access        read/write
  LV Creation host, time db-mysql, 2020-06-02 16:12:48 +0800
  LV Status              available
  # open                 1
  LV Size                <6.20 GiB
  Current LE             1586
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:0
  
-------------------------------------------------------------------------
[root@harbor ~]# lvextend /dev/centos/root /dev/sda3
  Size of logical volume centos/root changed from <6.20 GiB (1586 extents) to 18.19 GiB (4657 extents).
  Logical volume centos/root successfully resized.
[root@harbor ~]# sudo resize2fs /dev/centos/root
resize2fs 1.42.9 (28-Dec-2013)
resize2fs: Bad magic number in super-block 当尝试打开 /dev/centos/root 时
找不到有效的文件系统超级块.


## 刷新逻辑分区容量
##如果报错则是因为你的某些分区使用的是xfs的文件系统，执行 xfs_growfs /dev/centos/root 刷新逻辑分区即可
-------------------------------------------------------------------------
[root@harbor ~]# resize2fs /dev/centos/root

## 刷新逻辑分区
-------------------------------------------------------------------------
[root@harbor ~]# xfs_growfs /dev/centos/root
meta-data=/dev/mapper/centos-root isize=512    agcount=4, agsize=406016 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0 spinodes=0
data     =                       bsize=4096   blocks=1624064, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal               bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 1624064 to 4768768

## 这时执行sudo df -h //会发现根分区容量变大了，恭喜你成功了
-------------------------------------------------------------------------
[root@harbor ~]# df -h
文件系统                 容量  已用  可用 已用% 挂载点
devtmpfs                 485M     0  485M    0% /dev
tmpfs                    496M     0  496M    0% /dev/shm
tmpfs                    496M  6.8M  489M    2% /run
tmpfs                    496M     0  496M    0% /sys/fs/cgroup
/dev/mapper/centos-root   19G  4.8G   14G   26% /
/dev/sda1               1014M  168M  847M   17% /boot
tmpfs                    100M     0  100M    0% /run/user/0

## 最后reboot重启一下便可以啦！
-------------------------------------------------------------------------
[root@harbor ~]# reboot
```

