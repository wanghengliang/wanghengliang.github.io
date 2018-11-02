---
layout: post
title: jekyll整合MathjaxJS插入数学公式
date: 2018-10-31
categories: 技术开发
tags: jekyll mathjaxJs
---
jekyll整合MathjaxJS插入数学公式

### MathJax简介

MathJax是一款运行在浏览器中的开源的数学符号渲染引擎，使用MathJax可以方便的在浏览器中显示数学公式，不需要使用图片。目前，MathJax可以解析Latex、MathML和ASCIIMathML的标记语言。(Wiki)

先给几个效果看看

$$ x^{y^z}=(1+{\rm e}^x)^{-2xy^w} $$

$$ \sideset{^1_2}{^3_4}\bigotimes $$

$$ f(x,y,z) = 3y^2z \left( 3+\frac{7x+5}{1+y^2} \right) $$

$$
f\left(
   \left[ 
     \frac{
       1+\left\{x,y\right\}
     }{
       \left(
          \frac{x}{y}+\frac{y}{x}
       \right)
       \left(u+1\right)
     }+\sqrt{a} \quad
   \right]^{3/2}
\right)
$$

### 引入MathJax

在页脚处，引入官方的cdn,但这个js还是会调用到 cdn.mathjax.org 里的一些配置js文件，我们最好在head内加一个dns-prefetch，用于网页加速

```
//head中引入
<link rel="dns-prefetch" href="//cdn.mathjax.org" />

//页脚处引入
<script src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
```

官方cdn的js在国内访问慢，所以我们一般引入的是国内的公共资源cdn提供的js

```
//head中引入
<link rel="dns-prefetch" href="//cdn.bootcss.com" />

//页脚处引入
<script src="//cdn.bootcss.com/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
```

jekyll中找到自己的模板中相应位置添加以上代码即可。

### MathJax的config说明

其config包括外联config和内联config。

#### 外联config说明

我们引入MathJax，发现链接后面多了个?config=TeX-AMS-MML_HTMLorMML这个多出来的东西其实是告诉MathJax，我们要用到的叫TeX-AMS-MML_HTMLorMML.js的配置文件，其用来控制显示数学公式的HTMl显示输出。

#### 内联config说明

与此同时，官方其实还提供了一个能让我们内联一个配置选项的功能，很简单就是使用<script></script>标签对，但注意的是需要声明类型type="text/x-mathjax-config"。要想让这个内联配置生效就得放在MathJax.js之前，例子如下

```
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
});
</script>
<script src="//cdn.bootcss.com/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
```

其中MathJax.Hub.Config()里的配置选项很多，可以查看官网说明，这里不详细说明，只给出我用的，并给出一些说明

```
<script type="text/x-mathjax-config">
var mathId = document.getElementById("post-container");//选择公式识别范围
MathJax.Hub.Config({
    showProcessingMessages: false,//关闭js加载过程信息
    messageStyle: "none",//不显示信息
    extensions: ["tex2jax.js"],
    jax: ["input/TeX", "output/HTML-CSS"],
    tex2jax: {
        inlineMath:  [ ["$", "$"] ],//行内公式选择符
        displayMath: [ ["$$","$$"] ],//段内公式选择符
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre','code','a'],//避开某些标签
        ignoreClass:"comment-content" //避开含该Class的标签
    },
    "HTML-CSS": {
        availableFonts: ["STIX","TeX"],//可选字体
        showMathMenu: false //关闭右击菜单显示
    }
});
MathJax.Hub.Queue(["Typeset",MathJax.Hub,mathId]);//选择公式识别范围
</script>
```

#### 数学公式识别
通过tex2jax中的inlineMath和displayMath进行数学公式识别，

其中inlineMath识别的单行内的数学公式,我们可以通过$ ... $或\\( ... \\)去识别这种数学公式，

displayMath就是识别整个独立段落的数学公式并且居中显示,我们可以通过$$ ... $$或\\[ ... \\]去识别这种数学公式

#### 约束识别范围
默认情况下,MathJax.Hub.Queue(["Typeset",MathJax.Hub])是对整个DOM树进行识别的，我们要约束识别范围，官方文档告诉我们MathJax.Hub.Queue的第三个参数就是识别范围，上面的代码就是告诉我们要在id为post-container的标签内去做公式识别

#### 避开特殊标签和Class
其中skipTags用来避开一些特殊的标签内的内容，这里避开是script,noscript,style,textarea,pre,code,a标签

ignoreClass用来避开标签内声明的CSS Class属性，这里避开的是带有class="comment-content"的标签，如果我们不想让mathjax识别评论里的公式就可以用ignoreClass，如果有多个Class需要避开，我们可以通过 `|` 来区分，写成`ignoreClass: "class1|class2"`就可以了

### 公式使用

#### 1. 如果插入公式


#### 2. 如何输入上下标

#### 3. 如何输入括号和分隔符

#### 4. 如何输入分数

#### 5. 如何输入开方

#### 6. 如何输入省略号

#### 7. 如何输入矢量

#### 8. 如何输入积分

#### 9.如何输入极限运算

#### 10.如何输入累加、累乘运算

#### 11.如何输入希腊字母

#### 12.大括号和行标的使用



### 参考内容
本文内容参考一下网页内容

[前端整合MathjaxJS的配置笔记](https://www.linpx.com/p/front-end-integration-mathjaxjs-configuration.html)

[Markdown公式编辑学习笔记](https://www.cnblogs.com/q735613050/p/7253073.html)

[Markdown公式（二）](http://www.cnblogs.com/q735613050/p/7474449.html)
