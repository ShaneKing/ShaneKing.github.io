---
layout: post
title: 常用的 Kubernates 命令
categories: k8s
description: 常用的 Kubernates 命令
keywords: Kubernetes, k8s
---


持续更新～

## kubectl
<https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands>

### GETTING STARTED
#### get

| `kubectl get pod -A -o wide` | 查看所有 pod |
| `kubectl get pods -n <namespace-name>` | 查看 kube-system 空间下所有 pod |

### WORKING WITH APPS
#### describe

| `kubectl describe -n <namespace-name> pods <pod-name>` | 查看详情 |

#### exec

| `kubectl exec -n <namespace-name> -ti <pod-name> /bin/bash` | 进入终端 |

#### logs

| `kubectl logs -n <namespace-name> <pod-name> ` | 查看日志 |
