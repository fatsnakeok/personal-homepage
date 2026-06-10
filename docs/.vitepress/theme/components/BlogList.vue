<script setup lang="ts">
import { computed } from 'vue'
import ArticleCard from './ArticleCard.vue'

interface Article {
  title: string
  date: string
  excerpt: string
  cover?: string
  tags: string[]
  url: string
}

const props = defineProps<{
  articles: Article[]
}>()

const displayArticles = computed(() => props.articles)
</script>

<template>
  <div class="blog-list-container">
    <ArticleCard
      v-for="article in displayArticles"
      :key="article.url"
      :title="article.title"
      :date="article.date"
      :excerpt="article.excerpt"
      :cover="article.cover"
      :tags="article.tags"
      :url="article.url"
    />
  </div>
</template>

<style scoped>
.blog-list-container {
  display: flex;
  flex-direction: column;
  gap: 20px;
  max-width: 800px;
  margin: 0 auto;
  padding: 24px 0;
}

@media (max-width: 768px) {
  .blog-list-container {
    padding: 16px;
  }
}
</style>
