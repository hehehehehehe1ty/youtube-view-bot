@echo off
chcp 65001>nul

:: Kiểm tra xem Docker Desktop có đang chạy không
tasklist /FI "IMAGENAME eq Docker Desktop.exe" 2>NUL | find /I /N "Docker Desktop.exe">NUL

:: Nếu Docker Desktop chưa chạy, khởi chạy nó
if "%ERRORLEVEL%"=="1" (
    echo Docker Desktop chưa được khởi chạy. Đang khởi chạy Docker Desktop...
    start "" "C:\Program Files\Docker\Docker\frontend\Docker Desktop.exe"

    :waitForDocker
    timeout /t 5 >nul
    docker info >nul 2>&1
    if "%ERRORLEVEL%"=="1" (
        goto waitForDocker
    )

    echo Docker đã khởi động xong.
) else (
    echo Docker Desktop đang chạy.
)

set /p thread=Nhập số luồng: 
echo Nhấn nút bất kì để bắt đầu...
pause >nul

npm start ytview=%thread%