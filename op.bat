@echo off
title CyberAudit-X: Security Audit v2.1
color 0A
mode con: cols=90 lines=30
setlocal enabledelayedexpansion

:: Set report file name
set "report=CyberAudit_Report.txt"
del "%report%" >nul 2>&1

:: Display banner
cls
echo ====================================================
echo             C Y B E R A U D I T - X  v2.1
echo ====================================================
echo Initializing audit...
echo.
echo Report will be saved to: %CD%\%report%
echo ====================================================
echo.

:: START AUDIT
echo [*] Collecting System Info...
echo ------------- SYSTEM INFO ------------- >> "%report%"
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Boot Time" >> "%report%"
echo. >> "%report%"

echo [*] Listing User Accounts...
echo ------------- USER ACCOUNTS ------------- >> "%report%"
net user | findstr /V "The command completed" >> "%report%"
echo. >> "%report%"

echo [*] Checking Running Processes...
echo ------------- CRITICAL PROCESSES ------------- >> "%report%"
tasklist /FI "IMAGENAME eq explorer.exe" >> "%report%"
tasklist /FI "IMAGENAME eq svchost.exe" >> "%report%"
tasklist /FI "IMAGENAME eq winlogon.exe" >> "%report%"
echo. >> "%report%"

echo [*] Getting Network Configuration...
echo ------------- NETWORK CONFIGURATION ------------- >> "%report%"
ipconfig | findstr /C:"IPv4" /C:"Subnet" /C:"Default Gateway" >> "%report%"
echo. >> "%report%"

echo [*] Verifying Firewall Status...
echo ------------- FIREWALL STATUS ------------- >> "%report%"
netsh advfirewall show allprofiles | findstr "State" >> "%report%"
echo. >> "%report%"

echo [*] Checking Installed Hotfixes...
echo ------------- INSTALLED HOTFIXES ------------- >> "%report%"
wmic qfe list brief >> "%report%"
echo. >> "%report%"

:: END
echo ====================================================
echo Audit complete. Report saved to: %report%
echo Done at: %time% on %date%
echo ====================================================
pause
