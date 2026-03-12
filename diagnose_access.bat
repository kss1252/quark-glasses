@echo off
chcp 65001

echo ========================================
echo   访问问题诊断工具
echo ========================================
echo.

echo 步骤1：检查端口占用情况
netstat -an | findstr ":8000"
echo.

echo 步骤2：检查防火墙状态
netsh advfirewall show allprofiles | findstr "状态"
echo.

echo 步骤3：尝试启动服务器（测试模式）
echo 正在启动Python服务器...
python -m http.server 8000 --bind 127.0.0.1

if %errorlevel% neq 0 (
    echo.
    echo ❌ 服务器启动失败，可能是端口被占用
    echo 请尝试使用其他端口：
    echo    python -m http.server 8080
    echo.
    pause
    exit /b 1
)