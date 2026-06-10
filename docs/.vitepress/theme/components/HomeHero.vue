<script setup lang="ts">
defineProps<{
  logo?: string
  siteName: string
  motto: string
  backgroundImage?: string
}>()
</script>

<template>
  <div
    class="hero-container"
    :style="{
      backgroundImage: backgroundImage
        ? `url(${backgroundImage})`
        : 'url(https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1920&q=80)'
    }"
  >
    <!-- 柔和渐变遮罩 -->
    <div class="hero-gradient"></div>
    
    <!-- 装饰性圆形 -->
    <div class="hero-decoration hero-decoration-1"></div>
    <div class="hero-decoration hero-decoration-2"></div>
    
    <!-- 主要内容 -->
    <div class="hero-content">
      <div class="hero-logo-wrapper">
        <div class="hero-logo-ring"></div>
        <img
          v-if="logo"
          :src="logo"
          :alt="siteName + ' Logo'"
          class="hero-logo"
        />
        <div v-else class="hero-logo-placeholder">
          <span class="logo-text">{{ siteName.charAt(0) }}</span>
        </div>
      </div>
      
      <h1 class="hero-title">{{ siteName }}</h1>
      
      <div class="hero-motto-wrapper">
        <div class="motto-decoration-left"></div>
        <p class="hero-motto">{{ motto }}</p>
        <div class="motto-decoration-right"></div>
      </div>
      
      <nav class="hero-nav">
        <a href="/" class="nav-link">
          <span class="nav-icon">⌂</span>
          <span class="nav-text">首页</span>
        </a>
        <a href="/blog" class="nav-link">
          <span class="nav-icon">☰</span>
          <span class="nav-text">博客</span>
        </a>
        <a href="/resume" class="nav-link">
          <span class="nav-icon">◎</span>
          <span class="nav-text">简历</span>
        </a>
        <a href="/about" class="nav-link">
          <span class="nav-icon">◉</span>
          <span class="nav-text">关于</span>
        </a>
      </nav>
    </div>
    
    <!-- 移动端底部导航 -->
    <nav class="mobile-nav">
      <a href="/" class="mobile-nav-link">
        <span class="mobile-nav-icon">⌂</span>
        <span class="mobile-nav-text">首页</span>
      </a>
      <a href="/blog" class="mobile-nav-link">
        <span class="mobile-nav-icon">☰</span>
        <span class="mobile-nav-text">博客</span>
      </a>
      <a href="/resume" class="mobile-nav-link">
        <span class="mobile-nav-icon">◎</span>
        <span class="mobile-nav-text">简历</span>
      </a>
      <a href="/about" class="mobile-nav-link">
        <span class="mobile-nav-icon">◉</span>
        <span class="mobile-nav-text">关于</span>
      </a>
    </nav>
  </div>
</template>

<style scoped>
.hero-container {
  position: relative;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  overflow: hidden;
}

/* 柔和渐变遮罩 */
.hero-gradient {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(37, 99, 235, 0.6) 0%, rgba(15, 23, 42, 0.7) 100%);
  z-index: 1;
}

/* 装饰性圆形 */
.hero-decoration {
  position: absolute;
  border-radius: 50%;
  border: 1px solid rgba(255, 255, 255, 0.1);
  z-index: 2;
}

.hero-decoration-1 {
  width: 400px;
  height: 400px;
  top: -100px;
  right: -100px;
  animation: float 20s ease-in-out infinite;
}

.hero-decoration-2 {
  width: 300px;
  height: 300px;
  bottom: -50px;
  left: -50px;
  animation: float 15s ease-in-out infinite reverse;
}

@keyframes float {
  0%, 100% { transform: translate(0, 0); }
  50% { transform: translate(20px, 20px); }
}

/* 主要内容 */
.hero-content {
  position: relative;
  z-index: 10;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  color: white;
  padding: 60px 24px;
  max-width: 800px;
  animation: fadeInUp 1s ease-out;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Logo 容器 */
.hero-logo-wrapper {
  position: relative;
  margin-bottom: 32px;
}

.hero-logo-ring {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 140px;
  height: 140px;
  transform: translate(-50%, -50%);
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  animation: pulse 3s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { 
    transform: translate(-50%, -50%) scale(1);
    opacity: 0.3;
  }
  50% { 
    transform: translate(-50%, -50%) scale(1.1);
    opacity: 0.5;
  }
}

.hero-logo {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid rgba(255, 255, 255, 0.9);
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
  position: relative;
  z-index: 1;
  animation: scaleIn 0.8s ease-out 0.2s both;
}

@keyframes scaleIn {
  from {
    opacity: 0;
    transform: scale(0.8);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.hero-logo-placeholder {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  backdrop-filter: blur(4px);
  border: 2px solid rgba(255, 255, 255, 0.3);
}

.logo-text {
  font-size: 48px;
  font-weight: 700;
  color: white;
  font-family: var(--font-display);
}

/* 标题 */
.hero-title {
  font-family: var(--font-display);
  font-size: 3rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  margin: 0 0 24px 0;
  text-shadow: 0 4px 16px rgba(0, 0, 0, 0.3);
  animation: fadeInUp 0.8s ease-out 0.4s both;
}

/* 座右铭 */
.hero-motto-wrapper {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 48px;
  animation: fadeInUp 0.8s ease-out 0.6s both;
}

.motto-decoration-left,
.motto-decoration-right {
  width: 60px;
  height: 1px;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.6), transparent);
}

.hero-motto {
  font-size: 1.125rem;
  font-weight: 400;
  line-height: 1.8;
  margin: 0;
  max-width: 500px;
  opacity: 0.95;
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
}

/* 导航按钮 */
.hero-nav {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
  justify-content: center;
  animation: fadeInUp 0.8s ease-out 0.8s both;
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 14px 28px;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 40px;
  color: white;
  text-decoration: none;
  font-size: 1rem;
  font-weight: 500;
  transition: all 0.3s ease;
}

.nav-link:hover {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.4);
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
}

.nav-icon {
  font-size: 1.125rem;
}

/* 移动端导航 */
.mobile-nav {
  display: none;
}

@media (max-width: 768px) {
  .hero-content {
    padding: 40px 20px 120px;
  }
  
  .hero-title {
    font-size: 2rem;
    letter-spacing: 0.05em;
  }
  
  .hero-motto {
    font-size: 1rem;
  }
  
  .hero-motto-wrapper {
    flex-direction: column;
    gap: 12px;
  }
  
  .motto-decoration-left,
  .motto-decoration-right {
    width: 40px;
  }
  
  .hero-nav {
    display: none;
  }
  
  .mobile-nav {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 100;
    display: flex;
    background: rgba(15, 23, 42, 0.95);
    backdrop-filter: blur(12px);
    padding: 8px 0;
    padding-bottom: calc(8px + env(safe-area-inset-bottom));
    border-top: 1px solid rgba(255, 255, 255, 0.1);
  }
  
  .mobile-nav-link {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 4px;
    padding: 10px 8px;
    color: rgba(255, 255, 255, 0.7);
    text-decoration: none;
    font-size: 0.7rem;
    transition: color 0.2s ease;
  }
  
  .mobile-nav-link:hover,
  .mobile-nav-link.active {
    color: white;
  }
  
  .mobile-nav-icon {
    font-size: 1.25rem;
  }
}
</style>
