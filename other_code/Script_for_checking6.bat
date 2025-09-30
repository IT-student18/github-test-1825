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

:: Checking for Microsoft Office installation
echo Checking for Microsoft Office installation...
wmic product where "name like 'Microsoft Office%'" get name > office_check.txt
set office_installed=0
for /f "skip=1" %%i in (office_check.txt) do (
    if not "%%i"=="" (
        echo Installed Office: %%i
        set office_installed=1
    )
)
if !office_installed! == 0 (
    echo Microsoft Office is not installed.
)
del office_check.txt

:: Expected string for checking
set "expected_string=qwertyuiopasdfghjklzxcvbnm[];'\,./`1234567890-="

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