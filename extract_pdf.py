#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from pypdf import PdfReader
import os

def extract_pdf_content(pdf_path):
    """提取PDF文件内容"""
    try:
        reader = PdfReader(pdf_path)
        total_pages = len(reader.pages)
        print(f"PDF文件总页数: {total_pages}")
        
        content = ""
        for i, page in enumerate(reader.pages):
            page_text = page.extract_text()
            content += f"\n=== 第{i+1}页 ===\n{page_text}\n"
        
        return content, total_pages
    except Exception as e:
        print(f"读取PDF时出错: {e}")
        return None, 0

if __name__ == "__main__":
    pdf_file = "E:/桌面/夸克眼镜使用教程.pdf"
    
    if os.path.exists(pdf_file):
        content, pages = extract_pdf_content(pdf_file)
        if content:
            print("PDF内容提取成功！")
            print(content)
            
            # 保存内容到文件
            with open("pdf_content.txt", "w", encoding="utf-8") as f:
                f.write(content)
            print("内容已保存到 pdf_content.txt")
        else:
            print("无法提取PDF内容")
    else:
        print(f"PDF文件不存在: {pdf_file}")