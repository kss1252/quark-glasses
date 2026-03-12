# 夸克眼镜网站免费部署指南

## 🆓 免费部署选项对比

| 部署平台 | 费用 | 国内访问速度 | 部署难度 | 推荐指数 |
|---------|-----|------------|---------|----------|
| GitHub Pages | 完全免费 | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Netlify | 完全免费 | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐ |
| Vercel | 完全免费 | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐ |
| 腾讯云静态网站 | 免费额度 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |

## 🚀 推荐方案：GitHub Pages（最稳定免费）

### 步骤1：创建GitHub仓库
1. 访问 [GitHub.com](https://github.com) 并注册/登录
2. 点击右上角"+" → "New repository"
3. 填写仓库信息：
   - Repository name: `quark-glasses-tutorial`
   - Description: "夸克眼镜使用教程网站"
   - 选择 Public（公开）
   - 勾选 "Add a README file"

### 步骤2：上传网站文件
4. 在仓库页面点击 "Add file" → "Upload files"
5. 将以下文件拖拽上传：
   - `index.html`
   - `styles.css` 
   - `pdf_content.json`
   - `README.md`

### 步骤3：启用GitHub Pages
6. 进入仓库设置：Settings → Pages
7. 在 "Source" 部分选择：
   - Branch: `main`
   - Folder: `/` (root)
8. 点击 "Save"

### 步骤4：获取访问链接
9. 等待几分钟后，访问链接将显示在Pages设置页面
10. 您的网站地址将是：
    ```
    https://您的用户名.github.io/quark-glasses-tutorial/
    ```

## ⚡ 快速部署方法

### 方法A：使用Git命令（推荐给有Git经验的用户）
```bash
# 在项目文件夹中执行
git init
git add .
git commit -m "初始提交：夸克眼镜使用教程网站"
git branch -M main
git remote add origin https://github.com/您的用户名/quark-glasses-tutorial.git
git push -u origin main
```

### 方法B：使用GitHub Desktop（图形化界面）
1. 下载安装 [GitHub Desktop](https://desktop.github.com/)
2. 克隆仓库到本地
3. 将网站文件复制到仓库文件夹
4. 提交并推送更改

## 🔄 更新网站内容

当您需要更新PDF内容时：

1. **本地更新PDF内容**
```bash
pip install pypdf
python pdf_extractor_real.py "E:/桌面/夸克眼镜使用教程.pdf" pdf_content.json
```

2. **上传更新到GitHub**
```bash
git add pdf_content.json
git commit -m "更新PDF内容"
git push origin main
```

3. **GitHub Pages会自动更新**（通常1-5分钟）

## 🌐 部署成功后的访问

一旦部署完成，您的网站将可以通过以下地址访问：
- **主域名**: `https://您的用户名.github.io/quark-glasses-tutorial/`
- **备用域名**: `https://您的用户名.github.io/quark-glasses-tutorial/index.html`

## 📱 二维码分享

您可以使用在线工具生成二维码，方便手机用户扫描访问：
1. 访问 [QR Code Generator](https://www.qr-code-generator.com/)
2. 输入您的网站地址
3. 下载并分享二维码

## 💡 部署小贴士

1. **文件命名**: 确保所有文件名使用英文，避免中文文件名
2. **路径大小写**: GitHub Pages对路径大小写敏感
3. **缓存问题**: 首次部署后如有显示问题，尝试清除浏览器缓存
4. **HTTPS**: GitHub Pages自动启用HTTPS，安全可靠

## 🆘 常见问题解决

**问题**: 网站显示404错误
**解决**: 检查仓库名称是否与Pages设置中的路径一致

**问题**: 样式文件加载失败  
**解决**: 确认CSS文件路径正确，使用相对路径`styles.css`

**问题**: PDF内容未更新
**解决**: 等待GitHub Pages缓存刷新（最多10分钟）

---

**部署状态**: ✅ 已准备就绪
**预计完成时间**: 10-15分钟
**永久免费**: ✅ 是
**支持自定义域名**: ✅ 是（可选）