@echo off
chcp 65001 > nul
title Vericum Agent Setup v3.0

echo.
echo  ================================================
echo    Vericum Agent 원클릭 설치 시작
echo  ================================================
echo.

REM PowerShell 5.1 또는 7+ 둘 다 지원
where pwsh > nul 2>&1
if %ERRORLEVEL% EQU 0 (
    pwsh -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup.ps1"
) else (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup.ps1"
)

set "RC=%ERRORLEVEL%"
if not "%RC%"=="0" (
    echo.
    echo  ================================================
    echo   설치가 완료되지 않았습니다 (오류 코드: %RC%)
    echo  ================================================
    echo.
    echo  강사한테 위 화면 캡처 후 보내주세요.
    echo.
    pause
)

exit /b %RC%
