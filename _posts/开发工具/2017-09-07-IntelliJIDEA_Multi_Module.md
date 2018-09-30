---
layout: post
title: IntelliJ IDEA 创建多模块项目的正确姿势
date: 2017-09-07 
categories: 开发工具
tags: IntelliJIDEA
---

### IntelliJ IDEA 创建多模块项目的正确姿势

1. 新建一个空文件夹workspace, 用idea作为项目打开
2. 选中External Libraries, 在菜单: File --> new --> Modual... 新建立模块
3. 新建好模块后, .idea文件夹里的modules.xml里会有两个模块(如果没有找到, 重启idea), 删除第一个同工程名相同的那个默认模块. 这时.idea文件夹会从idea里消失, 不过没关系, 以后我们可以到workspace/.idea文件夹里的修改相应的文件
4. 以后增加模块, 重复第2步(一定要选中External Libraries后创建, 不然新建出来是某个模块的模块了)
5. 如果要实现eclipse里的workset模块分组功能, 有两种方式

a. 右键点击模块找Move Module To Group > New Top Level Group,然后新建分组名称即可，此方法发现有时重新后分组会失效，建议到.idea/modules.xml下确认是否添加了 *group="mygroup"* 属性，添加了说明成功了，没有添加可手动添加或多等待一会儿看是否成功添加

b. 在.idea/modules.xml里的相应模块添加group="groupName" 如:

```
<module fileurl="file://$PROJECT_DIR$/test1/test1.iml" filepath="$PROJECT_DIR$/test1/test1.iml" group="mygroup"/>
```

### IntelliJ IDEA 同时打开多个项目

1. 依次点击IntelliJ IDEA -> Preferences ->Appearance&Behavior -> System Settings，设置Project Opening方式选择Open project in new window

![](/images/posts/tools/multi-project.png)

![](/images/posts/tools/multi-project-show.png)
