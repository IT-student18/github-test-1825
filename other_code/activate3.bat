@echo off
title Activate Microsoft Office 2016 (ALL versions) for FREE - MSGuides.com
cls
echo =====================================================================================
echo #Project: Activating Microsoft software products for FREE without additional software
echo =====================================================================================
echo.
echo #Supported products:
echo - Microsoft Office Standard 2016
echo - Microsoft Office Professional Plus 2016
echo.
echo.

setlocal enabledelayedexpansion

if exist "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" (
    set "officePath=%ProgramFiles%\Microsoft Office\Office16"
) else if exist "%ProgramFiles(x86)%\Microsoft Office\Office16\ospp.vbs" (
    set "officePath=%ProgramFiles(x86)%\Microsoft Office\Office16"
) else (
    echo Microsoft Office 2016 not found.
    pause
    exit
)

cd /d "%officePath%"

echo =====================================================================================
echo Activating your product...
echo.

:: Install license file
for /f %%x in ('dir /b ..\root\Licenses16\ProPlus2016VL_KMS*.xrm-ms') do (
    if exist "..\root\Licenses16\%%x" (
        cscript ospp.vbs /inslic:"..\root\Licenses16\%%x" >nul
    ) else (
        echo License file not found: ..\root\Licenses16\%%x
    )
)

:: Clear KMS server
cscript //nologo ospp.vbs /ckms >nul

:: Set KMS server port
cscript //nologo ospp.vbs /setprt:1688 >nul

:: Uninstall previous key
cscript //nologo ospp.vbs /unpkey:WFG99 >nul

:: Install new key
cscript //nologo ospp.vbs /inpkey:GNHM9-FXJQ6-937QT-466JP-Q8HQR >nul

set i=1

:skms
if %i% GTR 10 goto busy
if %i% EQU 1 set KMS=kms7.MSGuides.com
if %i% EQU 2 set KMS=107.175.77.7
if %i% GTR 2 goto ato

cscript //nologo ospp.vbs /sethst:%KMS% >nul

:ato
echo =====================================================================================
echo.
echo.
cscript //nologo ospp.vbs /act | find /i "successful" && (
    echo.
    echo =====================================================================================
    echo.
    echo #My official blog: MSGuides.com
    echo.