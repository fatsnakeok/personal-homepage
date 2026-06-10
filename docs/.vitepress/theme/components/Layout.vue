<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useData } from 'vitepress'
import NavBar from './NavBar.vue'
import Sidebar from './Sidebar.vue'

const { page } = useData()
const sidebarRef = ref<InstanceType<typeof Sidebar> | null>(null)

const handleToggleSidebar = () => {
  sidebarRef.value?.toggleSidebar()
}

const handleOverlayClick = () => {
  if (sidebarRef.value?.isOpen) {
    sidebarRef.value.toggleSidebar()
  }
}

const handleClickOutside = (e: MouseEvent) => {
  const target = e.target as HTMLElement
  if (!target.closest('.sidebar') && !target.closest('.navbar-toggle')) {
    handleOverlayClick()
  }
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside)
})
</script>

<template>
  <div class="custom-layout">
    <NavBar @toggle-sidebar="handleToggleSidebar" />
    
    <main class="main-content">
      <Sidebar ref="sidebarRef" />
      
      <div class="content-area">
        <slot />
      </div>
    </main>
    
    <footer class="page-footer">
      <p class="footer-text">{{ page.themeConfig?.footer?.message }}</p>
    </footer>
  </div>
</template>

<style scoped>
.custom-layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.main-content {
  display: flex;
  max-width: 1400px;
  margin: 0 auto;
  padding-top: 56px;
  width: 100%;
}

.content-area {
  flex: 1;
  padding: 24px 20px;
  max-width: calc(100% - 260px);
}

.page-footer {
  padding: 24px 20px;
  text-align: center;
  border-top: 1px solid #E8ECF1;
  margin-top: auto;
}

.footer-text {
  font-size: 14px;
  color: #8899AA;
  margin: 0;
}

@media (max-width: 1023px) {
  .content-area {
    max-width: 100%;
  }
}

@media (max-width: 767px) {
  .content-area {
    padding: 16px 16px;
  }
}
</style>
