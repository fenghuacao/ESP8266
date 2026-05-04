@echo off
chcp 65001 >nul
title Build Android APK

echo ============================================
echo   ESP8266 Servo Controller - Build APK
echo ============================================
echo.

where dotnet >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] dotnet not found. Install .NET SDK 9.0
    echo         https://dotnet.microsoft.com/download/dotnet/9.0
    pause
    exit /b 1
)

echo [1/3] Restoring NuGet packages...
call dotnet restore "AndroidApp1\AndroidApp1.csproj"
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Restore failed
    pause
    exit /b 1
)
echo Done.

echo [2/3] Cleaning old build...
call dotnet clean "AndroidApp1\AndroidApp1.csproj" -c Release -f net9.0-android >nul 2>&1
echo Done.

echo [3/3] Building Release APK...
call dotnet publish "AndroidApp1\AndroidApp1.csproj" -f net9.0-android -c Release -p:AndroidPackageFormat=apk -p:ApplicationVersion=1 -p:ApplicationDisplayVersion=1.0

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ============================================
    echo   BUILD SUCCESS
    echo ============================================
    echo.
    echo Output folder:
    echo   AndroidApp1\bin\Release\net9.0-android\
    echo.
    dir /s /b "AndroidApp1\bin\Release\net9.0-android\*.apk" 2>nul
    echo.
    echo To install:
    echo   1. Copy APK to your phone
    echo   2. Open APK and install
    echo   3. Make sure phone + ESP8266 on same WiFi
) else (
    echo.
    echo [ERROR] Build failed
)

pause
