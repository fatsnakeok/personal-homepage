import DefaultTheme from 'vitepress/theme'
import './style/index.css'
import { h, computed } from 'vue'
import Sidebar from './components/Sidebar.vue'
import { useData, useRoute } from 'vitepress'
import type { Theme } from 'vitepress'

export default {
  extends: DefaultTheme,
  Layout: () => {
    const { frontmatter } = useData()
    const route = useRoute()
    
    // 首页不使用侧边栏
    const showSidebar = computed(() => {
      const path = route.path
      return path !== '/' && !path.endsWith('/')
    })

    return h(DefaultTheme.Layout, null, {
      'aside-outline': () => showSidebar.value ? h(Sidebar) : null
    })
  },
  setup() {
    const { frontmatter } = useData()
    return { frontmatter }
  },
  enhanceApp({ app }) {
    // 全局属性可通过 app.config.globalProperties 访问
  }
} satisfies Theme
