@echo off
title CyberAudit-X: Advanced Security Audit v2.1
color 0A
mode con: cols=80 lines=25
setlocal enabledelayedexpansion

REM ==================== Setup Report File ====================
set "report=CyberAudit_Report.txt"
del "%report%" >nul 2>&1

REM ==================== INTRO ANIMATION ====================
:INTRO
cls
echo.
echo  ^>^>^> Initializing CYBERAUDIT-X v2.1 ^<^<^<
echo  --------------------------------------------
timeout /t 1 >nul

for /l %%i in (1,1,5) do (
    cls
    echo.
    echo   Loading system modules
    set "progress="
    for /l %%j in (1,1,%%i) do set "progress=!progress!▓"
    for /l %%j in (%%i,1,4) do set "progress=!progress!░"
    echo  [ !progress! ]
    echo.
    echo  Establishing secure connection to kernel...
    timeout /t 1 >nul
)

REM ==================== MAIN AUDIT ====================
:AUDIT
cls
echo.
echo  ============================================
echo           C Y B E R A U D I T - X
echo  ============================================
echo.
echo  Audit started at: %time% on %date% >> %report%
echo  ============================================ >> %report%
echo. >> %report%

REM 1. System Information
call :LOADING "Collecting system information"
echo  [SYSTEM INFO]
echo  --------------------------------------------
echo  [SYSTEM INFO] >> %report%
echo  -------------------------------------------- >> %report%
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Boot Time" >> %report%
echo. >> %report%

REM 2. User Accounts
call :LOADING "Analyzing user accounts"
echo  [USER ACCOUNTS]
echo  --------------------------------------------
echo  [USER ACCOUNTS] >> %report%
echo  -------------------------------------------- >> %report%
net user | findstr /V "The command completed" >> %report%
echo. >> %report%

REM 3. Running Processes
call :LOADING "Scanning running processes"
echo  [CRITICAL PROCESSES]
echo  --------------------------------------------
echo  [CRITICAL PROCESSES] >> %report%
echo  -------------------------------------------- >> %report%
tasklist /FI "IMAGENAME eq explorer.exe" >> %report%
tasklist /FI "IMAGENAME eq svchost.exe" >> %report%
tasklist /FI "IMAGENAME eq winlogon.exe" >> %report%
echo. >> %report%

REM 4. Network Configuration
call :LOADING "Checking network configuration"
echo  [NETWORK CONFIGURATION]
echo  --------------------------------------------
echo  [NETWORK CONFIGURATION] >> %report%
echo  -------------------------------------------- >> %report%
ipconfig /all | findstr /C:"IPv4" /C:"Subnet" /C:"Default Gateway" >> %report%
echo. >> %report%

REM 5. Firewall Status
call :LOADING "Verifying firewall status"
echo  [FIREWALL STATUS]
echo  --------------------------------------------
echo  [FIREWALL STATUS] >> %report%
echo  -------------------------------------------- >> %report%
netsh advfirewall show allprofiles | findstr "State" >> %report%
echo. >> %report%

REM 6. Installed Hotfixes
call :LOADING "Checking system updates"
echo  [INSTALLED HOTFIXES]
echo  --------------------------------------------
echo  [INSTALLED HOTFIXES] >> %report%
echo  -------------------------------------------- >> %report%
wmic qfe list brief >> %report%
echo. >> %report%

REM ==================== END SCREEN ====================
:EXIT
echo  ============================================
echo  Audit completed at: %time% on %date%
echo  ============================================
echo.
echo  Results saved to: %CD%\%report%
echo.
pause >nul

REM Cool exit sequence
for %%i in ("Shutting down" "Cleaning up" "Securing channels" "Complete!") do (
    cls
    echo.
    echo  ^>^>^> %%i ^<^<^<
    timeout /t 1 >nul
)
exit /b 0

REM ==================== LOADING FUNCTION ====================
:LOADING
setlocal
set "frames=⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏"
for /l %%n in (1,1,2) do (
    for %%f in (%frames%) do (
        cls
        echo.
        echo  ============================================
        echo           C Y B E R A U D I T - X
        echo  ============================================
        echo.
        echo  [ %%f ] %~1
        timeout /t 0.1 >nul
    )
)
endlocal
exit /b
