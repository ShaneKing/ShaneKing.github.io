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

### get

| `kubectl get pods --all-namespaces` | 查看所有 pod |
| `kubectl get pods -n kube-system` | 查看 kube-system 空间下所有 pod |

### describe

| `kubectl describe -n kube-system pods/nginx` | 查看某 pod 啥情况 |
