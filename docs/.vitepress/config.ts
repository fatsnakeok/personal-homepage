import { defineConfig } from 'vitepress'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  title: '空杯成长笔记',
  description: '保持空杯心态，持续学习成长',
  lang: 'zh-CN',
  base: '/personal-homepage/',
  lastUpdated: true,
  
  head: [
    ['link', { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Noto+Sans+SC:wght@400;500;600;700&family=Fira+Code:wght@400;500&display=swap' }]
  ],

  themeConfig: {
    nav: [
      { text: '首页', link: '/' },
      { text: '博客', link: '/blog' },
      { text: '简历', link: '/resume' },
      { text: '关于', link: '/about' }
    ],

    footer: {
      message: '© 2026 空杯成长笔记 · Powered by VitePress',
      copyright: ''
    },

    profile: {
      name: '空杯学习者',
      bio: '保持空杯心态，持续学习成长',
      avatar: '/assets/images/avatar.png'
    },

    motto: '人生最大的挑战是发现自己是谁，而第二大的挑战是对所发现的感到满意。',

    socialLinks: [
      { icon: 'github', link: 'https://github.com/fatsnakeok?tab=repositories' }
    ]
  },

  vite: {
    plugins: [
      tailwindcss()
    ]
  }
})
