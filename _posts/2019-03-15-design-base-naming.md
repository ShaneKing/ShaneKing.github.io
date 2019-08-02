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

| `add` | | 增 |
| `rmv` | `remove` | 删 |
| `mod` | `modify` | 改 |
| `lst` | `list` | 查 |
| `ivd` | `invalid` | 失效 |
| `one` | | 根据id取记录 |
| `upld` | `upload` | |
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
| `addTime` | | |
| `modUserId` | | |
| `modTime` | | |
| `ivdStatus` | | `Y`/`N`(default) |
| `ivdUserId` | | |
| `ivdTime` | | |
| `rmvStatus` | | `Y`/`N`(default) |
| `rmvUserId` | | |
| `rmvTime` | | |


## 数据库
不要有保留字段：N年后谁知道保留字段到底有木有在使用？即使使用了，业务含义也很难理解

### 附属字段

| `refType` | | 用于引用（比如文件信息表，记录文件来自哪个模块） |
| `refId` | | 用于引用（扩展ID） |

### 扩展字段

| `extJsonStr` | | Object，所有属性可以为null，非null必须建字段；所有属性不用于表关联 |

### 树形字段

| `parentId` | | |
| `treePath` | | rootId -> grandId -> parentId |


## 浏览器

### 避免

| `&` | | |
| `=` | | |
| `#` | | |
