---
layout: post
title: Linux防火墙设置
date: 2019-05-31
categories: 
tags: linux 防火墙
---
Linux防火墙设置


启动指令:service iptables start   
重启指令:service iptables restart   
关闭指令:service iptables stop


vi /etc/sysconfig/iptables
service iptables restart
service iptables save

远程操作一定不能执行 iptables -F //清空规则缓冲区

https://blog.csdn.net/slovyz/article/details/79900082


iptables 的历史以及工作原理
1.iptables的发展:
iptables的前身叫ipfirewall （内核1.x时代）,这是一个作者从freeBSD上移植过来的，能够工作在内核当中的，对数据包进行检测的一款简易访问控制工具。但是ipfirewall工作功能极其有限(它需要将所有的规则都放进内核当中，这样规则才能够运行起来，而放进内核，这个做法一般是极其困难的)。当内核发展到2.x系列的时候，软件更名为ipchains，它可以定义多条规则，将他们串起来，共同发挥作用，而现在，它叫做iptables，可以将规则组成一个列表，实现绝对详细的访问控制功能。
他们都是工作在用户空间中，定义规则的工具，本身并不算是防火墙。它们定义的规则，可以让在内核空间当中的netfilter来读取，并且实现让防火墙工作。而放入内核的地方必须要是特定的位置，必须是tcp/ip的协议栈经过的地方。而这个tcp/ip协议栈必须经过的地方，可以实现读取规则的地方就叫做 netfilter.(网络过滤器)
作者一共在内核空间中选择了5个位置，
1.内核空间中：从一个网络接口进来，到另一个网络接口去的
2.数据包从内核流入用户空间的
3.数据包从用户空间流出的
4.进入/离开本机的外网接口
5.进入/离开本机的内网接口
2.iptables的工作机制
从上面的发展我们知道了作者选择了5个位置，来作为控制的地方，但是你有没有发现，其实前三个位置已经基本上能将路径彻底封锁了，但是为什么已经在进出的口设置了关卡之后还要在内部卡呢？ 由于数据包尚未进行路由决策，还不知道数据要走向哪里，所以在进出口是没办法实现数据过滤的。所以要在内核空间里设置转发的关卡，进入用户空间的关卡，从用户空间出去的关卡。那么，既然他们没什么用，那我们为什么还要放置他们呢？因为我们在做NAT和DNAT的时候，目标地址转换必须在路由之前转换。所以我们必须在外网而后内网的接口处进行设置关卡。
这五个位置也被称为五个钩子函数（hook functions）,也叫五个规则链。
1.PREROUTING (路由前)
2.INPUT (数据包流入口)
3.FORWARD (转发管卡)
4.OUTPUT(数据包出口)
5.POSTROUTING（路由后）
这是NetFilter规定的五个规则链，任何一个数据包，只要经过本机，必将经过这五个链中的其中一个链。
3.防火墙的策略
防火墙策略一般分为两种，一种叫“通”策略，一种叫“堵”策略，通策略，默认门是关着的，必须要定义谁能进。堵策略则是，大门是洞开的，但是你必须有身份认证，否则不能进。所以我们要定义，让进来的进来，让出去的出去，所以通，是要全通，而堵，则是要选择。当我们定义的策略的时候，要分别定义多条功能，其中：定义数据包中允许或者不允许的策略，filter过滤的功能，而定义地址转换的功能的则是nat选项。为了让这些功能交替工作，我们制定出了“表”这个定义，来定义、区分各种不同的工作功能和处理方式。
我们现在用的比较多个功能有3个：
1.filter 定义允许或者不允许的
2.nat 定义地址转换的
3.mangle功能:修改报文原数据
我们修改报文原数据就是来修改TTL的。能够实现将数据包的元数据拆开，在里面做标记/修改内容的。而防火墙标记，其实就是靠mangle来实现的。
小扩展:
对于filter来讲一般只能做在3个链上：INPUT ，FORWARD ，OUTPUT
对于nat来讲一般也只能做在3个链上：PREROUTING ，OUTPUT ，POSTROUTING
而mangle则是5个链都可以做：PREROUTING，INPUT，FORWARD，OUTPUT，POSTROUTING
iptables/netfilter（这款软件）是工作在用户空间的，它可以让规则进行生效的，本身不是一种服务，而且规则是立即生效的。而我们iptables现在被做成了一个服务，可以进行启动，停止的。启动，则将规则直接生效，停止，则将规则撤销。
iptables还支持自己定义链。但是自己定义的链，必须是跟某种特定的链关联起来的。在一个关卡设定，指定当有数据的时候专门去找某个特定的链来处理，当那个链处理完之后，再返回。接着在特定的链中继续检查。
注意：规则的次序非常关键，谁的规则越严格，应该放的越靠前，而检查规则的时候，是按照从上往下的方式进行检查的。
三．规则的写法:
iptables定义规则的方式比较复杂:
格式：iptables [-t table] COMMAND chain CRETIRIA -j ACTION
-t table ：3个filter nat mangle
COMMAND：定义如何对规则进行管理
chain：指定你接下来的规则到底是在哪个链上操作的，当定义策略的时候，是可以省略的
CRETIRIA:指定匹配标准
-j ACTION :指定如何进行处理
比如：不允许172.16.0.0/24的进行访问。
iptables -t filter -A INPUT -s 172.16.0.0/16 -p udp --dport 53 -j DROP
当然你如果想拒绝的更彻底：
iptables -t filter -R INPUT 1 -s 172.16.0.0/16 -p udp --dport 53 -j REJECT
iptables -L -n -v	#查看定义规则的详细信息
四：详解COMMAND:
1.链管理命令（这都是立即生效的）
-P :设置默认策略的（设定默认门是关着的还是开着的）
默认策略一般只有两种
iptables -P INPUT (DROP|ACCEPT) 默认是关的/默认是开的
比如：
iptables -P INPUT DROP 这就把默认规则给拒绝了。并且没有定义哪个动作，所以关于外界连接的所有规则包括Xshell连接之类的，远程连接都被拒绝了。
-F: FLASH，清空规则链的(注意每个链的管理权限)
iptables -t nat -F PREROUTING
iptables -t nat -F 清空nat表的所有链
-N:NEW 支持用户新建一个链
iptables -N inbound_tcp_web 表示附在tcp表上用于检查web的。
-X: 用于删除用户自定义的空链
使用方法跟-N相同，但是在删除之前必须要将里面的链给清空昂了
-E：用来Rename chain主要是用来给用户自定义的链重命名
-E oldname newname
-Z：清空链，及链中默认规则的计数器的（有两个计数器，被匹配到多少个数据包，多少个字节）
iptables -Z :清空
2.规则管理命令
-A：追加，在当前链的最后新增一个规则
-I num : 插入，把当前规则插入为第几条。
-I 3 :插入为第三条
-R num：Replays替换/修改第几条规则
格式：iptables -R 3 …………
-D num：删除，明确指定删除第几条规则
3.查看管理命令 “-L”
附加子命令
-n：以数字的方式显示ip，它会将ip直接显示出来，如果不加-n，则会将ip反向解析成主机名。
-v：显示详细信息
-vv
-vvv :越多越详细
-x：在计数器上显示精确值，不做单位换算
--line-numbers : 显示规则的行号
-t nat：显示所有的关卡的信息
五：详解匹配标准
1.通用匹配：源地址目标地址的匹配
-s：指定作为源地址匹配，这里不能指定主机名称，必须是IP
IP | IP/MASK | 0.0.0.0/0.0.0.0
而且地址可以取反，加一个“!”表示除了哪个IP之外
-d：表示匹配目标地址
-p：用于匹配协议的（这里的协议通常有3种，TCP/UDP/ICMP）
-i eth0：从这块网卡流入的数据
流入一般用在INPUT和PREROUTING上
-o eth0：从这块网卡流出的数据
流出一般在OUTPUT和POSTROUTING上
2.扩展匹配
2.1隐含扩展：对协议的扩展
-p tcp :TCP协议的扩展。一般有三种扩展
--dport XX-XX：指定目标端口,不能指定多个非连续端口,只能指定单个端口，比如
--dport 21 或者 --dport 21-23 (此时表示21,22,23)
--sport：指定源端口
--tcp-fiags：TCP的标志位（SYN,ACK，FIN,PSH，RST,URG）
对于它，一般要跟两个参数：
1.检查的标志位
2.必须为1的标志位
--tcpflags syn,ack,fin,rst syn = --syn
表示检查这4个位，这4个位中syn必须为1，其他的必须为0。所以这个意思就是用于检测三次握手的第一次包的。对于这种专门匹配第一包的SYN为1的包，还有一种简写方式，叫做--syn
-p udp：UDP协议的扩展
--dport
--sport
-p icmp：icmp数据报文的扩展
--icmp-type：
echo-request(请求回显)，一般用8 来表示
所以 --icmp-type 8 匹配请求回显数据包
echo-reply （响应的数据包）一般用0来表示
2.2显式扩展（-m）
扩展各种模块
-m multiport：表示启用多端口扩展
之后我们就可以启用比如 --dports 21,23,80
六：详解-j ACTION
常用的ACTION：
DROP：悄悄丢弃
一般我们多用DROP来隐藏我们的身份，以及隐藏我们的链表
REJECT：明示拒绝
ACCEPT：接受
custom_chain：转向一个自定义的链
DNAT
SNAT
MASQUERADE：源地址伪装
REDIRECT：重定向：主要用于实现端口重定向
MARK：打防火墙标记的
RETURN：返回
在自定义链执行完毕后使用返回，来返回原规则链。
七：状态检测：
是一种显式扩展，用于检测会话之间的连接关系的，有了检测我们可以实现会话间功能的扩展
什么是状态检测？对于整个TCP协议来讲，它是一个有连接的协议，三次握手中，第一次握手，我们就叫NEW连接，而从第二次握手以后的，ack都为1，这是正常的数据传输，和tcp的第二次第三次握手，叫做已建立的连接（ESTABLISHED）,还有一种状态，比较诡异的，比如：SYN=1 ACK=1 RST=1,对于这种我们无法识别的，我们都称之为INVALID无法识别的。还有第四种，FTP这种古老的拥有的特征，每个端口都是独立的，21号和20号端口都是一去一回，他们之间是有关系的，这种关系我们称之为RELATED。
所以我们的状态一共有四种：
NEW
ESTABLISHED
RELATED
INVALID
八：SNAT和DNAT的实现
由于我们现在IP地址十分紧俏，已经分配完了，这就导致我们必须要进行地址转换，来节约我们仅剩的一点IP资源。那么通过iptables如何实现NAT的地址转换呢？
1.SNAT基于原地址的转换
基于原地址的转换一般用在我们的许多内网用户通过一个外网的口上网的时候，这时我们将我们内网的地址转换为一个外网的IP，我们就可以实现连接其他外网IP的功能。
所以我们在iptables中就要定义到底如何转换：
定义的样式：
比如我们现在要将所有192.168.10.0网段的IP在经过的时候全都转换成172.16.100.1这个假设出来的外网地址：
iptables -t nat -A POSTROUTING -s 192.168.10.0/24 -j SNAT --to-source 172.16.100.1
这样，只要是来自本地网络的试图通过网卡访问网络的，都会被统统转换成172.16.100.1这个IP.
那么，如果172.16.100.1不是固定的怎么办？
我们都知道当我们使用联通或者电信上网的时候，一般它都会在每次你开机的时候随机生成一个外网的IP，意思就是外网地址是动态变换的。这时我们就要将外网地址换成 MASQUERADE(动态伪装):它可以实现自动寻找到外网地址，而自动将其改为正确的外网地址。所以，我们就需要这样设置：
iptables -t nat -A POSTROUTING -s 192.168.10.0/24 -j MASQUERADE
这里要注意：地址伪装并不适用于所有的地方。
2.DNAT目标地址转换
对于目标地址转换，数据流向是从外向内的，外面的是客户端，里面的是服务器端通过目标地址转换，我们可以让外面的ip通过我们对外的外网ip来访问我们服务器不同的服务器，而我们的服务却放在内网服务器的不同的服务器上。
如何做目标地址转换呢？：
iptables -t nat -A PREROUTING -d 192.168.10.18 -p tcp --dport 80 -j DNAT --todestination 172.16.100.2
目标地址转换要做在到达网卡之前进行转换,所以要做在PREROUTING这个位置上
九：控制规则的存放以及开启
注意：你所定义的所有内容，当你重启的时候都会失效，要想我们能够生效，需要使用一个命令将它保存起来
1.service iptables save 命令
它会保存在/etc/sysconfig/iptables这个文件中
2.iptables-save 命令
iptables-save > /etc/sysconfig/iptables
3.iptables-restore 命令
开机的时候，它会自动加载/etc/sysconfig/iptabels
如果开机不能加载或者没有加载，而你想让一个自己写的配置文件（假设为iptables.2）手动生效的话：
iptables-restore < /etc/sysconfig/iptables.2
则完成了将iptables中定义的规则手动生效