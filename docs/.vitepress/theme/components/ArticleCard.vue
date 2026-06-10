<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  title: string
  date: string
  excerpt: string
  cover?: string
  tags: string[]
  url: string
}>()

const formattedDate = computed(() => {
  try {
    const d = new Date(props.date)
    return `${d.getFullYear()}.${String(d.getMonth() + 1).padStart(2, '0')}.${String(d.getDate()).padStart(2, '0')}`
  } catch {
    return props.date
  }
})
</script>

<template>
  <article class="article-card">
    <a :href="url" class="card-link">
      <div v-if="cover" class="card-cover">
        <img :src="cover" :alt="title + ' 封面图'" loading="lazy" />
        <div class="cover-overlay"></div>
      </div>
      <div class="card-content">
        <div class="card-meta">
          <time class="card-date">{{ formattedDate }}</time>
          <div class="card-tags">
            <span
              v-for="tag in tags.slice(0, 3)"
              :key="tag"
              class="tag"
            >
              {{ tag }}
            </span>
          </div>
        </div>
        <h3 class="card-title">{{ title }}</h3>
        <p class="card-excerpt">{{ excerpt }}</p>
        <div class="card-footer">
          <span class="read-more">阅读全文 →</span>
        </div>
      </div>
    </a>
  </article>
</template>

<style scoped>
.article-card {
  background: var(--color-card);
  border-radius: var(--radius-lg);
  overflow: hidden;
  border: 1px solid var(--color-border);
  transition: all var(--transition-normal);
}

.article-card:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-4px);
  border-color: var(--color-accent-light);
}

.card-link {
  display: block;
  text-decoration: none;
  color: inherit;
}

.card-cover {
  position: relative;
  aspect-ratio: 16 / 9;
  overflow: hidden;
}

.card-cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.article-card:hover .card-cover img {
  transform: scale(1.05);
}

.cover-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(180deg, transparent 50%, rgba(0, 0, 0, 0.1) 100%);
  pointer-events: none;
}

.card-content {
  padding: 24px;
}

.card-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.card-date {
  font-size: 0.85rem;
  color: var(--color-text-light);
  font-weight: 500;
  letter-spacing: 0.02em;
}

.card-tags {
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
}

.tag {
  display: inline-block;
  background-color: var(--color-bg-alt);
  color: var(--color-text-secondary);
  font-size: 0.75rem;
  padding: 4px 10px;
  border-radius: var(--radius-full);
  border: 1px solid var(--color-border);
  transition: all var(--transition-fast);
}

.article-card:hover .tag {
  background-color: var(--color-primary);
  color: white;
  border-color: var(--color-primary);
}

.card-title {
  font-family: var(--font-display);
  font-size: 1.25rem;
  font-weight: 600;
  margin: 0 0 12px 0;
  color: var(--color-text);
  line-height: 1.4;
  transition: color var(--transition-fast);
}

.article-card:hover .card-title {
  color: var(--color-primary);
}

.card-excerpt {
  font-size: 0.95rem;
  line-height: 1.8;
  color: var(--color-text-secondary);
  margin: 0 0 16px 0;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.card-footer {
  display: flex;
  justify-content: flex-end;
}

.read-more {
  font-size: 0.9rem;
  color: var(--color-primary);
  font-weight: 500;
  transition: all var(--transition-fast);
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.article-card:hover .read-more {
  gap: 8px;
}

/* 响应式 */
@media (max-width: 768px) {
  .card-content {
    padding: 20px;
  }
  
  .card-title {
    font-size: 1.1rem;
  }
  
  .card-excerpt {
    font-size: 0.9rem;
    -webkit-line-clamp: 2;
  }
}
</style>
