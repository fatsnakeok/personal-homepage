#!/bin/bash

# =========================================
# 空杯成长笔记 - 发布脚本 (Gitee Pages)
# =========================================

set -e

echo "========================================="
echo "  空杯成长笔记 - 发布脚本 (Gitee)"
echo "========================================="

# 检查环境
echo "[1/6] 检查环境..."
if [ ! -d "docs/.vitepress" ]; then
    echo "❌ 错误: 未找到 docs/.vitepress 目录"
    exit 1
fi
if [ ! -f "package.json" ]; then
    echo "❌ 错误: 未找到 package.json"
    exit 1
fi

# 安装依赖
echo "[2/6] 安装依赖..."
npm install

# 清理旧的 dist
echo "[3/6] 清理旧的构建文件..."
rm -rf docs/.vitepress/dist

# 构建项目
echo "[4/6] 构建项目..."
npm run docs:build

# 验证构建结果
echo "[5/6] 验证构建结果..."
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
    echo "[6/6] 初始化 Git 仓库..."
    git init
    git branch -M main
    # 检测是否已有 Gitee 远程仓库配置
    if git remote get-url origin &>/dev/null; then
        echo "✅ 已配置远程仓库"
    else
        echo "请先配置 Gitee 远程仓库地址:"
        echo "  git remote add origin git@gitee.com:你的用户名/仓库名.git"
        exit 1
    fi
else
    echo "[6/6] 更新文件..."
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
echo "推送代码到 Gitee..."
git push origin main --force

echo ""
echo "========================================="
echo "  ✅ 推送完成！"
echo "========================================="
echo ""
echo "📋 下一步操作:"
echo "1. 登录 Gitee 仓库"
echo "2. 进入 【服务 → Gitee Pages】"
echo "3. 点击【更新】按钮部署"
echo ""
echo "部署完成后访问:"
echo "  https://你的用户名.gitee.io/personal-homepage/"
echo ""
