#!/bin/bash

# =========================================
# 空杯成长笔记 - 发布脚本
# =========================================

set -e

echo "========================================="
echo "  空杯成长笔记 - 发布脚本"
echo "========================================="

# 检查环境
echo "[1/5] 检查环境..."
if [ ! -d "docs/.vitepress" ]; then
    echo "❌ 错误: 未找到 docs/.vitepress 目录"
    exit 1
fi

# 安装依赖
echo "[2/5] 安装依赖..."
npm install

# 构建项目
echo "[3/5] 构建项目..."
npm run docs:build

# 进入 dist 目录
cd docs/.vitepress/dist

# 清理 Git 缓存（保留 .git 目录）
echo "[4/5] 提交文件..."
git add .

# 检查是否有变更
if git diff --staged --quiet; then
    echo "⚠️  没有文件变更，跳过提交"
else
    # 获取提交信息
    COMMIT_MSG="${1:-更新站点内容}"
    git commit -m "$COMMIT_MSG"
fi

# 推送到远程
echo "[5/5] 推送到 GitHub..."
git push origin gh-pages

echo ""
echo "========================================="
echo "  ✅ 部署完成！"
echo "========================================="
echo ""
echo "请在 GitHub 上配置 Pages:"
echo "Settings → Pages → Source: gh-pages / (root)"
echo ""
echo "访问: https://fatsnakeok.github.io/personal-homepage/"
echo ""
