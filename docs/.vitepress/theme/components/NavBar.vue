<script setup lang="ts">
import { ref } from 'vue'

const emit = defineEmits<{
  toggleSidebar: []
}>()

const isScrolled = ref(false)

if (typeof window !== 'undefined') {
  window.addEventListener('scroll', () => {
    isScrolled.value = window.scrollY > 10
  })
}

const handleToggle = () => {
  emit('toggleSidebar')
}
</script>

<template>
  <nav class="navbar" :class="{ 'navbar-scrolled': isScrolled }">
    <div class="navbar-content">
      <a href="/" class="navbar-brand">
        <span class="brand-icon">📝</span>
        <span class="brand-text">空杯成长笔记</span>
      </a>
      
      <div class="navbar-links">
        <a href="/" class="nav-link">首页</a>
        <a href="/blog" class="nav-link">博客</a>
        <a href="/resume" class="nav-link">简历</a>
        <a href="/about" class="nav-link">关于</a>
      </div>

      <button class="navbar-toggle" @click="handleToggle">
        <span class="toggle-bar"></span>
        <span class="toggle-bar"></span>
        <span class="toggle-bar"></span>
      </button>
    </div>
  </nav>
</template>

<style scoped>
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  background: #FFFFFF;
  border-bottom: 1px solid #E8ECF1;
  transition: box-shadow 0.2s ease;
}

.navbar-scrolled {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

.navbar-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 56px;
}

.navbar-brand {
  display: flex;
  align-items: center;
  text-decoration: none;
  color: #2C3E50;
}

.brand-icon {
  font-size: 20px;
  margin-right: 8px;
}

.brand-text {
  font-size: 18px;
  font-weight: 600;
}

.navbar-links {
  display: flex;
  gap: 24px;
}

.nav-link {
  font-size: 15px;
  color: #2C3E50;
  text-decoration: none;
  padding: 8px 0;
  border-bottom: 2px solid transparent;
  transition: border-color 0.2s ease;
}

.nav-link:hover {
  border-color: #4A90D9;
}

.navbar-toggle {
  display: none;
  flex-direction: column;
  gap: 5px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 8px;
}

.toggle-bar {
  width: 24px;
  height: 2px;
  background: #2C3E50;
  border-radius: 1px;
}

@media (max-width: 767px) {
  .navbar-links {
    display: none;
  }

  .navbar-toggle {
    display: flex;
  }
}
</style>
