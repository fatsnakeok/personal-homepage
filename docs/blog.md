---
title: 博客
---

<script setup lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vitepress'
import { data as posts } from './.vitepress/posts.data'
import BlogList from './.vitepress/theme/components/BlogList.vue'

const route = useRoute()

const articles = computed(() => {
  const tagFilter = route.query?.tag as string | undefined
  
  if (tagFilter) {
    return posts.filter((article: any) => 
      article.tags?.includes(tagFilter)
    )
  }
  
  return posts
})
</script>

<div class="blog-page">
  <header class="blog-header">
    <h1 class="blog-title">博客</h1>
    <p class="blog-subtitle">记录成长，分享感悟</p>
  </header>
  
  <div v-if="route.query?.tag" class="tag-filter">
    <span class="filter-label">当前筛选：</span>
    <span class="filter-tag">{{ route.query.tag }}</span>
    <a href="/personal-homepage/blog" class="filter-clear">清除筛选</a>
  </div>
  
  <BlogList :articles="articles" />
  
  <div v-if="articles.length === 0" class="empty-state">
    <div class="empty-icon">📝</div>
    <p class="empty-text">暂无文章</p>
  </div>
</div>

<style scoped>
.blog-page {
  max-width: 100%;
  padding: 0 24px;
}

.blog-header {
  text-align: center;
  margin-bottom: 48px;
  padding: 48px 0;
  background: var(--color-bg-alt);
  margin-left: -24px;
  margin-right: -24px;
  border-radius: 0 0 var(--radius-lg) var(--radius-lg);
}

.blog-title {
  font-family: var(--font-display);
  font-size: 2.5rem;
  font-weight: 600;
  color: var(--color-text);
  margin: 0 0 12px 0;
}

.blog-subtitle {
  font-size: 1rem;
  color: var(--color-text-secondary);
  margin: 0;
}

.tag-filter {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 32px;
  padding: 16px 20px;
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  max-width: 800px;
  margin: 0 auto 32px auto;
}

.filter-label {
  font-size: 0.9rem;
  color: var(--color-text-secondary);
}

.filter-tag {
  display: inline-block;
  background: var(--color-primary);
  color: white;
  font-size: 0.85rem;
  padding: 4px 12px;
  border-radius: var(--radius-full);
}

.filter-clear {
  font-size: 0.9rem;
  color: var(--color-primary);
  margin-left: auto;
  text-decoration: none;
  transition: opacity var(--transition-fast);
}

.filter-clear:hover {
  opacity: 0.8;
}

.empty-state {
  text-align: center;
  padding: 80px 20px;
}

.empty-icon {
  font-size: 4rem;
  margin-bottom: 16px;
}

.empty-text {
  font-size: 1.125rem;
  color: var(--color-text-secondary);
}

@media (max-width: 768px) {
  .blog-page {
    padding: 0 16px;
  }
  
  .blog-header {
    margin-left: -16px;
    margin-right: -16px;
    padding: 32px 16px;
  }
  
  .blog-title {
    font-size: 2rem;
  }
}
</style>
