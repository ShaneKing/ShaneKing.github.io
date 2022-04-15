---
layout: post
title: Mermaid 笔记
categories: [Try, Mermaid]
description: Mermaid 笔记
keywords: Mermaid
mermaid: true
---

作为一个文本化狂热分子，坚定的文本派，必须要码图，而不画图。

## graph 流程图
```mermaid
%% T=TOP,B=BOTTOM,L=LEFT,R=RIGHT,D=DOWN
%% TB,BT,LR,RL,TD,DT
%% [],(),(()),>],{}
%% -->,---,--text---,--text-->,-.-,-.->,-.text.-,-.text.->,===,==>,==text===,==text==>
graph LR
  subgraph Sg1
    id11[Rectangle11]
    Id12("圆角矩形节点12")
    iD13(("圆形节点13"))
  end
  subgraph Sg2
    ID21>"右向旗帜状节点21"]
    Id22{"菱形节点22"}
  end
  id00---id11
  id11--Description---ID21
  id11--Description-->Id22
  Id12==Description===ID21
  Id12=="描述"==>Id22
  ID21-."描述".-iD13
  Id22-.Description.->iD13
  iD13-->id99
```
```
%% T=TOP,B=BOTTOM,L=LEFT,R=RIGHT,D=DOWN
%% TB,BT,LR,RL,TD,DT
%% [],(),(()),>],{}
%% -->,---,--text---,--text-->,-.-,-.->,-.text.-,-.text.->,===,==>,==text===,==text==>
graph LR
  subgraph Sg1
    id11[Rectangle11]
    Id12("圆角矩形节点12")
    iD13(("圆形节点13"))
  end
  subgraph Sg2
    ID21>"右向旗帜状节点21"]
    Id22{"菱形节点22"}
  end
  id00---id11
  id11--Description---ID21
  id11--Description-->Id22
  Id12==Description===ID21
  Id12=="描述"==>Id22
  ID21-."描述".-iD13
  Id22-.Description.->iD13
  iD13-->id99
```

## sequence diagram 序列图
```mermaid
%% participant Use_participant_control_sequence
%% note [right of | left of][Actor]:Text
%% note over [Actor1, Actor2...]:Text
%%% loop Loop_text
%%% ... statements...
%%% end
%%%% alt Describing_text
%%%% ...statements...
%%%% else
%%%% ...statements...
%%%% end
%%%%% opt Describing_text
%%%%% ...statements...
%%%%% end
%% ->,-->,->>,-->>,-x,--x
sequenceDiagram
  participant B
  participant A
  participant C
  B->C:Must Description
  B-->A:Must Description
  loop Option Description
    A->>B:Must Description
  end
  alt Option Description
    C-->>C:Must Description
  else Option Description
    B-xB:Must Description
  end
  opt Option Description
    B--xC:Must Description
  end
  note left of B:Must Description
  note right of B:Must Description
  note over B,C:Must Description
  note left of C:Must Description
  note right of C:Must Description
```
```
%% participant Use_participant_control_sequence
%% note [right of | left of][Actor]:Text
%% note over [Actor1, Actor2...]:Text
%%% loop Loop_text
%%% ... statements...
%%% end
%%%% alt Describing_text
%%%% ...statements...
%%%% else
%%%% ...statements...
%%%% end
%%%%% opt Describing_text
%%%%% ...statements...
%%%%% end
%% ->,-->,->>,-->>,-x,--x
sequenceDiagram
  participant B
  participant A
  participant C
  B->C:Must Description
  B-->A:Must Description
  loop Option Description
    A->>B:Must Description
  end
  alt Option Description
    C-->>C:Must Description
  else Option Description
    B-xB:Must Description
  end
  opt Option Description
    B--xC:Must Description
  end
  note left of B:Must Description
  note right of B:Must Description
  note over B,C:Must Description
  note left of C:Must Description
  note right of C:Must Description
```

## gantt diagram 甘特图
```mermaid
gantt
%% title,dateFormat,section,Completed,Active,Future,crit,No_date__Default_from_previous_completed
%% comment_must_be_after_gantt_word
    dateFormat  YYYY-MM-DD
    title       Adding GANTT diagram functionality to mermaid
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)

    section A section
    Completed task            :done,    des1, 2014-01-06,2014-01-08
    Active task               :active,  des2, 2014-01-09, 3d
    Future task               :         des3, after des2, 5d
    Future task2              :         des4, after des3, 5d

    section Critical tasks
    Completed task in the critical line :crit, done, 2014-01-06,24h
    Implement parser and jison          :crit, done, after des1, 2d
    Create tests for parser             :crit, active, 3d
    Future task in critical line        :crit, 5d
    Create tests for renderer           :2d
    Add to mermaid                      :1d
    Functionality added                 :milestone, 2014-01-25, 0d

    section Documentation
    Describe gantt syntax               :active, a1, after des1, 3d
    Add gantt diagram to demo page      :after a1  , 20h
    Add another diagram to demo page    :doc1, after a1  , 48h

    section Last section
    Describe gantt syntax               :after doc1, 3d
    Add gantt diagram to demo page      :20h
    Add another diagram to demo page    :48h
```

## 参考
- 官方文档：<https://mermaid-js.github.io/mermaid/#/>
