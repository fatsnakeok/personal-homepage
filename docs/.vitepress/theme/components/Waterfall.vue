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
  <div class="waterfall-container">
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
.waterfall-container {
  column-count: 1;
  column-gap: 16px;
}

@media (min-width: 768px) {
  .waterfall-container {
    column-count: 2;
    column-gap: 16px;
  }
}

@media (min-width: 1024px) {
  .waterfall-container {
    column-count: 3;
    column-gap: 20px;
  }
}
</style>
