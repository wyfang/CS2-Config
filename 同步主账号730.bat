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
set "cfg_source=%OneDrive%\CS2\cs2\cs2"
set "cfg_destination=C:\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg"

:: 检查源文件夹是否存在
if not exist "%source%" (
    echo 错误: 源文件夹 %source% 不存在
    exit /b 1
)

:: 检查 CFG 恢复源和游戏 CFG 目录是否存在
if not exist "%cfg_source%" (
    echo 错误: CFG 源文件夹 %cfg_source% 不存在
    exit /b 1
)

if not exist "%cfg_destination%" (
    echo 错误: 游戏 CFG 目录 %cfg_destination% 不存在
    exit /b 1
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

:: 将恢复源中的全部文件直接复制到新的 730
echo 正在从 %source% 复制到 %destination%...
xcopy "%source%" "%destination%" /E /H /C /I /Y
if errorlevel 1 (
    echo 错误: 复制失败
    exit /b 1
)

:: 不清空游戏 CFG 目录，只覆盖恢复源中存在的 CFG 文件
echo 正在从 %cfg_source% 恢复 CFG 到 %cfg_destination%...
xcopy "%cfg_source%\*" "%cfg_destination%\" /E /H /C /I /Y
if errorlevel 1 (
    echo 错误: CFG 复制失败
    exit /b 1
)

echo 操作完成。
endlocal
exit /b 0
