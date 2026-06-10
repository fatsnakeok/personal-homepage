#!/bin/bash

# 空杯成长笔记 - 快速发布单篇文章脚本
# 用法: ./publish-post.sh <文章路径> "提交信息"

set -e

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# 检查参数
if [ -z "$1" ]; then
    echo "用法: ./publish-post.sh <文章路径> [提交信息]"
    echo "示例: ./publish-post.sh docs/posts/2026-06-10-my-post.md"
    exit 1
fi

POST_PATH="$1"
COMMIT_MSG="$2"

# 检查文件是否存在
if [ ! -f "$POST_PATH" ]; then
    echo "错误: 文件不存在: $POST_PATH"
    exit 1
fi

# 提取文章标题（从 Front Matter）
TITLE=$(sed -n 's/^title: *//p' "$POST_PATH" | head -1)

if [ -z "$COMMIT_MSG" ]; then
    if [ -n "$TITLE" ]; then
        COMMIT_MSG="Publish: $TITLE"
    else
        COMMIT_MSG="Publish new post"
    fi
fi

echo ""
echo "=========================================="
echo "  发布文章: ${TITLE:-$POST_PATH}"
echo "=========================================="
echo ""

# 添加文件到暂存区
print_info "添加文章到暂存区..."
git add "$POST_PATH"

# 如果有图片目录，也添加
IMAGES_DIR="docs/public/assets/images"
if [ -d "$IMAGES_DIR" ]; then
    if git diff --name-only "$IMAGES_DIR" 2>/dev/null | grep -q .; then
        print_info "添加图片资源..."
        git add "$IMAGES_DIR"
    fi
fi

# 提交
print_info "提交代码: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"
print_success "代码已提交"

# 推送
print_info "推送到远程仓库..."
git push origin main
print_success "代码已推送"

echo ""
echo "=========================================="
print_success "文章发布成功！"
echo "=========================================="
echo ""
echo "GitHub Actions 正在自动部署，请稍后访问网站查看效果。"
echo ""
