<script setup lang="ts">
import { ref } from 'vue'
import Motto from './Motto.vue'
import ProfileCard from './ProfileCard.vue'
import TagCloud from './TagCloud.vue'

const isOpen = ref(false)

const toggleSidebar = () => {
  isOpen.value = !isOpen.value
}

defineExpose({ toggleSidebar, isOpen })
</script>

<template>
  <div class="sidebar-wrapper">
    <!-- 移动端汉堡菜单按钮 -->
    <button class="menu-toggle" @click="toggleSidebar" aria-label="打开菜单">
      <span class="menu-icon">☰</span>
    </button>
    
    <!-- 侧边栏 -->
    <aside
      class="sidebar"
      :class="{ 'sidebar-open': isOpen }"
    >
      <div class="sidebar-header">
        <button class="close-btn" @click="isOpen = false" aria-label="关闭菜单">
          ✕
        </button>
      </div>
      
      <div class="sidebar-content">
        <ProfileCard
          name="空杯学习者"
          bio="保持空杯心态，持续学习成长"
          avatar="/assets/images/avatar.jpg"
        />
        
        <Motto text="把心倒空，从容应对所有未知；收藏点滴美好，在岁月里持续成长。" />
        
        <TagCloud />
      </div>
    </aside>
    
    <!-- 遮罩层 -->
    <div
      v-if="isOpen"
      class="sidebar-overlay"
      @click="isOpen = false"
    />
  </div>
</template>

<style scoped>
.sidebar-wrapper {
  position: relative;
}

.menu-toggle {
  display: none;
  position: fixed;
  top: 72px;
  left: 16px;
  z-index: 50;
  width: 44px;
  height: 44px;
  border: none;
  border-radius: 50%;
  background: var(--color-card);
  box-shadow: var(--shadow-md);
  cursor: pointer;
  transition: all var(--transition-fast);
}

.menu-toggle:hover {
  background: var(--color-bg-alt);
  transform: scale(1.05);
}

.menu-icon {
  font-size: 1.25rem;
  color: var(--color-primary);
}

.sidebar {
  position: sticky;
  top: 72px;
  width: 280px;
  height: calc(100vh - 72px - 48px);
  overflow-y: auto;
  padding: 24px;
  background: transparent;
}

.sidebar-content {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.sidebar-header {
  display: none;
}

.close-btn {
  display: none;
}

.sidebar-overlay {
  display: none;
}

/* 响应式 - 移动端 */
@media (max-width: 1023px) {
  .menu-toggle {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .sidebar {
    position: fixed;
    top: 0;
    left: -320px;
    width: 300px;
    height: 100vh;
    z-index: 200;
    background: var(--color-card);
    padding: 20px;
    transition: left 0.3s ease;
    box-shadow: 4px 0 24px rgba(0, 0, 0, 0.15);
  }
  
  .sidebar-open {
    left: 0;
  }
  
  .sidebar-header {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 16px;
  }
  
  .close-btn {
    width: 36px;
    height: 36px;
    border: none;
    border-radius: 50%;
    background: var(--color-bg-alt);
    color: var(--color-text-secondary);
    font-size: 1rem;
    cursor: pointer;
    transition: all var(--transition-fast);
  }
  
  .close-btn:hover {
    background: var(--color-border);
    color: var(--color-text);
  }
  
  .sidebar-overlay {
    display: block;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.4);
    z-index: 150;
    backdrop-filter: blur(2px);
  }
}

/* 滚动条 */
.sidebar::-webkit-scrollbar {
  width: 4px;
}

.sidebar::-webkit-scrollbar-track {
  background: transparent;
}

.sidebar::-webkit-scrollbar-thumb {
  background: var(--color-border);
  border-radius: 4px;
}
</style>
