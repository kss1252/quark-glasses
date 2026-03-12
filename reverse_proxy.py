#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
反向代理服务器
解决公网IP访问被拒绝的问题
"""

import http.server
import socketserver
import threading
import requests
from urllib.parse import urljoin

class ReverseProxyHandler(http.server.SimpleHTTPRequestHandler):
    """反向代理处理器"""
    
    def do_GET(self):
        """处理GET请求"""
        try:
            # 目标服务器地址（本地服务器）
            target_url = f"http://127.0.0.1:8000{self.path}"
            
            # 转发请求到目标服务器
            response = requests.get(target_url, timeout=10)
            
            # 设置响应头
            self.send_response(response.status_code)
            
            # 复制响应头（排除一些不需要的头部）
            for key, value in response.headers.items():
                if key.lower() not in ['connection', 'transfer-encoding']:
                    self.send_header(key, value)
            
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            
            # 发送响应内容
            self.wfile.write(response.content)
            
            print(f"✅ 成功代理: {self.path} -> {target_url}")
            
        except Exception as e:
            print(f"❌ 代理失败: {e}")
            self.send_error(500, f"代理错误: {str(e)}")
    
    def do_POST(self):
        """处理POST请求（如果需要）"""
        self.send_error(501, "POST请求暂不支持")
    
    def log_message(self, format, *args):
        """自定义日志格式"""
        print(f"🌐 {self.address_string()} - {format % args}")

def start_reverse_proxy(port=8080):
    """启动反向代理服务器"""
    try:
        with socketserver.TCPServer(("0.0.0.0", port), ReverseProxyHandler) as httpd:
            print(f"🚀 反向代理服务器已启动!")
            print(f"📍 本地访问: http://localhost:{port}")
            print(f"🌐 公网访问: http://180.172.2.31:{port}")
            print(f"🔗 代理目标: http://127.0.0.1:8000")
            print("=" * 50)
            
            # 设置超时以便优雅关闭
            httpd.timeout = 1
            
            try:
                while True:
                    httpd.handle_request()
            except KeyboardInterrupt:
                print("\n⏹️  服务器已停止")
                
    except Exception as e:
        print(f"❌ 服务器启动失败: {e}")
        if "10013" in str(e):
            print("⚠️  端口被占用，请尝试其他端口")
            print("💡 建议使用: python reverse_proxy.py 8081")

if __name__ == "__main__":
    import sys
    
    # 获取端口参数
    port = 8080
    if len(sys.argv) > 1:
        try:
            port = int(sys.argv[1])
        except ValueError:
            print("❌ 端口号必须是数字")
            sys.exit(1)
    
    print("=" * 50)
    print("🔧 夸克眼镜反向代理服务器")
    print("=" * 50)
    
    # 先检查本地服务器是否运行
    try:
        response = requests.get("http://127.0.0.1:8000", timeout=2)
        print("✅ 检测到本地服务器运行正常")
    except:
        print("⚠️  本地服务器未运行，请先启动:")
        print("    python -m http.server 8000")
        print("💡 或者同时启动本地服务器和代理...")
        
        # 启动本地服务器线程
        def start_local_server():
            import subprocess
            subprocess.run(["python", "-m", "http.server", "8000", "--bind", "127.0.0.1"])
        
        threading.Thread(target=start_local_server, daemon=True).start()
        print("🔄 正在启动本地服务器...")
        import time
        time.sleep(3)
    
    # 启动反向代理
    start_reverse_proxy(port)