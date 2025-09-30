@echo off
setlocal enabledelayedexpansion

:: Проверка активации Windows
echo Checking Windows activation...
slmgr.vbs /xpr > nul
if %errorlevel% == 0 (
    echo Windows is activated.
) else (
    echo Windows is not activated.
)

:: Создание пустых файлов для Microsoft Word, Excel и PowerPoint на рабочем столе
echo Creating empty files for Microsoft Office applications...
set "desktop=%USERPROFILE%\Desktop"

set "word_file=%desktop%\NewDocument.docx"
set "excel_file=%desktop%\NewWorkbook.xlsx"
set "powerpoint_file=%desktop%\NewPresentation.pptx"

echo. > "%word_file%"
echo. > "%excel_file%"
echo. > "%powerpoint_file%"

echo Opening created files...
start "" "%word_file%"
start "" "%excel_file%"
start "" "%powerpoint_file%"

:: Ожидание, пока пользователь закроет файлы
echo Please close the opened files to continue.
pause

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
for /l %%i in (0,1,31) do (
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
echo.
echo Press any function key (F1-F12). Press Esc to exit.
:check_function_keys
powershell -NoProfile -Command "while ($true) { $key = [System.Console]::ReadKey($true); if ($key.Key -eq 'Escape') { Write-Host 'Exit function key check.'; break; } if ($key.Key -ge 'F1' -and $key.Key -le 'F12') { $func_key = $key.Key.ToString().Substring(1); Write-Host 'You pressed function key: F' $func_key; } else { Write-Host 'Unknown key: ' $key.Key; } }"
goto end

:end
echo All checks completed.
pause