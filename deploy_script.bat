@echo off
chcp 65001
echo ========================================
echo   夸克眼镜网站部署助手
echo ========================================
echo.

echo 步骤1：检查Git安装
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ 未检测到Git，请先安装Git
    echo 下载地址：https://git-scm.com/download/win
    pause
    exit /b 1
)
echo ✅ Git已安装

echo.
echo 步骤2：初始化Git仓库
git init
git add .
git commit -m "初始部署：夸克眼镜使用教程网站"

echo.
echo 步骤3：请按以下步骤完成部署：
echo.
echo 📝 手动操作指南：
echo 1. 访问 https://github.com 并登录/注册
echo 2. 点击右上角"+" -> "New repository"
echo 3. 仓库名称：quark-glasses-tutorial
echo 4. 描述：夸克眼镜使用教程网站
echo 5. 选择 Public（公开）
echo 6. 勾选 "Add a README file"
echo 7. 点击 "Create repository"
echo.
echo 8. 复制仓库的HTTPS地址（格式：https://github.com/用户名/quark-glasses-tutorial.git）
echo 9. 返回此窗口继续操作
echo.
set /p repo_url="请输入GitHub仓库地址："

echo.
echo 步骤4：推送到GitHub
git branch -M main
git remote add origin %repo_url%
git push -u origin main

echo.
echo 步骤5：启用GitHub Pages
echo ✅ 代码已推送到GitHub
echo.
echo 📋 接下来请：
echo 1. 打开您的GitHub仓库页面
echo 2. 点击 "Settings" 标签
echo 3. 左侧选择 "Pages"
echo 4. 在 "Source" 部分选择：Branch: main, Folder: / (root)
echo 5. 点击 "Save"
echo.
echo 🌐 您的网站地址将是：
echo    https://您的用户名.github.io/quark-glasses-tutorial/
echo.
echo ⏰ 部署完成后需要等待1-5分钟生效
echo.
pause