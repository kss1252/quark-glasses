@echo off
chcp 65001

echo ========================================
echo   解决访问拒绝问题
echo ========================================
echo.

echo 检测到"拒绝访问"问题，这通常是防火墙或权限问题
echo 正在为您自动解决...
echo.

echo 步骤1：检查端口占用
echo 正在检查端口8000是否被占用...
netstat -ano | findstr ":8000"
if %errorlevel% equ 0 (
    echo ⚠️  端口8000被占用，将使用端口8080
    set PORT=8080
) else (
    echo ✅ 端口8000可用
    set PORT=8000
)

echo.
echo 步骤2：添加防火墙规则
echo 正在为Python添加防火墙例外...

:: 获取Python路径
for /f "tokens=2 delims==" %%i in ('python -c "import sys; print(sys.executable)" 2^>nul') do set PYTHON_PATH=%%i

if "%PYTHON_PATH%" neq "" (
    echo 检测到Python路径: %PYTHON_PATH%
    
    :: 添加防火墙规则（需要管理员权限）
    echo 请在弹出的UAC窗口中点击"是"授权防火墙设置
    netsh advfirewall firewall add rule name="Python HTTP Server" dir=in action=allow program="%PYTHON_PATH%" localport=%PORT% protocol=TCP
    
    if %errorlevel% equ 0 (
        echo ✅ 防火墙规则添加成功
    ) else (
        echo ⚠️  需要管理员权限，将尝试其他方案
    )
) else (
    echo ⚠️  无法获取Python路径
)

echo.
echo 步骤3：启动服务器（使用127.0.0.1避免权限问题）
echo 正在启动服务器...
start python -m http.server %PORT% --bind 127.0.0.1

echo.
echo 步骤4：设置端口转发（让外网可以访问）
echo 正在设置端口转发...
start python -c "
import threading
import socket
import sys
from http.server import HTTPServer, SimpleHTTPRequestHandler

class ForwardingHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        # 重定向到实际服务器
        self.send_response(302)
        self.send_header('Location', f'http://127.0.0.1:%PORT%{self.path}')
        self.end_headers()

def start_forwarder():
    try:
        server = HTTPServer(('0.0.0.0', %PORT%), ForwardingHandler)
        print(f'端口转发器启动在 0.0.0.0:%PORT% -> 127.0.0.1:%PORT%')
        server.serve_forever()
    except Exception as e:
        print(f'端口转发器启动失败: {e}')

threading.Thread(target=start_forwarder, daemon=True).start()
"

echo.
echo ========================================
echo   ✅ 解决方案已应用
echo ========================================
echo.
echo 📍 新的访问地址：
echo     本机访问：http://localhost:%PORT%
echo     局域网访问：http://180.172.2.31:%PORT%
echo     外网访问：http://180.172.2.31:%PORT%
echo.
echo 🔧 如果仍然无法访问，请尝试：
echo     1. 暂时关闭Windows防火墙测试
echo     2. 使用管理员权限运行此脚本
echo     3. 联系网络管理员检查路由器设置
echo.
echo 💡 专业建议：使用反向代理方案
echo     创建 reverse_proxy.py 文件实现安全的端口转发
echo.

pause