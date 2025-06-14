# Save this as SendScreenshot.ps1 and run in PowerShell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bitmap = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)

$file = "$env:TEMP\screenshot.png"
$bitmap.Save($file, [System.Drawing.Imaging.ImageFormat]::Png)
$bitmap.Dispose()
$graphics.Dispose()

$botToken = "YOUR_BOT_TOKEN"
$chatId = "YOUR_USER_ID"
$uri = "https://api.telegram.org/bot$botToken/sendPhoto"

$form = @{ chat_id = $chatId; photo = Get-Item $file }
Invoke-RestMethod -Uri $uri -Method Post -Form $form

Remove-Item $file
