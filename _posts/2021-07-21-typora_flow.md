---
layout: post
title: typora流程图
date: 2021-07-21
categories: 
tags: 
---
typora流程图



```flow
st=>start: 开始

cfg_reading_meter_list=>operation: 配置抄表册
cfg_reading_meter_list_order=>operation: 配置抄表顺序
create_reading_plan=>operation: 生成抄表计划
exec_reading_meter=>operation: APP端抄表
analyse_reading_meter=>operation: 抄表数据分析
cond1=>condition: 抄表数据是否异常？
sync_marketing_system=>operation: 同步至营销系统
data_check=>operation: 进入审核流程
cond2=>condition: 是否需要质检？
sumit_quality_check=>operation: 提交质检工单
quality_check=>subroutine: 进入质检子流程
sumit_check=>operation: 提交审核记录
e=>end: 结束

st->cfg_reading_meter_list->create_reading_plan
create_reading_plan->exec_reading_meter
exec_reading_meter->analyse_reading_meter->cond1

cond1(no)->sync_marketing_system->e
cond1(yes)->data_check->cond2

cond2(no)->sumit_check->e
cond2(yes)->quality_check->sumit_check(right)->sync_marketing_system
```

