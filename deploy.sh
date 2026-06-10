#!/bin/bash

# 空杯成长笔记 - 一键发布脚本
# 用法: ./deploy.sh "提交信息"

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查是否在项目根目录
check_project_root() {
    if [ ! -f "package.json" ] || [ ! -d "docs" ]; then
        print_error "请在项目根目录执行此脚本"
        exit 1
    fi
}

# 检查 git 状态
check_git_status() {
    if git diff-index --quiet HEAD --; then
        print_info "没有检测到未提交的更改"
        return 1
    else
        print_warning "检测到未提交的更改："
        git status --short
        return 0
    fi
}

# 安装依赖
install_dependencies() {
    print_info "检查依赖..."
    if [ ! -d "node_modules" ]; then
        print_info "安装依赖中..."
        npm install
        print_success "依赖安装完成"
    else
        print_success "依赖已存在"
    fi
}

# 构建项目
build_project() {
    print_info "构建项目中..."
    npm run docs:build
    print_success "构建完成"
}

# 提交代码
commit_changes() {
    local message="$1"
    
    if [ -z "$message" ]; then
        # 获取默认提交信息
        local changed_files=$(git diff --name-only --cached 2>/dev/null || git diff --name-only)
        local post_count=$(echo "$changed_files" | grep -c "docs/posts/" || echo "0")
        
        if [ "$post_count" -gt 0 ]; then
            message="Add/update $post_count article(s)"
        else
            message="Update site content"
        fi
    fi
    
    print_info "提交代码: $message"
    git add .
    git commit -m "$message"
    print_success "代码已提交"
}

# 推送到远程
push_to_remote() {
    local branch=$(git rev-parse --abbrev-ref HEAD)
    
    print_info "推送到远程仓库 ($branch)..."
    git push origin "$branch"
    print_success "代码已推送"
}

# 显示部署状态
show_deployment_info() {
    local remote_url=$(git remote get-url origin 2>/dev/null || echo "")
    
    echo ""
    echo "=========================================="
    print_success "发布流程已完成！"
    echo "=========================================="
    echo ""
    echo "后续步骤："
    echo "1. 访问 GitHub Actions 页面查看部署状态："
    
    if [ -n "$remote_url" ]; then
        # 转换 git URL 为 HTTPS URL
        local repo_url=$(echo "$remote_url" | sed 's/git@github.com:/https:\/\/github.com\//' | sed 's/\.git$//')
        echo "   ${repo_url}/actions"
    fi
    
    echo ""
    echo "2. 部署完成后，访问网站查看效果"
    echo ""
    echo "3. 如需回滚，可在 Actions 页面重新运行上一次成功的工作流"
    echo ""
}

# 主函数
main() {
    local commit_message="$1"
    
    echo ""
    echo "=========================================="
    echo "  空杯成长笔记 - 一键发布脚本"
    echo "=========================================="
    echo ""
    
    # 步骤 1: 检查项目根目录
    print_info "步骤 1/5: 检查项目环境"
    check_project_root
    print_success "项目环境检查通过"
    echo ""
    
    # 步骤 2: 检查 git 状态
    print_info "步骤 2/5: 检查代码状态"
    local has_changes=0
    check_git_status || has_changes=$?
    
    if [ $has_changes -eq 0 ]; then
        echo ""
        read -p "是否继续提交这些更改? (y/n): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_warning "发布已取消"
            exit 0
        fi
    fi
    echo ""
    
    # 步骤 3: 安装依赖
    print_info "步骤 3/5: 安装依赖"
    install_dependencies
    echo ""
    
    # 步骤 4: 构建项目
    print_info "步骤 4/5: 构建项目"
    build_project
    echo ""
    
    # 步骤 5: 提交并推送
    print_info "步骤 5/5: 提交并推送代码"
    
    if [ $has_changes -eq 0 ]; then
        commit_changes "$commit_message"
    else
        print_info "没有需要提交的更改"
    fi
    
    push_to_remote
    echo ""
    
    # 显示部署信息
    show_deployment_info
}

# 运行主函数
main "$@"
