@chcp 65001 >nul
@echo off
setlocal EnableExtensions
:: ------------------------------
:: 设置变量
:: ------------------------------
set "source=C:\Steam\userdata\89582913\730"
set "source_original=%OneDrive%\CS2\730-Original"
set "destination=%OneDrive%\CS2\cfg"
set "max_backups=5"

set "new_source=C:\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg"
set "new_destination=%OneDrive%\CS2\cs2"

:: ------------------------------
:: 检查 OneDrive 环境变量
:: ------------------------------
if "%OneDrive%"=="" (
    echo 环境变量 OneDrive 未定义，请检查配置。
    exit /b 1
)

:: ------------------------------
:: 检查备份源和筛选模板
:: ------------------------------
if not exist "%source%" (
    echo 无法找到 730 源目录：%source%
    exit /b 1
)
if not exist "%source_original%" (
    echo 无法找到 730-Original 筛选目录：%source_original%
    exit /b 1
)
if not exist "%new_source%" (
    echo 无法找到 CS2 CFG 目录：%new_source%
    exit /b 1
)

:: ------------------------------
:: 获取当前时间戳（WMIC 在新版 Windows 中可能不存在，改用 PowerShell）
:: ------------------------------
for /F %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do set "timestamp=%%i"
if not defined timestamp (
    echo 无法生成备份时间戳。
    exit /b 1
)

:: ------------------------------
:: 创建备份文件夹
:: ------------------------------
set backupname=730-%timestamp%
set backupfolder=%destination%\%backupname%
if not exist "%backupfolder%" mkdir "%backupfolder%"
set "missing_file=%TEMP%\cs2-backup-missing-%RANDOM%-%RANDOM%.txt"
if exist "%missing_file%" del /Q "%missing_file%"

:: ------------------------------
:: 按照 730-Original 的结构有选择地备份文件
:: ------------------------------
echo 正在根据 730-Original 目录结构备份对应文件...
for /R "%source_original%" %%F in (*) do (
    :: 获取相对路径（去掉前缀）
    set "relpath=%%F"
    setlocal enabledelayedexpansion
    set "relpath=!relpath:%source_original%=!"
    :: 拼接在 source 的对应路径
    set "target=%source%!relpath!"
    set "dest=%backupfolder%!relpath!"
    :: 检查文件是否存在于 730
    if exist "!target!" (
        :: 创建对应目录
        for %%D in ("!dest!") do if not exist "%%~dpD" mkdir "%%~dpD"
        :: 复制文件
        copy "!target!" "!dest!" /Y >nul
        if errorlevel 1 (
            echo 备份失败: !relpath!
            exit /b 1
        )
        echo 已备份: !relpath!
    ) else (
        >>"%missing_file%" echo !relpath!
    )
    endlocal
)

if exist "%missing_file%" (
    echo.
    echo 以下清单文件在游戏 730 中不存在，本次已跳过：
    type "%missing_file%"
    del /Q "%missing_file%"
) else (
    echo 730-Original 清单中的文件已全部找到并完成备份。
)

:: ------------------------------
:: 删除旧备份
:: ------------------------------
if exist "%destination%\730-*" (
    for /F "skip=%max_backups% eol=: delims=" %%i in ('dir "%destination%\730-*" /B /AD /O-D 2^>nul') do (
        echo 删除旧备份：%%i
        rmdir /S /Q "%destination%\%%i"
    )
)

:: ------------------------------
:: 备份 CS2 的 cfg 文件夹（保持不变）
:: ------------------------------
set new_backupname=cs2-%timestamp%
set new_backupfolder=%new_destination%\%new_backupname%
if not exist "%new_backupfolder%" mkdir "%new_backupfolder%"

if exist "%new_source%\autoexec.cfg" (
    copy "%new_source%\autoexec.cfg" "%new_backupfolder%" /Y
) else (
    echo autoexec.cfg 文件不存在，跳过备份
)

for /R "%new_source%" %%f in (wifi-*) do (
    if exist "%%f" (
        copy "%%f" "%new_backupfolder%" /Y
    )
)

if exist "%new_destination%\cs2-*" (
    for /F "skip=%max_backups% eol=: delims=" %%i in ('dir "%new_destination%\cs2-*" /B /AD /O-D 2^>nul') do (
        echo 删除旧备份：%%i
        rmdir /S /Q "%new_destination%\%%i"
    )
)

:: ------------------------------
:: 启动 Steam
:: ------------------------------
if not exist "C:\Steam\steam.exe" (
    echo 无法找到 Steam 客户端，请检查路径。
    exit /b 1
)
start "" "C:\Steam\steam.exe"

echo 备份完成
endlocal
exit /b 0
