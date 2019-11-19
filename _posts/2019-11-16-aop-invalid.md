---
layout: post
title: 偶遇 AOP 失效之类内调用
categories: Ouyu
description: 偶遇 AOP 失效之类内调用
keywords: Spring, AOP
---


不遇不知道，一遇吓一跳。

## 起因
利用 AOP 切面，记录审计日志。

## 经过
样例代码如：<https://github.com/ShaneKing/org.shaneking.spring.demo.aop.invalid>
### 定义注解
```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface AopInvalidAnno {
}
```
### 实现切面
```java
@Aspect
@Component
@Slf4j
public class AopInvalidAspect {

  @Pointcut("execution(@org.shaneking.spring.demo.aop.invalid.annotation.AopInvalidAnno * *..*.*(..))")
  private void pointcut() {
  }

  @Around("pointcut() && @annotation(aopInvalidAnno)")
  public Object aroundCurrentLimiter(ProceedingJoinPoint joinPoint, AopInvalidAnno aopInvalidAnno) throws Throwable {
    log.info(joinPoint.getSignature().getName() + System.currentTimeMillis());
    Object rtn = joinPoint.proceed();
    log.info(joinPoint.getSignature().getName() + System.currentTimeMillis());
    return rtn;
  }
}
```
### 使用注解
```java
@Component
public class AopInvalidComponent {

  @AopInvalidAnno
  public void aopValid() {
    System.out.println(this.getClass().getName());
  }

  public void aopInvalid() {
    aopValid();
  }
}
```
### 方法调用
```java
public class AopInvalidComponentTest extends SKUnit {

  @Autowired
  private AopInvalidComponent aopInvalidComponent;

  @Test
  public void aopValid() {
    aopInvalidComponent.aopValid();// 2 line log and  1 line system out
  }

  @Test
  public void aopInvalid() {
    aopInvalidComponent.aopInvalid();// just 1 line system out
  }
}
```

## 结果
结果如测试案例注释，`aopInvalid()`方法调用时，并未打印审计日志。

## 原因
类内调用。当在被代理对象的方法中调用被代理对象的其他方法时，其实是没有用代理调用，是用了被代理对象本身调用的。

## 解决
### 配置：暴露代理对象
```java
@Configuration
@EnableAspectJAutoProxy(exposeProxy = true)
@SpringBootApplication
public class DemoApplication {

  public static void main(String[] args) {
    SpringApplication.run(DemoApplication.class, args);
  }

}
```
### 调用
```java
@Component
public class AopInvalidComponent {

  @AopInvalidAnno
  public void aopValid() {
    System.out.println(this.getClass().getName());
  }

  public void aopInvalid() {
    aopValid();
  }

  public void aopProxy() {
    ((AopInvalidComponent) AopContext.currentProxy()).aopValid();
  }
}
```
### 验证
```java
public class AopInvalidComponentTest extends SKUnit {

  @Autowired
  private AopInvalidComponent aopInvalidComponent;

  @Test
  public void aopValid() {
    aopInvalidComponent.aopValid();// 2 line log and  1 line system out
  }

  @Test
  public void aopInvalid() {
    aopInvalidComponent.aopInvalid();// just 1 line system out
  }

  @Test
  public void aopProxy() {
    aopInvalidComponent.aopProxy();// 2 line log and  1 line system out
  }
}
```

## 参考

<https://blog.csdn.net/u012373815/article/details/77345655>
