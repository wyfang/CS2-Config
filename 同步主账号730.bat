@chcp 65001 >nul
@echo off
setlocal EnableExtensions

:: 检查 OneDrive 是否设置
if "%OneDrive%"=="" (
    echo 错误: OneDrive 环境变量未设置
    exit /b 1
)

:: 设置源文件夹路径
set "source=%OneDrive%\CS2\cfg\730"
set "destination=C:\Steam\userdata\89582913\730"

:: 检查源文件夹是否存在
if not exist "%source%" (
    echo 错误: 源文件夹 %source% 不存在
    exit /b 1
)

:: 删除目标前，确认四个必要配置文件完整，避免误删后无法恢复
for %%F in (
    "local\cfg\cs2_machine_convars.vcfg"
    "local\cfg\cs2_user_convars_0_slot0.vcfg"
    "local\cfg\cs2_user_keys_0_slot0.vcfg"
    "local\cfg\cs2_video.txt"
) do (
    if not exist "%source%\%%~F" (
        echo 错误: 缺少必要文件 %source%\%%~F
        exit /b 1
    )
)

:: 删除目标文件夹（如果存在）
if exist "%destination%" (
    echo 正在删除目标文件夹 %destination%...
    rmdir /S /Q "%destination%"
    if errorlevel 1 (
        echo 错误: 无法删除目标文件夹 %destination%
        exit /b 1
    )
)

:: 创建目标文件夹
echo 正在创建目标文件夹 %destination%...
mkdir "%destination%"
if errorlevel 1 (
    echo 错误: 无法创建目标文件夹 %destination%
    exit /b 1
)

:: 将源文件夹中的文件复制到目标文件夹
echo 正在从 %source% 复制到 %destination%...
xcopy "%source%" "%destination%" /E /H /C /I /Y
if errorlevel 1 (
    echo 错误: 复制失败
    exit /b 1
)

echo 操作完成。
endlocal
exit /b 0
