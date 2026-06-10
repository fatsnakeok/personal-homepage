# 空杯成长笔记

> 把心倒空，从容应对所有未知；收藏点滴美好，在岁月里持续成长。

一个基于 VitePress 构建的个人博客网站，用于记录学习笔记和成长感悟。

## 功能特性

- 🏠 **首页英雄区**：全屏背景 + Logo + 座右铭 + 导航
- 📝 **博客列表**：单列表布局，响应式设计
- 📄 **简历页**：完整简历展示 + PDF 下载
- 🏷️ **标签筛选**：按标签分类浏览文章
- 📱 **响应式设计**：适配桌面、平板和移动设备
- 🎨 **自然有机风格**：简洁现代的视觉设计
- 🚀 **自动部署**：GitHub Actions 自动化 CI/CD

## 技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| VitePress | ^1.6.0 | 静态站点生成器 |
| Vue 3 | ^3.5.0 | 前端框架 |
| Tailwind CSS | ^4.0.0 | 样式框架 |
| GitHub Pages | - | 网站托管 |
| GitHub Actions | - | CI/CD 自动化 |

---

## 快速开始

### 安装依赖

```bash
npm install
```

### 开发模式

```bash
npm run docs:dev
```

访问 http://localhost:5173 查看网站。

### 生产构建

```bash
npm run docs:build
```

构建产物将输出到 `dist` 目录。

### 预览构建结果

```bash
npm run docs:preview
```

---

## 发布到 GitHub Pages（详细步骤）

### 第一步：创建 GitHub 仓库

1. 登录 GitHub，点击右上角 **+** → **New repository**
2. 填写仓库信息：
   - **Repository name**: `personal-homepage`（或其他名称）
   - **Visibility**: Public 或 Private
   - **不要勾选** "Add a README file"（避免冲突）
3. 点击 **Create repository**

### 第二步：本地初始化 Git

在项目根目录下执行：

```bash
# 初始化 Git（如果尚未初始化）
git init

# 添加所有文件
git add .

# 首次提交
git commit -m "Initial commit"

# 添加远程仓库（替换为你的仓库地址）
git remote add origin https://github.com/你的用户名/仓库名.git

# 切换到 main 分支
git branch -M main
```

### 第三步：推送代码到 GitHub

```bash
# 推送到远程仓库
git push -u origin main
```

### 第四步：配置 GitHub Pages

1. 进入你的 GitHub 仓库
2. 点击 **Settings**（设置）
3. 左侧菜单找到 **Pages**
4. 在 **Build and deployment** 部分：
   - **Source**: 选择 **GitHub Actions**
5. 点击 **Save**

### 第五步：配置 deploy.yml（已配置好）

项目已包含 `.github/workflows/deploy.yml`，会自动部署。内容如下：

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm

      - name: Install Dependencies
        run: npm ci

      - name: Build
        run: npm run docs:build

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: docs/.vitepress/dist

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### 第六步：查看部署状态

1. 进入仓库 → **Actions** 标签页
2. 可以看到 "Deploy to GitHub Pages" workflow 正在运行
3. 等待 1-3 分钟，状态变为绿色 ✓
4. 点击 workflow 查看详情，确认 **deploy** job 完成

### 第七步：访问网站

部署成功后，访问：`https://你的用户名.github.io/仓库名/`

例如：`https://username.github.io/personal-homepage/`

---

## 发布文章流程

### 方式一：手动发布

1. **本地预览文章**

```bash
npm run docs:dev
```

在浏览器中预览文章效果。

2. **提交代码**

```bash
git add docs/posts/你的文章.md
git commit -m "Add post: 文章标题"
git push origin main
```

3. **等待自动部署**

GitHub Actions 会自动构建并部署，通常 2-3 分钟完成。

4. **查看效果**

访问你的网站即可看到新发布的文章。

### 方式二：使用一键发布脚本

项目提供了两个发布脚本：

#### deploy.sh - 完整发布

```bash
# 基本用法（自动生成提交信息）
./deploy.sh

# 指定提交信息
./deploy.sh "发布新文章"
```

#### publish-post.sh - 快速发布单篇

```bash
# 发布指定文章
./publish-post.sh docs/posts/2026-06-10-my-post.md
```

#### 首次使用

确保脚本有执行权限：

```bash
chmod +x deploy.sh publish-post.sh
```

---

## 添加新文章

### 创建文章文件

在 `docs/posts/` 目录下创建 Markdown 文件：

```bash
docs/posts/2026-06-15-my-new-post.md
```

### 文章格式

```yaml
---
title: 文章标题
date: 2026-06-15
tags: [标签1, 标签2]
cover: /assets/images/cover.jpg  # 可选
excerpt: 文章摘要               # 可选
---

## 正文内容

这里是文章正文...
```

### 添加封面图

1. 将图片放入 `docs/public/assets/images/` 目录
2. 在 Front Matter 中引用：

```yaml
cover: /assets/images/your-image.jpg
```

---

## 项目结构

```
personal_homepage/
├── .github/
│   └── workflows/
│       └── deploy.yml          # CI/CD 工作流
├── docs/                       # VitePress 项目根目录
│   ├── .vitepress/
│   │   ├── config.ts           # 站点配置
│   │   ├── posts.data.ts        # 文章数据加载器
│   │   └── theme/
│   │       ├── index.ts        # 主题入口
│   │       ├── components/      # Vue 组件
│   │       │   ├── ArticleCard.vue
│   │       │   ├── BlogList.vue
│   │       │   ├── HomeHero.vue
│   │       │   ├── Motto.vue
│   │       │   ├── ProfileCard.vue
│   │       │   ├── Sidebar.vue
│   │       │   └── TagCloud.vue
│   │       └── style/
│   │           └── index.css   # 全局样式
│   ├── posts/                  # 文章目录
│   │   └── *.md
│   ├── public/
│   │   └── assets/
│   │       └── images/        # 静态图片
│   ├── about.md                # 关于页面
│   ├── blog.md                # 博客页面
│   ├── index.md                # 首页
│   └── resume.md              # 简历页面
├── design-doc/                 # 设计文档
│   ├── spec.md
│   ├── plan.md
│   ├── task.md
│   ├── test.md
│   └── style-guide.md
├── deploy.sh                   # 一键发布脚本
├── publish-post.sh             # 快速发布脚本
└── package.json
```

---

## 配置网站信息

在 `docs/.vitepress/config.ts` 中修改：

```typescript
export default defineConfig({
  title: '空杯成长笔记',
  description: '把心倒空，从容应对所有未知；收藏点滴美好，在岁月里持续成长。',
  lang: 'zh-CN',
  
  themeConfig: {
    nav: [
      { text: '首页', link: '/' },
      { text: '博客', link: '/blog' },
      { text: '简历', link: '/resume' },
      { text: '关于', link: '/about' }
    ]
  }
})
```

---

## 常见问题

### Q: 部署失败怎么办？

1. 进入 **Actions** 标签页
2. 点击失败的 workflow
3. 查看错误日志
4. 修复问题后重新推送

### Q: 如何回滚到之前的版本？

1. 进入 **Actions** 标签页
2. 找到上一次成功的 deployment
3. 点击右侧 **...** → **Re-run jobs**

### Q: 访问 404 怎么办？

确保 `docs/.vitepress/config.ts` 中的 `base` 配置正确：

- 如果是 `用户名.github.io/repo-name`：设置 `base: '/repo-name/'`
- 如果是自定义域名：设置 `base: '/'`

### Q: 图片不显示？

确保图片放在 `docs/public/` 目录下，路径以 `/` 开头。

---

## 自定义域名（可选）

### 1. 配置 CNAME 文件

在 `docs/public/` 目录下创建 `CNAME` 文件：

```
docs/public/CNAME
```

内容为你的域名：
```
yourdomain.com
```

### 2. 配置 DNS

在你的域名管理后台添加记录：

- **CNAME 记录**：`www` → `你的用户名.github.io`
- 或 **A 记录**：`@` → `185.199.108.153`

### 3. 在 GitHub Pages 设置

1. 进入仓库 **Settings** → **Pages**
2. **Custom domain**: 输入你的域名
3. 勾选 **Enforce HTTPS**

---

## 许可证

MIT License

---

**创建时间**：2026-06-10
