---
layout: post
title: 设计基础：命名
categories: Thinking
description: 设计基础：命名
keywords: Design, Naming
---


设计基础：命名

## 缩写

### 操作类

| `add` | | 新增关联关系 |
| `crt` | `create` | 创建实体 |
| `del` | `delete` | 逻辑删除实体 |
| `rmv` | `remove` | 逻辑移除关联关系 |
| `mod` | `modify` | 改 |
| `lst` | `list` | 查 |
| `ivd` | `invalid` | 失效 |
| `one` | | 根据id取记录 |
| `uld` | `upload` | |
| `dld` | `download` | |
| `bch` | `batch` | 批量操作 |
| `top` | | 最上/最前 |
| `bot` | `bottom` | 最下/最后 |

### 状态类

| `bgn` | `begin` | 开始 |
| `end` | | 结束。配合开始形成拉链（合同开始结束时间，续签等），默认9999-99-99 |
| `len` | `length` | 长度。配合开始用于分页，查询时可以通过开始及长度取数 |

### 权限类

| `canRead` | | 比如活动已到期，但是依然可以看活动内容 |
| `canWrite` | | 增删改 |
| `canExec` | | 可用，同with option授权 |


## 审计

### 操作类

| `addUserId` | | |
| `addDateTime` | | |
| `crtUserId` | | |
| `crtDateTime` | | |
| `deleted` | | `Y`/`N`(default) |
| `delDateTime` | | |
| `delUserId` | | |
| `removed` | | `Y`/`N`(default) |
| `rmvUserId` | | |
| `rmvDateTime` | | |
| `modUserId` | | |
| `modDateTime` | | |
| `invalid` | | `Y`/`N`(default) |
| `ivdUserId` | | |
| `ivdDateTime` | | |


## 数据库
不要有保留字段：N年后谁知道保留字段到底有木有在使用？即使使用了，业务含义也很难理解

### 附属字段

| `refType` | | 用于引用（比如文件信息表，记录文件来自哪个模块） |
| `refId` | | 用于引用（扩展ID） |

### 扩展字段

| `extJsonStr` | | Object，所有属性可以为null，非null必须建字段；所有属性不用于表关联 |

### 树形字段

| `nodeName` | |  |
| `nodePath` | | /root/xxx/yyy/zzz/parentId/id/ |
| `nodeType` | | R(oot), B(ranch) or L(eaf) |
| `parentId` | | |


## 浏览器

### 避免

| `&` | | |
| `=` | | |
| `#` | | |


## 后缀

### Java

| `*Helper` | | 帮助类，强业务相关，通常`@Component`注解 |
| `*Utils` | | 工具类，非业务相关，里面全是静态方法 |
| `*Wrapper` | | 包裹类，主要用于包裹第三方类，便于以后替换第三方包，以及异常统一处理等 |
