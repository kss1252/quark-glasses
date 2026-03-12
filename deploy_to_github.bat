@echo off
chcp 65001 >nul
echo.
echo ================================================
echo            GitHub Pages 一键部署助手
echo ================================================
echo.

REM 检查Git是否安装
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 未检测到Git，请先安装Git
    echo 📥 下载地址：https://git-scm.com/downloads
    echo 安装完成后重新运行此脚本
    pause
    exit /b 1
)

echo ✅ Git已安装

REM 检查当前目录是否为Git仓库
git status >nul 2>&1
if errorlevel 1 (
    echo 📁 初始化Git仓库...
    git init
    git add .
    git commit -m "Initial commit: Add Quark glasses tutorial website"
    echo ✅ Git仓库初始化完成
) else (
    echo ✅ 当前目录已经是Git仓库
)

echo.
echo 📋 项目文件清单：
dir /b | findstr /v "deploy_to_github.bat"

echo.
echo ================================================
echo                 部署步骤说明
echo ================================================
echo.
echo 请按照以下步骤完成GitHub Pages部署：
echo.
echo 1. 📝 创建GitHub仓库：
echo    - 访问 https://github.com/new
echo    - 仓库名：quark-glasses-tutorial
echo    - 描述：夸克眼镜使用教程展示网站
echo    - 选择Public，勾选Add README
echo.
echo 2. 🔗 连接远程仓库（复制以下命令执行）：
echo    git remote add origin https://github.com/您的用户名/quark-glasses-tutorial.git
echo    git branch -M main
echo    git push -u origin main
echo.
echo 3. 🌐 启用GitHub Pages：
echo    - 在GitHub仓库页面点击Settings
echo    - 左侧选择Pages
echo    - Source选择：Deploy from a branch
echo    - Branch选择：main，文件夹选择：/(root)
echo    - 点击Save
echo.
echo 4. ✅ 验证部署：
echo    - 等待1-5分钟
echo    - 访问：https://您的用户名.github.io/quark-glasses-tutorial/
echo.
echo ================================================
echo                  重要提示
echo ================================================
echo.
echo 💡 部署完成后，您的网站将通过以下地址访问：
echo    https://您的用户名.github.io/quark-glasses-tutorial/
echo.
echo 💡 如需更新内容，只需修改文件后执行：
echo    git add .
echo    git commit -m "更新描述"
echo    git push origin main
echo.
echo 💡 详细部署指南请查看 README_GITHUB_PAGES.md 文件
echo.

REM 显示当前Git状态
echo 📊 当前Git状态：
git status --short

echo.
echo 🎉 部署文件已准备就绪！
echo 请按照上面的步骤完成GitHub Pages部署。
echo.
pause