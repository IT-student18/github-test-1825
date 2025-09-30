@echo off
setlocal enabledelayedexpansion

:: Checking Windows activation
echo Checking Windows activation...
slmgr.vbs /xpr
if %errorlevel% == 0 (
    echo Windows is activated.
) else (
    echo Windows is not activated.
)

:: Checking for Microsoft Office installation by looking for executable files
echo Checking for Microsoft Office installation...
set "office_installed=0"

:: Check for Word
where /q winword.exe
if !errorlevel! == 0 (
    echo Microsoft Word is installed.
    set "office_installed=1"
)

:: Check for Excel
where /q excel.exe
if !errorlevel! == 0 (
    echo Microsoft Excel is installed.
    set "office_installed=1"
)

:: Check for PowerPoint
where /q powerpnt.exe
if !errorlevel! == 0 (
    echo Microsoft PowerPoint is installed.
    set "office_installed=1"
)

if !office_installed! == 0 (
    echo Microsoft Office is not installed.
)

:: Expected string for checking
set "expected_string=qwertyuiopasdfghjklzxcvbnm[];'\.,/`1234567890-="

:: Input printable characters
echo.
echo Please enter the following characters:
echo %expected_string%
set /p user_input="Input: "
echo You entered: !user_input!

:: Checking for correspondence
set "mismatch="
for /l %%i in (0,1,127) do (
    set "expected_char=!expected_string:~%%i,1!"
    set "user_char=!user_input:~%%i,1!"
    
    if "!expected_char!" neq "!user_char!" (
        set "mismatch=!expected_char!"
        echo Mismatch found: Expected '!expected_char!' but got '!user_char!' at position %%i.
        goto :check_done
    )
)

if "!user_input!" neq "!expected_string!" (
    echo The input does not match the expected string completely.
)

:check_done
:: End of script
echo All checks completed.
pause