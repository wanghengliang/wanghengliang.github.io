---
layout: post
title: Tomcat的URL中存在特殊符号报404错误
date: 2017-11-24
categories: 
tags: Tomcat
---
Tomcat的URL中存在特殊符号报404错误

当url中存在 \ | { } 等字符串时，tomcat报404错误，后台报错信息如下：

```
信息: Error parsing HTTP request header
 Note: further occurrences of HTTP header parsing errors will be logged at DEBUG level.
java.lang.IllegalArgumentException: Invalid character found in the request target. The valid characters are defined in RFC 7230 and RFC 3986
        at org.apache.coyote.http11.InternalInputBuffer.parseRequestLine(InternalInputBuffer.java:192)
        at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1028)
        at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:637)
        at org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor.run(JIoEndpoint.java:318)
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
        at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
        at java.lang.Thread.run(Thread.java:745)
```

