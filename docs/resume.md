---
title: 个人简历
---

<script setup lang="ts">
</script>

<div class="resume-page">
  <a href="/resume.pdf" download="个人简历.pdf" class="download-btn">
    <span class="btn-icon">⬇</span>
    <span class="btn-text">下载 PDF</span>
  </a>

  <header class="resume-header">
    <div class="header-decoration"></div>
    <h1 class="resume-name">空杯学习者</h1>
    <p class="resume-title">全栈开发工程师</p>
    <div class="resume-contact">
      <span class="contact-item">📧 email@example.com</span>
      <span class="contact-item">📱 138-xxxx-xxxx</span>
      <span class="contact-item">🔗 github.com/username</span>
    </div>
  </header>

  <section class="resume-section">
    <h2 class="section-title">
      <span class="section-icon">🎓</span>
      教育经历
    </h2>
    <div class="section-content">
      <div class="timeline-item">
        <div class="timeline-dot"></div>
        <div class="timeline-content">
          <div class="item-header">
            <h3 class="item-title">XX 大学</h3>
            <span class="item-date">2015 - 2019</span>
          </div>
          <p class="item-subtitle">计算机科学与技术 · 学士</p>
        </div>
      </div>
    </div>
  </section>

  <section class="resume-section">
    <h2 class="section-title">
      <span class="section-icon">💼</span>
      工作经历
    </h2>
    <div class="section-content">
      <div class="timeline-item">
        <div class="timeline-dot"></div>
        <div class="timeline-content">
          <div class="item-header">
            <h3 class="item-title">XX 公司</h3>
            <span class="item-date">2022 - 至今</span>
          </div>
          <p class="item-subtitle">高级前端开发工程师</p>
          <ul class="item-descriptions">
            <li>负责公司核心产品的前端架构设计与开发</li>
            <li>推动团队采用 Vue 3 + TypeScript 技术栈</li>
            <li>优化页面性能，提升用户体验</li>
          </ul>
        </div>
      </div>
      <div class="timeline-item">
        <div class="timeline-dot"></div>
        <div class="timeline-content">
          <div class="item-header">
            <h3 class="item-title">XX 公司</h3>
            <span class="item-date">2019 - 2022</span>
          </div>
          <p class="item-subtitle">前端开发工程师</p>
          <ul class="item-descriptions">
            <li>参与多个项目的开发与维护</li>
            <li>负责前端页面切图与交互实现</li>
            <li>协助后端完成接口对接</li>
          </ul>
        </div>
      </div>
    </div>
  </section>

  <section class="resume-section">
    <h2 class="section-title">
      <span class="section-icon">🛠️</span>
      技能特长
    </h2>
    <div class="section-content">
      <div class="skill-grid">
        <div class="skill-card">
          <h3 class="skill-title">前端技术</h3>
          <p class="skill-list">Vue / React / TypeScript / JavaScript / HTML / CSS</p>
        </div>
        <div class="skill-card">
          <h3 class="skill-title">框架工具</h3>
          <p class="skill-list">Vite / Webpack / Tailwind CSS / Element Plus</p>
        </div>
        <div class="skill-card">
          <h3 class="skill-title">后端技术</h3>
          <p class="skill-list">Node.js / Python / MySQL / MongoDB</p>
        </div>
        <div class="skill-card">
          <h3 class="skill-title">其他工具</h3>
          <p class="skill-list">Git / Docker / Linux / CI/CD</p>
        </div>
      </div>
    </div>
  </section>

  <section class="resume-section">
    <h2 class="section-title">
      <span class="section-icon">🚀</span>
      项目经验
    </h2>
    <div class="section-content">
      <div class="timeline-item">
        <div class="timeline-dot"></div>
        <div class="timeline-content">
          <div class="item-header">
            <h3 class="item-title">个人博客系统</h3>
            <span class="item-date">2024</span>
          </div>
          <p class="item-subtitle">技术栈：Vue 3 + VitePress + Tailwind CSS</p>
          <ul class="item-descriptions">
            <li>基于 VitePress 搭建的静态博客系统</li>
            <li>实现文章瀑布流展示与标签筛选功能</li>
            <li>采用响应式设计，适配多端设备</li>
          </ul>
        </div>
      </div>
      <div class="timeline-item">
        <div class="timeline-dot"></div>
        <div class="timeline-content">
          <div class="item-header">
            <h3 class="item-title">企业管理系统</h3>
            <span class="item-date">2023</span>
          </div>
          <p class="item-subtitle">技术栈：Vue 3 + Element Plus + Pinia</p>
          <ul class="item-descriptions">
            <li>负责系统前端架构设计与核心模块开发</li>
            <li>实现权限管理、数据可视化等功能</li>
            <li>优化首屏加载性能，提升用户体验</li>
          </ul>
        </div>
      </div>
    </div>
  </section>

  <section class="resume-section">
    <h2 class="section-title">
      <span class="section-icon">✨</span>
      自我评价
    </h2>
    <div class="section-content">
      <p class="self-intro">
        保持空杯心态，持续学习成长。具有扎实的前端开发基础和良好的代码编写习惯，
        善于沟通协作，能够快速融入团队并解决实际问题。对新技术保持热情，
        注重技术深度与广度的结合，追求高质量的技术输出。
      </p>
    </div>
  </section>
</div>

<style scoped>
.resume-page {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 24px;
  position: relative;
}

.download-btn {
  position: fixed;
  top: 80px;
  right: 24px;
  display: flex;
  align-items: center;
  gap: 8px;
  background: var(--color-primary);
  color: white;
  padding: 10px 20px;
  border-radius: var(--radius-full);
  text-decoration: none;
  font-size: 0.9rem;
  font-weight: 500;
  z-index: 10;
  transition: all var(--transition-fast);
  box-shadow: var(--shadow-md);
}

.download-btn:hover {
  background: var(--color-primary-light);
  transform: translateY(-2px);
  box-shadow: var(--shadow-lg);
}

.btn-icon {
  font-size: 1rem;
}

.resume-header {
  text-align: center;
  margin-bottom: 48px;
  padding: 40px;
  background: var(--color-card);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  position: relative;
  overflow: hidden;
}

.header-decoration {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 6px;
  background: linear-gradient(90deg, var(--color-primary), #6366F1, var(--color-accent));
}

.resume-name {
  font-family: var(--font-display);
  font-size: 2rem;
  font-weight: 700;
  color: var(--color-text);
  margin: 16px 0 8px 0;
}

.resume-title {
  font-size: 1.125rem;
  color: var(--color-primary);
  margin: 0 0 20px 0;
  font-weight: 500;
}

.resume-contact {
  display: flex;
  justify-content: center;
  gap: 24px;
  flex-wrap: wrap;
  font-size: 0.9rem;
  color: var(--color-text-secondary);
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 6px;
}

.resume-section {
  margin-bottom: 40px;
}

.section-title {
  display: flex;
  align-items: center;
  gap: 12px;
  font-family: var(--font-display);
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--color-text);
  margin: 0 0 24px 0;
  padding-bottom: 12px;
  border-bottom: 2px solid var(--color-border);
}

.section-icon {
  font-size: 1.5rem;
}

.section-content {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.timeline-item {
  position: relative;
  padding-left: 24px;
}

.timeline-dot {
  position: absolute;
  left: 0;
  top: 8px;
  width: 12px;
  height: 12px;
  background: var(--color-primary);
  border-radius: 50%;
  border: 3px solid var(--color-bg);
  box-shadow: 0 0 0 2px var(--color-primary);
}

.timeline-content {
  background: var(--color-card);
  padding: 20px;
  border-radius: var(--radius-md);
  border: 1px solid var(--color-border);
  transition: all var(--transition-normal);
}

.timeline-content:hover {
  box-shadow: var(--shadow-sm);
  border-color: var(--color-accent-light);
}

.item-header {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  margin-bottom: 4px;
}

.item-title {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--color-text);
  margin: 0;
}

.item-date {
  font-size: 0.85rem;
  color: var(--color-text-light);
}

.item-subtitle {
  font-size: 0.95rem;
  color: var(--color-primary);
  margin: 0 0 12px 0;
  font-weight: 500;
}

.item-descriptions {
  margin: 0;
  padding-left: 20px;
  font-size: 0.95rem;
  color: var(--color-text-secondary);
  line-height: 1.8;
}

.item-descriptions li {
  margin-bottom: 6px;
}

.item-descriptions li:last-child {
  margin-bottom: 0;
}

.skill-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 16px;
}

.skill-card {
  background: var(--color-card);
  padding: 20px;
  border-radius: var(--radius-md);
  border: 1px solid var(--color-border);
  transition: all var(--transition-normal);
}

.skill-card:hover {
  border-color: var(--color-accent-light);
  box-shadow: var(--shadow-sm);
}

.skill-title {
  font-size: 0.95rem;
  font-weight: 600;
  color: var(--color-text);
  margin: 0 0 10px 0;
}

.skill-list {
  font-size: 0.9rem;
  color: var(--color-text-secondary);
  margin: 0;
  line-height: 1.6;
}

.self-intro {
  font-size: 0.95rem;
  color: var(--color-text);
  line-height: 2;
  margin: 0;
  padding: 24px;
  background: var(--color-card);
  border-radius: var(--radius-md);
  border: 1px solid var(--color-border);
  border-left: 4px solid var(--color-accent);
}

@media print {
  .download-btn {
    display: none;
  }

  .resume-page {
    padding: 20px;
  }

  .resume-header {
    box-shadow: none;
  }
}

@media (max-width: 768px) {
  .download-btn {
    position: static;
    width: fit-content;
    margin: 0 auto 24px auto;
  }

  .resume-name {
    font-size: 1.75rem;
  }

  .resume-contact {
    flex-direction: column;
    gap: 8px;
  }

  .item-header {
    flex-direction: column;
    gap: 4px;
  }

  .skill-grid {
    grid-template-columns: 1fr;
  }
}
</style>
