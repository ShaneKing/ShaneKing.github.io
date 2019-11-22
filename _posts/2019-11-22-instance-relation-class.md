---
layout: post
title: Java 判断对象是否为某类型实例
categories: Java
description: Java 判断对象是否为某类型实例
keywords: Java, instanceOf, isInstance, isAssignableFrom
---


TL;DR;

## 假设
```java
public class Extend1 {
}

public class Extend2 extends Extend1 {
}

public class Extend3 extends Extend2 {
}
```

## 测试
### instanceOf

| ⬇️ instanceOf ➡️ | Extend3 | Extend2 | Extend1 |
| :-------------- | :------ | :------ | :------ |
| extend3         | true    | true    | true    |
| extend2         | false   | true    | true    |
| extend1         | false   | false   | true    |

### isInstance
在 IntelliJ IDEA 中 `Extend2.class.isInstance(extend3)` 会被格式化为 `extend3 instanceOf Extend2`

| ⬇️ isInstance ➡️ | extend3 | extend2 | extend1 |
| :-------------- | :------ | :------ | :------ |
| Extend3.class   | true    | false   | false   |
| Extend2.class   | true    | true    | false   |
| Extend1.class   | true    | true    | true    |

### isAssignableFrom

| ⬇️ isAssignableFrom ➡️ | Extend3.class | Extend2.class | Extend1.class |
| :-------------------- | :------------ | :------------ | :------------ |
| Extend3.class         | true          | false         | false         |
| Extend2.class         | true          | true          | false         |
| Extend1.class         | true          | true          | true          |

## 接口假设
```java
public interface Implement1 {
}

public interface Implement2 extends Implement1 {
}

public class Implement3 implements Implement2 {
}

public class Implement4 extends Implement3 {
}
```
## 接口测试
### instanceOf

| ⬇️ instanceOf ➡️ | Implement4 | Implement3 | Implement2 | Implement1 |
| :-------------- | :--------- | :--------- | :--------- | :--------- |
| implement4      | true       | true       | true       | true       |
| implement3      | false      | true       | true       | true       |

### isAssignableFrom

| ⬇️ isAssignableFrom ➡️ | Implement4.class | Implement3.class | Implement2.class | Implement1.class |
| :-------------------- | :--------------- | :--------------- | :--------------- | :--------------- |
| Implement4.class      | true             | false            | false            | false            |
| Implement3.class      | true             | true             | false            | false            |
| Implement2.class      | true             | true             | true             | false            |
| Implement1.class      | true             | true             | true             | true             |

## 源码
<https://github.com/ShaneKing/org.shaneking.demo#instance-relation-class-demo>
