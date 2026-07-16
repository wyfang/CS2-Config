@chcp 65001 >nul
@echo off
setlocal EnableExtensions

:: 检查 OneDrive 环境变量
if "%OneDrive%"=="" (
    echo 错误: OneDrive 环境变量未设置
    exit /b 1
)

:: 设置路径
set "source=%OneDrive%\CS2\cfg\730"
set "userdata_root=C:\Steam\userdata"

:: 检查源文件夹是否存在
if not exist "%source%" (
    echo 错误: 源文件夹 %source% 不存在
    exit /b 1
)

:: 删除任何账号配置前，确认四个必要文件完整
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

:: 检查目标根目录是否存在
if not exist "%userdata_root%" (
    echo 错误: 目标根目录 %userdata_root% 不存在
    exit /b 1
)

:: 遍历 userdata，只处理包含 Steam 本地配置的真实账号文件夹
set "processed=0"
for /D %%u in ("%userdata_root%\*") do (
    if exist "%%u\config\localconfig.vdf" (
        echo 正在处理 Steam 账号文件夹: %%u

        :: 删除目标文件夹（如果存在）
        if exist "%%u\730" (
            echo 正在删除目标文件夹 %%u\730...
            rmdir /S /Q "%%u\730"
            if errorlevel 1 (
                echo 错误: 无法删除目标文件夹 %%u\730
                exit /b 1
            )
        )

        :: 创建目标文件夹
        echo 正在创建目标文件夹 %%u\730...
        mkdir "%%u\730"
        if errorlevel 1 (
            echo 错误: 无法创建目标文件夹 %%u\730
            exit /b 1
        )

        :: 复制干净的四文件版本
        echo 正在从 %source% 复制到 %%u\730...
        xcopy "%source%" "%%u\730" /E /H /C /I /Y
        if errorlevel 1 (
            echo 错误: 复制操作失败
            exit /b 1
        )

        set /a processed+=1 >nul
        echo 用户文件夹 %%u 处理完成！
    ) else (
        echo 跳过非 Steam 账号文件夹: %%u
    )
)

if "%processed%"=="0" (
    echo 错误: 没有找到可同步的 Steam 账号文件夹。
    exit /b 1
)

echo 所有用户文件夹处理完成！
endlocal
exit /b 0
