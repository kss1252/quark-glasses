@echo off
chcp 65001 >nul
echo.
echo ================================================
echo                DNS问题诊断助手
echo ================================================
echo.

echo 📊 正在检查DNS配置...
echo.

echo 🔍 检查本地DNS解析：
nslookup github.com
nslookup pages.github.com
echo.

echo 🌐 检查网络连接：
ping -n 3 github.com
ping -n 3 8.8.8.8
echo.

echo ================================================
echo                DNS问题解决方案
echo ================================================
echo.

echo ❌ 常见问题及解决方案：
echo.
echo 1. DNS配置错误
echo    症状：无法解析域名
echo    解决：检查DNS记录是否正确配置
echo.
echo 2. DNS传播延迟
echo    症状：新配置的DNS需要时间生效
echo    解决：等待24-48小时
echo.
echo 3. 本地DNS缓存
echo    症状：本地电脑缓存了旧的DNS记录
echo    解决：清除DNS缓存
echo.
echo 4. 域名注册商问题
echo    症状：域名未正确指向GitHub
echo    解决：检查域名管理后台设置
echo.
echo ================================================
echo                 立即解决方案
echo ================================================
echo.

echo 🚀 快速修复步骤：
echo.
echo 步骤1：清除本地DNS缓存
echo   以管理员身份运行命令提示符，执行：
echo   ipconfig /flushdns
echo.
echo 步骤2：检查DNS记录
echo   访问：https://dnschecker.org
echo   输入您的域名，检查全球DNS解析
echo.
echo 步骤3：临时使用公共DNS
echo   修改网络设置，DNS服务器设为：
echo   首选：8.8.8.8（Google DNS）
echo   备用：1.1.1.1（Cloudflare DNS）
echo.
echo 步骤4：验证GitHub Pages状态
echo   访问：https://www.githubstatus.com
echo   检查GitHub Pages服务是否正常
echo.
echo ================================================
echo                 详细诊断流程
echo ================================================
echo.
echo 📋 请提供以下信息以便更精确诊断：
echo.
echo 1. 您使用的域名是什么？
echo 2. 错误信息的具体内容？
echo 3. 什么时候开始出现这个问题？
echo 4. 您是否已经配置了DNS记录？
echo.
pause