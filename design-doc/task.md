# 个人网站详细设计文档

## 1. 技术栈确定

| 项目 | 选型 | 理由 |
|------|------|------|
| 静态站点生成器 | VitePress | 基于 Vite，构建快；Vue 组件化便于瀑布流等交互开发；Markdown 原生支持 |
| 样式方案 | Tailwind CSS | 原子化 CSS，快速实现扁平化风格；与 VitePress 集成良好 |
| 代码高亮 | Shiki | VitePress 内置，支持多主题 |
| 部署 | Gitee Pages + Gitee Go | 国内访问快，免费托管，支持自动部署 |

## 2. 目录结构

```
personal_homepage/
├── .github/
│   └── workflows/                  # Gitee Go CI/CD 配置（如需要）
├── .gitee/
│   └── workflows/                  # Gitee 流水线配置
├── docs/                           # VitePress 项目根目录
│   ├── .vitepress/
│   │   ├── config.ts               # 站点配置 + 侧边栏 + 导航
│   │   └── theme/
│   │       ├── index.ts            # 主题入口，注册全局组件
│   │       ├── style/
│   │       │   ├── variables.css   # CSS 变量（色彩、字体、间距）
│   │       │   ├── base.css        # 全局基础样式
│   │       │   └── components.css  # 扁平化组件样式
│   │       └── components/
│   │           ├── BlogList.vue    # 博客列表容器
│   │           ├── ArticleCard.vue # 文章卡片
│   │           ├── Sidebar.vue     # 侧边栏
│   │           ├── Avatar.vue      # 头像组件
│   │           ├── Motto.vue       # 座右铭
│   │           ├── ProfileCard.vue # 个人简介
│   │           ├── TagCloud.vue    # 标签云
│   │           ├── NavBar.vue      # 顶部导航栏
│   │           ├── HomeHero.vue    # 首页英雄区
│   │           └── ResumeSection.vue # 简历章节组件
│   ├── posts/                      # 文章 Markdown 文件
│   │   ├── my-first-post.md
│   │   └── ...
│   ├── public/
│   │   ├── assets/
│   │   │   ├── images/             # 封面图等静态资源
│   │   │   ├── avatar.png          # 个人头像
│   │   │   └── background.jpg      # 首页背景图
│   │   └── resume.pdf              # 简历 PDF 文件
│   ├── index.md                    # 首页
│   ├── blog.md                     # 博客页
│   ├── resume.md                   # 简历页
│   └── about.md                    # 关于页
├── package.json
├── tailwind.config.js
└── design-doc/                     # 设计文档
    ├── spec.md
    ├── plan.md
    └── task.md
```

## 3. 各模块详细设计

---

### 3.1 核心框架模块（core）

#### 3.1.1 站点配置 — `.vitepress/config.ts`

| 配置项 | 值 | 说明 |
|--------|-----|------|
| `title` | 站名（如"XX的个人空间"） | 浏览器标签页标题 |
| `description` | 站点描述 | SEO meta description |
| `lang` | `zh-CN` | 页面语言 |
| `base` | `/` 或仓库名 | Gitee Pages 部署路径 |
| `lastUpdated` | `true` | 显示文章最后更新时间 |
| `sitemap.hostname` | 站点域名 | 生成 sitemap |

#### 3.1.2 导航配置

```ts
nav: [
  { text: '首页', link: '/' },
  { text: '博客', link: '/blog' },
  { text: '简历', link: '/resume' },
  { text: '关于', link: '/about' }
]
```

#### 3.1.3 构建配置

| 配置项 | 值 |
|--------|-----|
| `outDir` | `../dist` |
| `cacheDir` | `.vitepress/cache` |

---

### 3.2 页面布局模块（layout）

#### 3.2.1 整体布局结构

采用 VitePress 的自定义 Layout，通过 `theme/layout/Layout.vue` 覆盖默认布局：

```
┌─────────────────────────────────────────────┐
│  NavBar（固定顶部，h: 56px）                  │
├──────────┬──────────────────────────────────┤
│          │                                  │
│ Sidebar  │  主内容区（slot）                  │
│ w: 260px │  max-width: 960px, 居中           │
│ sticky   │                                  │
│ top: 56px│                                  │
│          │                                  │
├──────────┴──────────────────────────────────┤
│  Footer（页脚）                               │
└─────────────────────────────────────────────┘
```

#### 3.2.2 顶部导航栏 — NavBar.vue

- **高度**：56px
- **内容**：左侧 Logo + 站名，右侧导航链接
- **样式**：背景 `#FFFFFF`，底部 1px 边框 `#E8ECF1`，固定顶部（`position: fixed`）
- **移动端**：右侧增加汉堡菜单按钮，点击展开侧边栏抽屉

#### 3.2.3 响应式栅格规则

| 断点 | 侧边栏 | 主内容区 |
|------|--------|---------|
| ≥ 1024px | 左侧固定展示，`w: 260px`，`position: sticky; top: 56px` | 右侧自适应 |
| 768px - 1023px | 隐藏 | 全宽，底部展示座右铭 |
| < 768px | 隐藏 | 全宽，汉堡菜单抽屉 |

#### 3.2.4 页脚

- **内容**：`© 2026 站名 · Powered by VitePress` + 社交图标链接
- **样式**：居中，`padding: 24px 0`，文字 `#8899AA`，`font-size: 14px`

---

### 3.3 博客列表模块（blog-list）

#### 3.3.1 列表布局 — BlogList.vue

**实现方案**：Flexbox 布局

- 所有屏幕尺寸：`flex-direction: column; gap: 20px`
- 卡片宽度：`max-width: 800px; margin: 0 auto`

**选择理由**：纯 CSS 实现，每行一篇文章，响应式适配简单；便于统一卡片样式和间距

**关键样式**：
- 容器设置 `padding: 24px 0`
- 卡片间距通过 `gap: 20px` 控制

#### 3.3.2 文章卡片 — ArticleCard.vue

**Props**：

| 属性 | 类型 | 说明 |
|------|------|------|
| `title` | `string` | 文章标题 |
| `date` | `string` | 发布日期 |
| `excerpt` | `string` | 摘要 |
| `cover` | `string?` | 封面图路径 |
| `tags` | `string[]` | 标签列表 |
| `url` | `string` | 文章详情页链接 |

**结构**：

```
┌─────────────────────┐
│  [封面图]（可选）      │  aspect-ratio: 16/9, object-fit: cover
├─────────────────────┤
│  标签1  标签2         │  font-size: 12px, 辅助色背景
│                     │
│  文章标题             │  font-size: 18px, font-weight: 600
│                     │
│  2026-06-10          │  font-size: 13px, 次要文字色
│                     │
│  文章摘要文字...       │  font-size: 14px, line-clamp: 3
└─────────────────────┘
```

**样式细节**：
- 背景 `#FFFFFF`，边框 `1px solid #E8ECF1`，圆角 `6px`
- hover 效果：边框色变为主色 `#4A90D9`，`transition: 0.2s`
- 封面图：`loading="lazy"` 懒加载
- 摘要：`display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden`
- 整个卡片为 `<a>` 标签，`text-decoration: none`

#### 3.3.3 标签筛选

**实现方式**：
- 点击侧边栏标签云中的标签 → URL 添加 `?tag=xxx` 参数
- BlogList 组件读取 URL 参数，过滤 `tags` 数组包含该标签的卡片
- 未匹配的卡片添加 `display: none`
- 当前选中标签高亮（主色背景 + 白色文字）

#### 3.3.4 加载更多

**实现方式**：分页（非无限滚动）
- VitePress 构建时按每页 12 篇分页，生成分页页面
- 底部分页导航：上一页 / 页码 / 下一页
- 分页组件样式：扁平化按钮，当前页主色高亮

---

### 3.4 首页模块（home）

#### 3.4.1 首页英雄区 — HomeHero.vue

**Props**：

| 属性 | 类型 | 说明 |
|------|------|------|
| `logo` | `string` | Logo 图片路径 |
| `siteName` | `string` | 网站名称 |
| `motto` | `string` | 座右铭文字 |
| `backgroundImage` | `string` | 背景图路径 |

**结构**：

```
┌───────────────────────────────────────────────────────────┐
│  全屏背景图（模糊处理，z-index: -1）                          │
├───────────────────────────────────────────────────────────┤
│  [Logo]（圆形，w: 120px，h: 120px）                           │
│                                                           │
│  网站名称（font-size: 36px，font-weight: 700）               │
│                                                           │
│  座右铭（font-size: 18px，italic，margin: 16px 0）            │
│                                                           │
│  导航按钮组（首页、博客、简历、关于）                          │
│  （半透明深色背景，圆角 8px，padding: 12px 24px）              │
└───────────────────────────────────────────────────────────┘
```

**样式细节**：
- 背景图：`background-size: cover; background-position: center; filter: brightness(0.8)`
- 内容区：`min-height: 100vh; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; color: white`
- Logo：`border: 4px solid white; border-radius: 50%`
- 导航按钮：`margin: 0 8px; transition: background-color 0.2s; hover: background-color rgba(255,255,255,0.2)`
- 移动端：导航按钮变为底部固定栏，`position: fixed; bottom: 0; left: 0; right: 0; background-color rgba(0,0,0,0.8)`

---

### 3.5 侧边栏模块（sidebar）

#### 3.5.1 侧边栏容器 — Sidebar.vue

**布局**：
- 桌面端：`position: sticky; top: 56px; width: 260px; height: calc(100vh - 56px); overflow-y: auto`
- 移动端：`position: fixed; top: 56px; left: -260px; transition: left 0.3s`，汉堡菜单点击后 `left: 0`，覆盖半透明遮罩

**内容排列**（从上到下）：
1. 个人头像（Avatar）
2. 座右铭（Motto）
3. 个人简介（ProfileCard）
4. 标签云（TagCloud）

#### 3.5.2 头像组件 — Avatar.vue

**Props**：

| 属性 | 类型 | 说明 |
|------|------|------|
| `src` | `string` | 头像图片路径 |
| `alt` | `string` | 替代文本 |
| `size` | `number` | 头像尺寸（默认：80） |

**样式细节**：
- 圆形裁剪：`border-radius: 50%`
- 边框：`border: 2px solid #E8ECF1`
- 阴影：`box-shadow: 0 2px 8px rgba(0,0,0,0.1)`
- 响应式：移动端尺寸自动缩小为 60px

#### 3.5.3 座右铭 — Motto.vue

**结构**：
```
┌──────────────────────┐
│  ❝                   │  引号图标，主色，font-size: 24px
│                      │
│  座右铭文字内容        │  font-size: 15px, 行高 1.8, 正文色
│                      │
│  ───────────         │  分割线，1px, #E8ECF1
└──────────────────────┘
```

**数据来源**：在 `.vitepress/config.ts` 的 `themeConfig` 中配置 `motto` 字段

#### 3.5.4 个人简介 — ProfileCard.vue

**结构**：
```
┌──────────────────────┐
│     [头像]            │  80x80, 圆形, border-radius: 50%
│     昵称              │  font-size: 18px, font-weight: 600
│  一句话介绍            │  font-size: 14px, 次要文字色
└──────────────────────┘
```

**数据来源**：`themeConfig.profile` 配置项

#### 3.5.5 标签云 — TagCloud.vue

**结构**：
```
┌──────────────────────┐
│  标签                 │  标题, font-size: 14px, font-weight: 600
│                      │
│  [标签1] [标签2]      │  行内块, 辅助色背景, 圆角 4px
│  [标签3] [标签4]      │  font-size: 13px, padding: 2px 10px
│  [标签5] ...          │  hover: 主色背景 + 白色文字
└──────────────────────┘
```

**数据来源**：构建时从所有文章的 Front Matter 中提取 tags，去重后按文章数量降序排列

**交互**：点击标签 → 跳转首页并携带 `?tag=xxx` 参数触发筛选

---

### 3.6 文章详情模块（article）

#### 3.6.1 页面结构

VitePress 默认的文章布局已包含 Markdown 渲染和代码高亮，需自定义以下部分：

**文章元信息区域**（插入在正文上方）：
```
┌──────────────────────────────────────┐
│  ← 返回首页                          │  链接, font-size: 14px, 主色
│                                      │
│  文章标题                              │  font-size: 28px, font-weight: 700
│                                      │
│  📅 2026-06-10   🏷 标签1 标签2        │  font-size: 14px, 次要文字色
│  ─────────────────────────           │  分割线
└──────────────────────────────────────┘
```

#### 3.5.2 Markdown 渲染

- 使用 VitePress 内置 Markdown 渲染，无需额外配置
- 代码高亮使用 Shiki，主题选择 `github-light`（与清新风格一致）

#### 3.6.3 返回导航

- 文章顶部左上角添加"← 返回博客"链接
- 使用 `<router-link>` 或 `<a href="/blog">` 返回博客页

---

### 3.7 简历模块（resume）

#### 3.7.1 简历页面布局 — `docs/resume.md`

**页面结构**：

```
┌───────────────────────────────────────────────────────────┐
│  页面标题（个人简历）                                        │
├───────────────────────────────────────────────────────────┤
│  PDF 下载按钮（右上角固定）                                 │
├───────────────────────────────────────────────────────────┤
│  个人信息（姓名、职位、联系方式、教育经历）                   │
├───────────────────────────────────────────────────────────┤
│  工作经历（公司、职位、时间、职责）                         │
├───────────────────────────────────────────────────────────┤
│  技能特长（技术栈、工具熟练度）                             │
├───────────────────────────────────────────────────────────┤
│  项目经验（项目名称、描述、成果）                           │
└───────────────────────────────────────────────────────────┘
```

**样式细节**：
- 容器：`max-width: 800px; margin: 0 auto; padding: 40px 20px`
- 章节标题：`font-size: 20px; font-weight: 600; color: var(--color-primary); margin: 32px 0 16px; padding-bottom: 8px; border-bottom: 2px solid var(--color-primary)`
- 内容项：`margin-bottom: 16px; line-height: 1.8`
- PDF 下载按钮：`position: fixed; top: 80px; right: 20px; background: var(--color-primary); color: white; padding: 8px 16px; border-radius: 6px; text-decoration: none`

#### 3.7.2 简历章节组件 — ResumeSection.vue

**Props**：

| 属性 | 类型 | 说明 |
|------|------|------|
| `title` | `string` | 章节标题 |
| `items` | `object[]` | 章节内容项 |
| `collapsible` | `boolean` | 是否可折叠（移动端默认开启） |

**内容项结构**：

```ts
interface ResumeItem {
  title: string      // 如公司名、学校名、项目名
  subtitle?: string  // 如职位、学历
  date?: string      // 时间范围
  description?: string[] // 描述列表
}
```

**功能实现**：
- 桌面端：章节展开显示，点击标题无折叠效果
- 移动端（< 768px）：章节默认折叠，点击展开/收起
- 展开/收起动画：`transition: max-height 0.3s ease`

#### 3.7.3 PDF 下载功能

**实现方式**：
1. 简历 PDF 文件存放于 `docs/public/resume.pdf`
2. 页面添加下载按钮：`<a href="/resume.pdf" download="个人简历.pdf">下载 PDF</a>`
3. 按钮固定在页面右上角，滚动时始终可见

**备选方案（打印友好）**：
- 提供打印按钮：`<button @click="window.print()">打印简历</button>`
- 打印样式优化：`@media print` 中隐藏下载按钮，优化页面边距

---

### 3.8 内容管理模块（content）

#### 3.8.1 文章目录

- 路径：`docs/posts/`
- 命名规范：`{yyyy-mm-dd}-{slug}.md`，如 `2026-06-10-my-first-post.md`
- VitePress 自动根据文件路径生成路由：`/posts/2026-06-10-my-first-post.html`

#### 3.8.2 Front Matter 规范

```yaml
---
title: string          # 必填，文章标题
date: string           # 必填，发布日期，格式 yyyy-MM-dd
tags: string[]         # 必填，标签数组
cover: string?         # 可选，封面图路径，相对于 public 目录
excerpt: string?       # 可选，摘要；未填则自动截取正文前 120 字符
---
```

#### 3.8.3 文章索引生成

**方式**：VitePress 的 `createContentLoader` API

- 在 `.vitepress/config.ts` 中使用 `createContentLoader('posts/*.md')` 批量读取文章
- 提取 Front Matter 元信息，按 `date` 降序排列
- 生成 JSON 数据供首页瀑布流组件使用

**输出数据结构**：

```ts
interface ArticleMeta {
  title: string
  date: string
  tags: string[]
  cover?: string
  excerpt: string
  url: string    // 文章详情页路径
}
```

#### 3.8.4 静态资源管理

- 封面图存放于 `docs/public/assets/images/`
- 引用方式：Front Matter 中 `cover: /assets/images/xxx.jpg`
- 图片格式建议：WebP（优先）或 JPG，单张不超过 200KB

---

### 3.9 视觉风格模块（style）

#### 3.9.1 CSS 变量定义 — variables.css

```css
:root {
  /* 主色调 */
  --color-primary: #2563EB;
  --color-primary-light: #3B82F6;
  --color-secondary: #64748B;
  --color-accent: #F59E0B;

  /* 背景色 */
  --color-bg: #FFFFFF;
  --color-bg-alt: #F8FAFC;
  --color-card: #FFFFFF;
  --color-card-hover: #F1F5F9;

  /* 文字色 */
  --color-text: #0F172A;
  --color-text-secondary: #475569;
  --color-text-light: #94A3B8;

  /* 边框 */
  --color-border: #E2E8F0;
  --color-divider: #F1F5F9;

  /* 字体 */
  --font-display: 'Noto Serif SC', serif;
  --font-body: 'Noto Sans SC', sans-serif;
  --font-code: 'Fira Code', 'JetBrains Mono', monospace;

  /* 间距 */
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 24px;
  --spacing-xl: 40px;
  --spacing-2xl: 64px;

  /* 圆角 */
  --radius-sm: 8px;
  --radius-md: 12px;
  --radius-lg: 20px;
  --radius-full: 9999px;

  /* 阴影 */
  --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.06);
  --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
  --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);

  /* 过渡 */
  --transition-fast: 150ms ease;
  --transition-normal: 300ms ease;
  --transition-slow: 500ms ease;
}
```

#### 3.9.2 全局基础样式 — base.css

| 规则 | 值 |
|------|-----|
| `body` 背景 | `var(--color-bg)` |
| `body` 字体 | `var(--font-body)` |
| `body` 行高 | `1.7` |
| `body` 文字色 | `var(--color-text)` |
| `a` 颜色 | `var(--color-primary)` |
| `a:hover` | `text-decoration: underline` |
| `img` | `max-width: 100%; height: auto` |

#### 3.9.3 扁平化组件样式 — components.css

| 组件 | 样式规则 |
|------|---------|
| 按钮 | `background: var(--color-primary); color: #fff; border: none; border-radius: var(--radius-md); padding: 8px 20px; cursor: pointer` |
| 标签 | `display: inline-block; background: var(--color-secondary); color: #fff; border-radius: var(--radius-sm); padding: 2px 10px; font-size: 13px` |
| 卡片 | `background: var(--color-card); border: 1px solid var(--color-border); border-radius: var(--radius-md); overflow: hidden` |
| 卡片 hover | `border-color: var(--color-primary); transition: border-color 0.2s` |

#### 3.7.4 Tailwind 配置 — tailwind.config.js

扩展 Tailwind 主题以使用自定义 CSS 变量：

| 扩展项 | 映射 |
|--------|------|
| `colors.primary` | `var(--color-primary)` |
| `colors.secondary` | `var(--color-secondary)` |
| `colors.bg` | `var(--color-bg)` |
| `colors.card` | `var(--color-card)` |
| `colors.textPrimary` | `var(--color-text)` |
| `colors.textSecondary` | `var(--color-text-secondary)` |
| `borderColor.default` | `var(--color-border)` |

---

### 3.10 部署模块（deploy）

#### 3.10.1 部署方式

使用 Gitee Pages 服务，部署方式选择 **Gitee Pages (main 分支)**。

#### 3.10.2 部署配置

**前提条件**：
1. 代码仓库已推送至 Gitee
2. 在 Gitee 仓库的 **服务 → Gitee Pages** 中开启服务
3. 选择部署分支为 `main`，部署目录为 `/` 或 `/docs/.vitepress/dist`

#### 3.10.3 一键发布脚本 — `deploy.sh`

```bash
#!/bin/bash
echo "开始构建并部署..."
npm run docs:build
git add dist/
git commit -m "Deploy: 更新站点内容"
git push origin main
echo "部署完成！"
echo "请在 Gitee Pages 页面手动更新部署，或使用 Gitee Go 流水线自动部署"
```

#### 3.10.4 Gitee Pages 手动部署

1. 进入 Gitee 仓库首页
2. 点击 **服务 → Gitee Pages**
3. 点击 **更新** 按钮
4. 等待部署完成，访问 `https://用户名.gitee.io/仓库名/`

#### 3.10.5 Gitee Go 自动部署（可选）

如需自动部署，可在 `.gitee/workflows/` 目录下添加流水线配置文件：

```yaml
# .gitee/workflows/deploy.yml
name: Deploy to Gitee Pages
on: [push]
jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
      - run: npm install
      - run: npm run docs:build
      - run: |
          cd docs/.vitepress/dist
          git init
          git config user.name "CI"
          git config user.email "ci@gitee.com"
          git add -A
          git commit -m "Build output"
      - name: Deploy to Gitee Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          external_repository: 用户名/仓库名
          publish_dir: ./docs/.vitepress/dist
          publish_branch: gh-pages
          user_name: 'CI'
          user_email: 'ci@gitee.com'
```

#### 3.10.6 回滚操作

1. 进入 Gitee Pages 设置页面
2. 选择之前的部署版本，点击 **更新** 恢复
3. 或使用 `git revert` 回滚代码后重新部署

---

## 4. 首页数据流

```
posts/*.md
    │
    ▼  createContentLoader（构建时）
ArticleMeta[]
    │
    ▼  写入首页 frontmatter 或 JSON
index.md
    │
    ▼  Waterfall.vue 读取
按 date 降序排列 → 渲染 ArticleCard 列表
    │
    ▼  URL ?tag=xxx 过滤
仅显示匹配标签的卡片
```

## 5. 组件通信设计

| 场景 | 方式 | 说明 |
|------|------|------|
| 标签云 → 瀑布流筛选 | URL 参数 `?tag=xxx` | 通过 `useRoute().query.tag` 读取，无需状态管理 |
| 汉堡菜单 → 侧边栏展开 | Props / Emit | NavBar emit `toggle-sidebar`，Sidebar 接收 `isOpen` prop |
| 文章索引 → 瀑布流数据 | VitePress `useData()` | 通过 `createContentLoader` 在构建时注入数据 |

## 6. SEO 设计

| 项目 | 实现 |
|------|------|
| 页面标题 | VitePress 自动生成 `<title>` 标签 |
| meta description | 每篇文章 Front Matter 中的 `excerpt` |
| Open Graph | VitePress `head` 配置中添加 OG 标签 |
| sitemap | VitePress 内置 sitemap 生成 |
| 语义化 HTML | 使用 `<article>` `<nav>` `<aside>` `<header>` `<footer>` 等标签 |

## 7. 性能优化设计

| 优化项 | 实现方式 |
|--------|---------|
| 图片懒加载 | `<img loading="lazy">` |
| 封面图压缩 | 构建时使用 `vite-plugin-imagemin` 或手动压缩为 WebP |
| CSS 按需加载 | Tailwind CSS 自动 purge 未使用的样式 |
| 预渲染 | VitePress 默认静态生成，每个页面为独立 HTML |
| 字体优化 | `font-display: swap`，仅加载需要的字重（400, 600, 700） |
