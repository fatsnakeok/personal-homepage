#!/bin/bash

# =========================================
# 空杯成长笔记 - 发布脚本
# =========================================

set -e

# 脚本目录
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "========================================="
echo "  空杯成长笔记 - 发布脚本"
echo "========================================="

# =========================================
# 函数定义
# =========================================

# 检查功能完整性
check_functionality() {
    echo ""
    echo "========================================="
    echo "  [功能检查] 检查页面功能完整性"
    echo "========================================="

    local errors=0

    # 检查必要页面是否存在
    echo "- 检查必要页面..."
    local pages=("about.md" "resume.md" "blog.md" "index.md")
    for page in "${pages[@]}"; do
        if [ -f "docs/$page" ]; then
            echo "  ✅ $page 存在"
        else
            echo "  ❌ $page 缺失"
            errors=$((errors + 1))
        fi
    done

    # 检查简历 PDF 是否存在
    echo "- 检查简历 PDF..."
    if [ -f "docs/public/assets/images/resume.pdf" ]; then
        echo "  ✅ 简历 PDF 存在"
    else
        echo "  ⚠️ 简历 PDF 不存在，跳过下载功能"
    fi

    # 检查简历页面的下载链接
    echo "- 检查简历下载链接..."
    if grep -q 'href=.*resume.pdf' "docs/resume.md"; then
        echo "  ✅ 简历下载链接存在"
    else
        echo "  ⚠️ 简历下载链接未配置"
    fi

    # 检查 about 页面内容完整性
    echo "- 检查关于页面内容..."
    if grep -q '## 技术栈' "docs/about.md" && grep -q '## 联系方式' "docs/about.md"; then
        echo "  ✅ 关于页面结构完整"
    else
        echo "  ⚠️ 关于页面可能缺少必要内容"
    fi

    # 检查 resume 页面内容完整性
    echo "- 检查简历页面内容..."
    if grep -q '教育背景' "docs/resume.md" && grep -q '专业技能' "docs/resume.md" && grep -q '工作经历' "docs/resume.md"; then
        echo "  ✅ 简历页面结构完整"
    else
        echo "  ❌ 简历页面缺少必要内容"
        errors=$((errors + 1))
    fi

    if [ $errors -gt 0 ]; then
        echo ""
        echo "❌ 功能检查失败，发现 $errors 个问题"
        return 1
    fi

    echo ""
    echo "✅ 功能检查通过"
    return 0
}

# =========================================
# 主流程
# =========================================

# 检查环境
echo "[1/8] 检查环境..."
if [ ! -d "docs/.vitepress" ]; then
    echo "❌ 错误: 未找到 docs/.vitepress 目录"
    exit 1
fi
if [ ! -f "package.json" ]; then
    echo "❌ 错误: 未找到 package.json"
    exit 1
fi

# 安全检查（调用独立脚本）
echo "[2/8] 安全检查..."
if ! bash "$SCRIPT_DIR/security-check.sh"; then
    check_result=$?
    if [ $check_result -eq 1 ]; then
        echo ""
        read -p "是否继续部署？(y/N): " confirm
        if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
            echo "已取消部署"
            exit 1
        fi
    elif [ $check_result -eq 2 ]; then
        echo ""
        read -p "是否继续部署（有警告）？(y/N): " confirm
        if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
            echo "已取消部署"
            exit 1
        fi
    fi
fi

# 功能检查
echo "[3/8] 功能检查..."
if ! check_functionality; then
    echo ""
    read -p "是否继续部署？(y/N): " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo "已取消部署"
        exit 1
    fi
fi

# 安装依赖
echo "[4/8] 安装依赖..."
npm install

# 清理旧的 dist
echo "[5/8] 清理旧的构建文件..."
rm -rf docs/.vitepress/dist

# 构建项目
echo "[6/8] 构建项目..."
npm run docs:build

# 验证构建结果
echo "[7/8] 验证构建结果..."
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

# 推送代码
echo "[8/8] 推送代码..."
cd docs/.vitepress/dist

# 初始化 Git（如果需要）
if [ ! -d ".git" ]; then
    echo "初始化 Git 仓库..."
    git init
    git branch -M main
    if git remote get-url origin &>/dev/null; then
        echo "✅ 已配置远程仓库"
    else
        echo "请先配置远程仓库地址:"
        echo "  GitHub: git remote add origin https://github.com/你的用户名/仓库名.git"
        echo "  Gitee:  git remote add origin https://gitee.com/你的用户名/仓库名.git"
        exit 1
    fi
else
    echo "更新文件..."
fi

# 添加所有文件
git add .

# 检查是否有变更
if git diff --staged --quiet; then
    echo "⚠️ 没有文件变更，跳过提交"
    echo ""
    echo "========================================="
    echo "  ✅ 检查完成（无新变更）"
    echo "========================================="
    exit 0
fi

# 提交
COMMIT_MSG="${1:-更新站点内容}"
git commit -m "$COMMIT_MSG"

# 推送到远程
echo "推送代码..."
git push origin main --force

echo ""
echo "========================================="
echo "  ✅ 推送完成！"
echo "========================================="
echo ""
echo "📋 下一步操作:"
echo "1. 登录代码仓库检查 CI/CD 状态"
echo "2. 等待 GitHub Pages / Gitee Pages 部署完成"
echo ""
echo "部署完成后访问:"
echo "  GitHub: https://fatsnakeok.github.io/personal-homepage/"
echo ""
