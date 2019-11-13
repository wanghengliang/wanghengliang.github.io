---
layout: post
title: IntelliJ IDEA 创建多模块项目的正确姿势
date: 2017-09-07 
categories: 开发工具
tags: IntelliJIDEA
---

### IntelliJ IDEA 创建多模块项目的正确姿势
![](/images/posts/tools/multi-project-show.png)


1. 新建一个空项目（项目类型选择Empty Project）
![](/images/posts/tools/multi-project.png)
2. 新建立模块,在菜单依次选择: File --> new --> Modual... (创建新模块需要先选中External Libraries进行创建，创建新子模块则先选中某个模块进行创建子模块)
3. 以后增加模块, 重复第2步
4. 如果要实现eclipse里的workset模块分组功能, 有两种方式
a. 右键点击模块找Move Module To Group > New Top Level Group,然后新建分组名称即可，此方法发现有时重新后分组会失效，建议到.idea/modules.xml下确认是否添加了 *group="mygroup"* 属性，添加了说明成功了，没有添加可手动添加或多等待一会儿看是否成功添加
b. 在.idea/modules.xml里的相应模块添加group="groupName" 如:

```
<module fileurl="file://$PROJECT_DIR$/test1/test1.iml" filepath="$PROJECT_DIR$/test1/test1.iml" group="mygroup"/>
```

### IntelliJ IDEA 同时打开多个项目

1. 依次点击IntelliJ IDEA -> Preferences ->Appearance&Behavior -> System Settings，设置Project Opening方式选择Open project in new window

![](/images/posts/tools/multi-project-settings.png)
