---
layout: post
title: Java自定义注解
date: 2019-12-12
categories: 
tags: JAVA
---
Java自定义注解


### 简介

注解是Java 1.5引入的，可以提供代码的额外信息，目前正在被广泛应用。除了Java内置注解，我们也可以自定义注解。以下就是一个自定义注解的例子：

```
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface CustomAnnotation {
  String DEFAULT_MSG = "msg";

  String msg() default DEFAULT_MSG
}
```

自定义注解分析：
1.@interface关键字定义注解，
2.注解可以被其它注解修饰（如果我说注解，这也太绕了），最重要的就是元注解。
3.注解和接口类似，内部可以定义常量和方法。
4.注解定义的方法有一些限制：方法不能有参数；返回值只能是基本类型、字符串、Class、枚举、注解、及以上类型的数组；可以包含默认值。

### 元注解

元注解就是定义注解的注解，包含@Target、@Retention、@Inherited、@Documented这四种。

#### @Target

描述注解的使用目标，取值有：
ElementType.PACKAGE 注解作用于包
ElementType.TYPE 注解作用于类型（类，接口，注解，枚举）
ElementType.ANNOTATION_TYPE 注解作用于注解
ElementType.CONSTRUCTOR 注解作用于构造方法
ElementType.METHOD 注解作用于方法
ElementType.PARAMETER 注解作用于方法参数
ElementType.FIELD 注解作用于属性
ElementType.LOCAL_VARIABLE 注解作用于局部变量
默认可以作用于以上任何目标。

@Target注解源码如下：

```
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.ANNOTATION_TYPE})
public @interface Target {
    ElementType[] value();
}
```
注解方法返回值是ElementType[],ElementType枚举类型，枚举值就是@Target注解的可取值。方法名value，这样在使用注解时，可以不需要指定方法名。

#### @Retention

描述注解的生命周期，取值有：
RetentionPolicy.SOURCE 源码中保留，编译期可以处理
RetentionPolicy.CLASS Class文件中保留，Class加载时可以处理
RetentionPolicy.RUNTIME 运行时保留，运行中可以处理
默认RetentionPolicy.CLASS 值

@Retention注解源码如下：

```
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.ANNOTATION_TYPE})
public @interface Retention {
    RetentionPolicy value();
}
```
注解方法返回值是枚举类型RetentionPolicy，枚举值就是@Retention注解的可取值。


#### @Inherited

标记注解，使用@Inherited修饰的注解作用于一个类，则该注解将被用于该类的子类。
@Inherited注解源码如下：

```
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.ANNOTATION_TYPE})
public @interface Inherited {

}
```

#### @Documented

描述注解可以文档化，是一个标记注解。
在生成javadoc的时候，是不包含注释的，但是如果注解被@Documented修饰，则生成的文档就包含该注解。
@Documented注解源码如下：

```
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.ANNOTATION_TYPE})
public @interface Documented {

}
```

### 自定义注解实例

```
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface Msg {
  String DEFAULT_MSG = "msg";

  String msg() default DEFAULT_MSG;
}

@Msg(msg = "Test")
public class Test {
    
}

public class Main {
  public static void main(String[] args) {
      Test test = new Test();
      Class tClass = test.getClass();
      Msg msg = (Msg) tClass.getAnnotation(Msg.class);
      System.out.println(msg.msg());//运行结果：Test, 因为Msg注解的生命周期为RetentionPolicy.RUNTIME，所以可以运行时通过反射获取。
  }
}

```


