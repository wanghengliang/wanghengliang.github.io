---
layout: post
title: IntelliJ IDEA Mac OS X 快捷键
date: 2017-01-03 
categories: 开发工具
tags: IntelliJIDEA 快捷键
---

IntelliJ IDEA Mac OS X 快捷键

备注：⌘ command,⌥ option,^ control,⇧ shift，⎋ esc，⇥ tab，↩ return/enter

### Editing

快捷键 | 功能描述 | 中文描述
---|---|---
^ Space | Basic code completion (the name of any class, method or variable) | 
^ ⇧ Space | Smart code completion ( lters the list of methods and variables by expected type)|
⌘⇧↩|Complete statement|自动补全语法错误部分，比如自动补全`;`、`)`等，特别是对于多重`)`不匹配等错误进行自动补全比较方便，好像只支持单行的，不支持多行代码块
⌘P|Parameter info (within method call arguments)|显示方法有哪些参数，类型是什么等信息
^J , Mid. button click|Quick documentation lookup|快速文档查询，可快速查看类、接口、方法等的说明信息，（我的电脑可直接按F1，功能相同），按⎋关闭说明信息
⇧F1|External Doc|
⌘+ mouse over code|Brief Info
⌘F1|Show descriptions of error or warning at caret
⌘N,^↩,^N|Generate code... (Getters, Setters, Constructors, hashCode/equals, toString)|生成getter and setters 和构造函数等
^O|Override methods|重写父类方法
^I|Implement methods|添加接口实现方法
⌘⌥T|Surround with... (if..else, try..catch, for, synchronized, etc.)|快速添加if..else,try..catch,for等代码块
⌘/|Comment/uncomment with line comment|单行注释
⌘⌥/|Comment/uncomment with block comment|多行注释
⌥↑|Select successively increasing code blocks|逐步增大选择代码块
⌥↓|Decrease current selection to previous state|逐步缩小当前选中代码块
^⇧Q|Context info
⌥↩|Show intention actions and quick-fixes|显示建议的代码和快速修复
⌘⌥L|Reformat code|代码格式化
^⌥O|Optimize imports|导包并删除多余的import
^⌥I|Auto-indent line(s)
⇥/⇧⇥|Indent/unindent selected lines
⌘X|Cut current line or selected block to clipboard|剪切文本到剪贴板
⌘C|Copy current line or selected block to clipboard|拷贝文本到剪贴板
⌘V|Paste from clipboard|从剪贴板粘贴文本
⌘⇧V|Paste from recent buffers...|从缓冲区(最近复制文本列表)粘贴文本
⌘D|Duplicate current line or selected block|重复当前行或者重复选择内容块
⌘⌫|Delete line at caret|删除整行
^⇧J|Smart line join|将下面一行内容和本行合并，加到本行后边
⌘↩|Smart line split|光标处换行，和直接↩区别是光标保持在当前位置
⇧↩|Start new line|开始新行，和直接↩区别是光标可以不在行末
⌘⇧U|Toggle case for word at caret or selected block|选中内容字符大小写切换
⌘⇧]/⌘⇧[|Select till code block end/start|我的测试结果为多个tab页切换
⌥⌦|Delete to word end|（⌥+Fn+⌫）删除光标到当前单词结束位置的内容
⌥⌫|Delete to word start|删除光标到当前单词开始位置的内容
⌘+/⌘-|Expand/collapse code block|展开/折叠当前方法代码块
⌘⇧+|Expand all|展开当前类所有方法代码块
⌘⇧-|Collapse all|折叠当前类所有方法代码块
⌘W|Close active editor tab|关闭当前编辑文件

### Search/Replace

快捷键 | 功能描述 | 中文描述
---|---|---
Double⇧|Search everywhere|全局搜索
⌘F|Find|搜索文本
⌘G|Find next|跳转到下一个搜索结果
⌘⇧G|Find previous|跳转到上一个搜索结果
⌘R|Replace|替换文本
⌘⇧F|Find in path|指定路径、文件类型等搜索
⌘⇧R|Replace in path|指定路径、文件类型等搜索并替换
⌘⇧S|Search structurally (Ultimate Edition only)
⌘⇧M|Replace structurally (Ultimate Edition only)

### Usage Search

快捷键 | 功能描述 | 中文描述
---|---|---
⌥F7/⌘F7|Find usages / Find usages in file |搜索对象在当前文件被引用的地方,搜索对象被引用的地方
⌘⇧F7|Highlight usages in file |
⌘⌥F7|Show usages | 

### Compile and Run

快捷键 | 功能描述 | 中文描述
---|---|---
⌘F9|Make project (compile modifed and dependent)|
⌘⇧F9|Compile selected  le, package or module|
^⌥R|Select con guration and run|
^⌥D|Select con guration and debug|
^R|Run|
^D|Debug|
^⇧R,^⇧D|Run context con guration from editor|

### Debugging

快捷键 | 功能描述 | 中文描述
---|---|---
F8|Step over|
F7|Step into|
⇧F7|Smart step into|
⇧F8|Step out|
⌥F9|Run to cursor|
⌥F8|Evaluate expression|
⌘⌥R|Resume program|
⌘F8|Toggle breakpoint|
⌘⇧F8|View breakpoints|

### Navigation

快捷键 | 功能描述 | 中文描述
---|---|---
⌘O|Go to class|
⌘⇧O|Go to file|
⌘⌥O|Go to symbol|
^←/^→|Go to next/previous editor tab|
F12|Go back to previous tool window|
⎋|Go to editor (from tool window)|
⇧⎋|Hide active or last active window|
⌘⇧F4|Close active run/messages/find/... tab|
⌘L|Go to line|
⌘E|Recent files popup|列出最近查看的文件列表
⌘⌥←/⌘⌥→|Navigate back/forward|
⌘⇧⌫|Navigate to last edit location|
⌥F1|Select current file or symbol in any view|
⌘B,⌘click|Go to declaration|
⌘⌥B|Go to implementation(s)|跳转到实现类
⌥space，⌘Y|Open quick de nition lookup|
^⇧B|Go to type declaration|
⌘U|Go to super-method/super-class|
^↑/^↓|Go to previous/next method|
⌘]/⌘[|Move to code block end/start|
⌘F12|File structure popup|
^H|Type hierarchy|
⌘⇧H|Method hierarchy|
^⌥H|Call hierarchy|
F2/⇧F2|Next/previous highlighted error|
F4/⌘↓|Edit source / View source|
⌥Home|Show navigation bar|
F3|Toggle bookmark|
⌥F3|Toggle bookmark with mnemonic|
^0...^9|Go to numbered bookmark|
⌘F3|Show bookmarks|

### Refactoring

快捷键 | 功能描述 | 中文描述
---|---|---
F5|Copy|
F6|Move|
⌘Delete|Safe Delete|
⇧F6|Rename|修改变量名
⌘F6|Change Signature|
⌘⌥N|Inline|
⌘⌥M|Extract Method|
⌘⌥V|Extract Variable|
⌘⌥F|Extract Field
⌘⌥C|Extract Constant
⌘⌥P|Extract Parameter

### VCS/Local History

快捷键 | 功能描述 | 中文描述
---|---|---
⌘K|Commit project to VCS|
⌘T|Update project from VCS|
⌥⇧C|View recent changes
^C|‘VCS’ quick popup


### Live Templates

快捷键 | 功能描述 | 中文描述
---|---|---
⌘⌥J|Surround with Live Template|
⌘J|Insert Live Template


### General

快捷键 | 功能描述 | 中文描述
---|---|---
⌘0...⌘9|Open corresponding tool window|
⌘S|Save all|
⌘⌥Y|Synchronize|
^⌘F|Toggle full screen mode|
⌘⇧F12|Toggle maximizing editor|
⌥⇧F|Add to Favorites|
⌥⇧I|Inspect current file with current profile|
^§，^`|Quick switch current scheme|
⌘,|Open Settings dialog|
⌘;|Open Project Structure dialog|
⇧⌘A|Find Action|
^⇥|Switch between tabs and tool window|


### Other

快捷键 | 功能描述 | 中文描述
---|---|---
⇧⌘E| |最近修改文件列表
⌘1-⌘9| |切换对应视图区域(各个视图对应不同数字)
⇧⌘8| |列编辑模式

### 其他
- 在project中，按下ctrl + shift + f(r) 即是在当前目前下递归查找或替换,搜索出来后，要全部替换，按下alt + a
- shift + cmd + n  查找文件
