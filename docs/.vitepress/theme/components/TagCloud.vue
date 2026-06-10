<script setup lang="ts">
import { computed } from 'vue'
import { data as posts } from '../../posts.data'

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

<template>
  <div class="tag-cloud">
    <h3 class="tag-cloud-title">标签</h3>
    <div class="tag-list">
      <a
        v-for="tag in tags"
        :key="tag.name"
        :href="`/blog?tag=${encodeURIComponent(tag.name)}`"
        class="tag-item"
      >
        {{ tag.name }}
        <span class="tag-count">{{ tag.count }}</span>
      </a>
    </div>
  </div>
</template>

<style scoped>
.tag-cloud {
  padding: 20px;
  background: var(--color-card);
  border-radius: var(--radius-md);
  border: 1px solid var(--color-border);
  transition: all var(--transition-normal);
}

.tag-cloud:hover {
  box-shadow: var(--shadow-sm);
}

.tag-cloud-title {
  font-family: var(--font-display);
  font-size: 0.9rem;
  font-weight: 600;
  margin: 0 0 14px 0;
  color: var(--color-text-secondary);
  letter-spacing: 0.05em;
}

.tag-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.tag-item {
  display: inline-flex;
  align-items: center;
  background-color: var(--color-bg-alt);
  color: var(--color-text-secondary);
  font-size: 0.85rem;
  padding: 6px 12px;
  border-radius: var(--radius-full);
  text-decoration: none;
  border: 1px solid var(--color-border);
  transition: all var(--transition-fast);
}

.tag-item:hover {
  background-color: var(--color-primary);
  color: white;
  border-color: var(--color-primary);
  transform: translateY(-1px);
}

.tag-count {
  margin-left: 6px;
  font-size: 0.75rem;
  opacity: 0.7;
}
</style>
