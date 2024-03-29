---
layout: post
title: 事务场景下：缓存数据一致性思考
categories: [Thinking, Cache]
description: 事务场景下：缓存数据一致性思考
keywords: cache, consistency, transaction
---

场景生需求，需求生设计，设计生领域，领域生万物

## 问题
### 非事务场景
大部分使用缓存的场景都是非事务的，甚至都不要求数据强一致性。比如各种限时限量抢购：看着有货，创建订单报没有货，返回去查，还能查到有货。PS：机票超卖是故意，与缓存无关。

非事务场景下，缓存与数据源数据一致性，`仅需数据源操作成功后，清理掉相应的缓存即可`。如下图：

![](/images/posts/2021/05/cache-data-consistency-1.png)
 
### 事务场景
当数据源有了回到过去的能力后，上面的方案就不能满足了。

![](/images/posts/2021/05/cache-data-consistency-2.png)

除上图场景外，还有更多事务交织的场景。

## 思考
假设：单机系统使用的是单机缓存或分布式缓存，分布式系统使用的是分布式缓存。分布式系统使用单机缓存不在考虑范围之内。

![](/images/posts/2021/05/cache-data-consistency-3.png)

## 解决
### 缓存接口修改
```java
public interface CacheHelper {
  ThreadLocal<Map<String, List<String>>> DEL_MAP = ThreadLocal.withInitial(Map0::newHashMap);//by transaction

  default Boolean del(boolean withoutTransactional, @NonNull String key) {
    if (!withoutTransactional && inTransactional()) {
      //need record operation key in transactional
      DEL_MAP.get().computeIfAbsent(currentTransactionName(), k -> List0.newArrayList()).add(key);
    }
    return getCache().del(key);
  }

  default void set(@NonNull String key, @NonNull String value) {
    boolean contain = false;
    if (inTransactional()) {
      //in transactional, if key in record operation key list, can not cache
      contain = DEL_MAP.get().computeIfAbsent(currentTransactionName(), k -> List0.newArrayList()).contains(key);
    }
    if (!contain) {
      getCache().set(key, value);
    }
  }
}
```

### 事务切面处理
```java
@Aspect
@Component
@Order(CacheTransactionAspect.ORDER)//@EnableTransactionManagement(order = <this)
public class CacheTransactionAspect {
  public static final int ORDER = 500000;

  @Autowired
  private ApplicationEventPublisher applicationEventPublisher;

  @Pointcut("execution(@org.springframework.transaction.annotation.Transactional * *..*.*(..))")
  private void pointcut() {
  }

  @Around("pointcut() && @annotation(transactional)")
  public Object around(ProceedingJoinPoint pjp, Transactional transactional) throws Throwable {
    applicationEventPublisher.publishEvent(new CacheTransactionEventObject().setReadOnly(transactional.readOnly())
      .setCurrentTransactionReadOnly(TransactionSynchronizationManager.isCurrentTransactionReadOnly())
      .setTransactionName(TransactionSynchronizationManager.getCurrentTransactionName()));
    return pjp.proceed();
  }
}
```

### 事务监听处理
```java
@Component
public class CacheTransactionEventListener {
  @Autowired
  private CacheHelper cacheHeloper;

  @TransactionalEventListener(phase = TransactionPhase.AFTER_COMPLETION)
  public void afterCompletion(PayloadApplicationEvent<CacheTransactionEventObject> event) {
    String transactionName = event.getPayload().getTransactionName();
    if (!String0.isNullOrEmpty(transactionName)) {
      if (cache != null) {
        //need remove other thread re-cache
        for (String key : CacheHelper.DEL_MAP.get().computeIfAbsent(transactionName, k -> List0.newArrayList())) {
          cacheHeloper.del(true, key);
        }
      }
      CacheHelper.DEL_MAP.get().remove(transactionName);
    }
  }
}
```

## 回顾
非事务场景下：`仅需数据源操作成功后，清理掉相应的缓存即可`

事务场景下：`除本事务不应缓存已清理过的key之外，在事务完成后，已清理过一遍的key，还需再清理一遍`
