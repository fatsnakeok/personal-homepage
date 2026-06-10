#!/bin/bash

# =========================================
# 空杯成长笔记 - 快速发布单篇文章
# =========================================

set -e

# 检查参数
if [ -z "$1" ]; then
    echo "❌ 用法: $0 <文章路径> [提交信息]"
    echo "示例: $0 docs/posts/2026-06-15-my-post.md"
    exit 1
fi

POST_PATH="$1"
COMMIT_MSG="${2:-发布文章: $(basename "$1")}"

echo "========================================="
echo "  空杯成长笔记 - 快速发布"
echo "========================================="

# 构建项目
echo "[1/4] 构建项目..."
npm run docs:build

# 进入 dist 目录
cd docs/.vitepress/dist

# 添加文章文件
echo "[2/4] 添加文件..."
git add "$POST_PATH"

# 提交
echo "[3/4] 提交..."
git commit -m "$COMMIT_MSG"

# 推送
echo "[4/4] 推送..."
git push origin gh-pages

echo ""
echo "✅ 发布完成！"
echo "访问: https://fatsnakeok.github.io/personal-homepage/"
