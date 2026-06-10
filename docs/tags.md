---
title: 标签
---

<script setup lang="ts">
import { computed } from 'vue'
import { data as posts } from './.vitepress/posts.data'

const tags = computed(() => {
  const tagMap: Record<string, number> = {}
  
  posts.forEach((article: any) => {
    if (article.tags && Array.isArray(article.tags)) {
      article.tags.forEach((tag: string) => {
        tagMap[tag] = (tagMap[tag] || 0) + 1
      })
    }
  })

  return Object.entries(tagMap)
    .map(([name, count]) => ({ name, count }))
    .sort((a, b) => b.count - a.count)
})
</script>

<div class="tags-page">
  <header class="page-header">
    <h1 class="page-title">标签</h1>
    <p class="page-subtitle">浏览所有文章标签</p>
  </header>
  
  <div class="tags-list">
    <a
      v-for="tag in tags"
      :key="tag.name"
      :href="`/?tag=${encodeURIComponent(tag.name)}`"
      class="tag-item"
    >
      <span class="tag-name">{{ tag.name }}</span>
      <span class="tag-count">{{ tag.count }}</span>
    </a>
  </div>
  
  <div v-if="tags.length === 0" class="empty-state">
    <p class="empty-text">暂无标签</p>
  </div>
</div>

<style scoped>
.tags-page {
  max-width: 600px;
  margin: 0 auto;
}

.page-header {
  text-align: center;
  margin-bottom: 32px;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  margin: 0 0 8px 0;
  color: #2C3E50;
}

.page-subtitle {
  font-size: 16px;
  color: #8899AA;
  margin: 0;
}

.tags-list {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  justify-content: center;
}

.tag-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 20px;
  background: #FFFFFF;
  border: 1px solid #E8ECF1;
  border-radius: 25px;
  text-decoration: none;
  color: #2C3E50;
  transition: all 0.2s ease;
}

.tag-item:hover {
  border-color: #4A90D9;
  background: rgba(74, 144, 217, 0.05);
}

.tag-name {
  font-size: 15px;
}

.tag-count {
  font-size: 13px;
  color: #8899AA;
  background: #F7F9FC;
  padding: 2px 8px;
  border-radius: 10px;
}

.empty-state {
  text-align: center;
  padding: 60px 20px;
}

.empty-text {
  font-size: 16px;
  color: #8899AA;
}
</style>
