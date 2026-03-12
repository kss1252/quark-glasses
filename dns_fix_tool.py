#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
DNS问题诊断和修复工具
专门解决GitHub Pages自定义域名DNS配置问题
"""

import subprocess
import socket
import requests
import time

def check_dns_resolution(domain):
    """检查DNS解析"""
    print(f"🔍 检查 {domain} 的DNS解析...")
    
    try:
        # 使用nslookup检查
        result = subprocess.run(['nslookup', domain], 
                              capture_output=True, text=True)
        if result.returncode == 0:
            print("✅ DNS解析正常")
            print(result.stdout)
            return True
        else:
            print("❌ DNS解析失败")
            print(result.stderr)
            return False
    except Exception as e:
        print(f"❌ 检查DNS时出错: {e}")
        return False

def check_github_pages_status():
    """检查GitHub Pages服务状态"""
    print("\n🌐 检查GitHub Pages服务状态...")
    
    try:
        response = requests.get('https://www.githubstatus.com/api/v2/components.json', timeout=10)
        if response.status_code == 200:
            data = response.json()
            for component in data['components']:
                if 'pages' in component['name'].lower():
                    status = component['status']
                    print(f"GitHub Pages状态: {status}")
                    return status == 'operational'
    except Exception as e:
        print(f"❌ 无法检查GitHub状态: {e}")
    
    return False

def check_custom_domain_config():
    """检查自定义域名配置指南"""
    print("\n📋 自定义域名配置检查清单:")
    print("1. ✅ 域名已注册并有效")
    print("2. ✅ DNS记录已配置:")
    print("   - 类型: CNAME 或 A")
    print("   - 名称: www (或 @ 对于根域名)")
    print("   - 值: 用户名.github.io")
    print("3. ✅ GitHub仓库设置:")
    print("   - Settings → Pages → Custom domain")
    print("   - 输入您的自定义域名")
    print("   - 勾选 Enforce HTTPS")
    print("4. ✅ 等待DNS传播 (最多24小时)")

def dns_troubleshooting_steps():
    """DNS问题排查步骤"""
    print("\n🚀 DNS问题排查步骤:")
    print("1. 清除本地DNS缓存:")
    print("   Windows: ipconfig /flushdns")
    print("   Mac/Linux: sudo dscacheutil -flushcache")
    print("\n2. 检查DNS记录是否正确:")
    print("   访问: https://dnschecker.org")
    print("   输入您的域名，查看全球DNS解析")
    print("\n3. 验证GitHub Pages配置:")
    print("   确保GitHub仓库中已正确设置自定义域名")
    print("\n4. 测试备用DNS服务器:")
    print("   临时使用: 8.8.8.8 (Google DNS)")

def main():
    print("=" * 60)
    print("          DNS问题诊断工具 - GitHub Pages")
    print("=" * 60)
    
    # 检查基础DNS
    check_dns_resolution("github.com")
    check_dns_resolution("pages.github.com")
    
    # 检查GitHub Pages状态
    github_ok = check_github_pages_status()
    
    # 显示配置指南
    check_custom_domain_config()
    
    # 显示问题排查步骤
    dns_troubleshooting_steps()
    
    print("\n" + "=" * 60)
    print("💡 如果问题持续存在，请提供以下信息:")
    print("1. 您使用的具体域名")
    print("2. 完整的错误信息")
    print("3. DNS配置的截图")
    print("=" * 60)

if __name__ == "__main__":
    main()