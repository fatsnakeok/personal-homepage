---
title: Vue 3 组合式 API 入门
date: 2026-06-05
tags: [Vue, JavaScript, 前端]
excerpt: 介绍 Vue 3 的组合式 API，包括 setup、ref、reactive 等核心概念。
---

## 什么是组合式 API？

Vue 3 引入了组合式 API（Composition API），这是一种新的代码组织方式，可以更好地复用逻辑和组织代码。

## 核心概念

### setup 函数

`setup` 是组合式 API 的入口函数：

```typescript
import { ref } from 'vue'

export default {
  setup() {
    const count = ref(0)
    
    const increment = () => {
      count.value++
    }
    
    return {
      count,
      increment
    }
  }
}
```

### ref 和 reactive

- `ref` 用于创建响应式的基本类型数据
- `reactive` 用于创建响应式的对象

```typescript
import { ref, reactive } from 'vue'

const name = ref('Alice')
const user = reactive({
  name: 'Bob',
  age: 25
})
```

### computed

计算属性可以根据依赖自动更新：

```typescript
import { ref, computed } from 'vue'

const firstName = ref('John')
const lastName = ref('Doe')

const fullName = computed(() => {
  return `${firstName.value} ${lastName.value}`
})
```

## 总结

组合式 API 提供了更灵活的代码组织方式，特别适合处理复杂的逻辑复用场景。
