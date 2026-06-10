#!/usr/bin/env node

/**
 * 部署脚本 - Node.js 包装器
 * 调用 deploy.sh 进行安全检查和部署
 */

const { execSync } = require('child_process');
const path = require('path');

// 获取项目根目录
const rootDir = path.resolve(__dirname, '..');

console.log('=========================================');
console.log('  空杯成长笔记 - 部署工具');
console.log('=========================================');
console.log('');

// 执行 deploy.sh
const deployScript = path.join(rootDir, 'deploy.sh');

try {
    console.log('正在执行部署脚本...\n');
    execSync(`bash "${deployScript}"`, {
        cwd: rootDir,
        stdio: 'inherit'
    });
} catch (error) {
    console.error('\n❌ 部署失败:', error.message);
    process.exit(1);
}
