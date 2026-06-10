#!/bin/bash

# =========================================
# 空杯成长笔记 - 发布脚本
# =========================================

set -e

echo "========================================="
echo "  空杯成长笔记 - 发布脚本"
echo "========================================="

# 检查环境
echo "[1/7] 检查环境..."
if [ ! -d "docs/.vitepress" ]; then
    echo "❌ 错误: 未找到 docs/.vitepress 目录"
    exit 1
fi
if [ ! -f "package.json" ]; then
    echo "❌ 错误: 未找到 package.json"
    exit 1
fi

# 安装依赖
echo "[2/7] 安装依赖..."
npm install

# 清理旧的 dist
echo "[3/7] 清理旧的构建文件..."
rm -rf docs/.vitepress/dist

# 构建项目
echo "[4/7] 构建项目..."
npm run docs:build

# 验证构建结果
echo "[5/7] 验证构建结果..."
if [ ! -f "docs/.vitepress/dist/index.html" ]; then
    echo "❌ 错误: 构建失败，未生成 index.html"
    exit 1
fi

# 检查资源路径是否正确
if grep -q 'href="/personal-homepage/assets' "docs/.vitepress/dist/index.html"; then
    echo "✅ 资源路径验证通过"
else
    echo "⚠️ 警告: 资源路径可能有问题，请检查"
fi

# 进入 dist 目录
cd docs/.vitepress/dist

# 初始化 Git（如果需要）
if [ ! -d ".git" ]; then
    echo "[6/7] 初始化 Git 仓库..."
    git init
    git branch -M gh-pages
    git remote add origin git@github.com:fatsnakeok/personal-homepage.git
else
    echo "[6/7] 更新文件..."
fi

# 添加所有文件
git add .

# 检查是否有变更
if git diff --staged --quiet; then
    echo "⚠️  没有文件变更，跳过提交"
    echo ""
    echo "========================================="
    echo "  ✅ 构建完成（无新变更）"
    echo "========================================="
    exit 0
fi

# 提交
COMMIT_MSG="${1:-更新站点内容}"
git commit -m "$COMMIT_MSG"

# 推送到远程
echo "[7/7] 推送到 GitHub..."
git push -u origin gh-pages --force

echo ""
echo "========================================="
echo "  ✅ 部署完成！"
echo "========================================="
echo ""
echo "请在 GitHub 上确认 Pages 配置:"
echo "Settings → Pages → Source: gh-pages / (root)"
echo ""
echo "访问: https://fatsnakeok.github.io/personal-homepage/"
echo ""
