@echo off
chcp 65001 >nul
echo.
echo 📄 夸克眼镜使用教程 - PDF图片提取工具
echo =============================================
echo.

REM 检查Python是否安装
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 未检测到Python，请先安装Python 3.7+
    echo 下载地址: https://www.python.org/downloads/
    pause
    exit /b 1
)

REM 检查依赖库
python -c "import fitz" 2>nul
if errorlevel 1 (
    echo 📦 正在安装必要的依赖库...
    pip install PyMuPDF pillow
    if errorlevel 1 (
        echo ❌ 依赖库安装失败，请手动运行: pip install PyMuPDF pillow
        pause
        exit /b 1
    )
    echo ✅ 依赖库安装成功
)

REM 检查PDF文件是否存在
dir "夸克眼镜使用教程.pdf" >nul 2>&1
if errorlevel 1 (
    echo ❌ 未找到PDF文件: 夸克眼镜使用教程.pdf
    echo 📁 当前目录文件列表:
    dir *.pdf
    echo.
    echo 💡 请将PDF文件放在当前目录下
    pause
    exit /b 1
)

REM 创建输出目录
if not exist "pdf_images" mkdir pdf_images

REM 执行PDF转图片
echo.
echo 🚀 开始转换PDF为图片...
echo.
python pdf_to_image_extractor.py "夸克眼镜使用教程.pdf" -o "pdf_images" -d 150 -f PNG

if errorlevel 1 (
    echo ❌ PDF转换失败
    pause
    exit /b 1
)

REM 复制图片到网站目录
if exist "pdf_images" (
    echo.
    echo 📁 正在复制图片到网站目录...
    xcopy "pdf_images" "." /E /I /Y >nul 2>&1
    echo ✅ 图片文件已准备就绪
)

REM 打开图片预览
echo.
echo 🎉 PDF图片提取完成！
echo 📊 转换统计:
dir "pdf_images\*.png" /b | find /c /v "" >nul 2>&1
if errorlevel 1 (
    echo ❌ 未找到生成的图片文件
) else (
    for /f %%i in ('dir "pdf_images\*.png" /b ^| find /c /v ""') do set count=%%i
    echo ✅ 成功生成 %count% 张PNG图片
)

echo.
echo 📋 下一步操作:
echo 1. 双击打开 pdf_image_viewer.html 查看效果
echo 2. 如需修改图片路径，编辑 pdf_image_viewer.html 文件
echo 3. 使用GitHub Pages部署网站
echo.

REM 询问是否打开预览
set /p "open=是否立即打开图片预览? (Y/N): "
if /i "%open%"=="Y" if /i "%open%"=="y" (
    echo 🔗 正在打开图片预览...
    start "" "pdf_images\index.html"
)

echo.
echo 💡 提示: 如需重新转换，请删除 pdf_images 文件夹后重新运行此脚本
pause