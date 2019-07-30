@echo OFF
chcp 65001 1>nul
setlocal enabledelayedexpansion
REM 启用延缓环境变量
REM 此后需要预处理的变量须使用感叹号
REM before -> %var%
REM now    -> !var!

REM 在当前目录下搜索ASF主程序位置
set ASF_PATH=none
echo.
echo %date:~3,12% %time:~0,8% %date:~0,2%
echo =====================================
echo ---^> 开始在附近目录查找ASF主程序 ^<---

REM 直接查找当前目录下的可执行文件
dir %~dp0 *.exe* 2>nul | find /i "ArchiSteamFarm.exe" 1>nul
if !errorlevel! equ 0 (
    set SEARCH_PATH=%~dp0
    set ASF_PATH=!SEARCH_PATH:~0,-1!
    echo 在当前目录下查找到ASF主程序。

    echo 其路径为 [ !ASF_PATH! ]
    goto check_search_result
)
REM 递归查找当前目录下的其他文件夹
for /r /d %%i in (.) do (
    dir %%i *.exe* 2>nul | find /i "ArchiSteamFarm.exe" 1>nul
    if !errorlevel! equ 0 (
        set SEARCH_PATH=%%i
        set ASF_PATH=!SEARCH_PATH:\.=!
        echo 在当前目录下查找到ASF主程序文件夹。
        echo 其路径为 [ !ASF_PATH! ]
        goto check_search_result
    )
)

:check_search_result
if !ASF_PATH!==none (
    echo 没有检测到正确的ASF主程序！
    echo 请确认你下载了正确的版本并成功解压。
    goto end
)

REM 判断是否有拖到图标上的配置文件

if "%1"=="" (
    echo.
    echo =====================================
    echo 没有检测到需要处理的文件。
    goto check_config
)

echo.
echo =====================================
for /d %%i in (%*) do (
    echo -------- 开始处理%%i --------
    if exist %%i (
        xcopy /y %%i !ASF_PATH!\config\ >nul
        echo 将该配置文件复制到ASF主程序配置目录^(!ASF_PATH!\config\^)。
    )
)
echo =====================================
echo 所有文件处理完毕。

:check_config
echo.
echo =====================================
if exist !ASF_PATH!\config\ASF.json (
    echo 检测到config/ASF.json已配置！
) else (
    echo 缺少config/ASF.json！ASF依然可以运行，但无法使用交互式控制台。
)
echo 尝试生成/更新快捷方式ASF.ink。
goto touch_ink

:touch_ink
echo.
echo =====================================
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell"").CreateShortcut(""%~dp0ASF.lnk""):a.TargetPath=""!ASF_PATH!\ArchiSteamFarm.exe"":a.WorkingDirectory=""%~dp0"":a.Save:close")
echo 已在当前目录下生成/更新快捷方式。
echo %~dp0ASF.lnk
echo 此「快捷方式」可以随意重命名及移动到任何位置。
goto end

:end
echo.
echo %date:~3,13% %time:~0,8% %date:~0,2%
echo =====================================
echo 操作完成！按任意键退出。
pause >nul
