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


:: Настройка имен файлов

set "word_file=%USERPROFILE%\Desktop\4checking.docx"
set "excel_file=%USERPROFILE%\Desktop\4checking.xlsx"
set "powerpoint_file=%USERPROFILE%\Desktop\4checking.pptx"


:: Создание файлов Microsoft Office на рабочем столе с помощью PowerShell

echo Creating files for Microsoft Office applications using PowerShell...

powershell -NoProfile -Command "\$word = New-Object -ComObject Word.Application; \$doc = \$word.Documents.Add(); \$range1 = \$doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 1); \$range1.Text = 'FIRST'; \$range1.Style = [Microsoft.Office.Interop.Word.WdBuiltinStyle]::wdStyleHeading1; \$doc.Content.InsertParagraphAfter(); \$range2 = \$doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 2); \$range2.Text = 'the quick brown fox jumps over the lazy dog'; \$doc.Content.InsertParagraphAfter(); \$range3 = \$doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 3); \$range3.Text = 'SECOND'; \$range3.Style = [Microsoft.Office.Interop.Word.WdBuiltinStyle]::wdStyleHeading1; \$doc.Content.InsertParagraphAfter(); \$range4 = \$doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 4); \$range4.Text = 'the lazy dog follows it with its eyes'; \$doc.Content.InsertParagraphAfter(); \$range5 = \$doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 5); \$range5.Text = 'THIRD'; \$range5.Style = [Microsoft.Office.Interop.Word.WdBuiltinStyle]::wdStyleHeading1; \$doc.Content.InsertParagraphAfter(); \$range6 = \$doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 6); \$range6.Text = 'the quick brown fox lands and looks at the lazy dog'; \$doc.Content.InsertParagraphAfter(); \$doc.SaveAs('%word_file%', [Microsoft.Office.Interop.Word.WdSaveFormat]::wdFormatXMLDocument); \$word.Quit(); Write-Host 'Word file created successfully.';"

powershell -NoProfile -Command "try { \$excel = New-Object -ComObject Excel.Application; \$excel.Workbooks.Add().SaveAs('%excel_file%', [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook); \$excel.Quit(); Write-Host 'Excel file created successfully.'; } catch { Write-Error 'Error creating Excel file: ' \$_; }"

powershell -NoProfile -Command "try { \$powerpoint = New-Object -ComObject PowerPoint.Application; \$powerpoint.Presentations.Add().SaveAs('%powerpoint_file%'); \$powerpoint.Quit(); Write-Host 'PowerPoint file created successfully.'; } catch { Write-Error 'Error creating PowerPoint file: ' \$_; }"


echo Opening created files...

start "" "%word_file%"

start "" "%excel_file%"

start "" "%powerpoint_file%"


:: Ожидание, пока пользователь закроет файлы

echo Please close the opened files to continue.

pause


:: Expected string for checking (буквы от 'q' до 'm')

set "expected_string=qrstuvwxyzabcdefghijklm"


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

powershell -NoProfile -Command "while (\$true) { \$key = [System.Console]::ReadKey(\$true); if (\$key.Key -eq 'Escape') { Write-Host 'Exit function key check.'; del "%word_file%" "%excel_file%" "%powerpoint_file%"; Write-Host 'Deleted created files.'; break; } if (\$key.Key -ge 'F1' -and \$key.Key -le 'F12') { \$func_key = \$key.Key.ToString().Substring(1); Write-Host 'You pressed function key: F' \$func_key; } else { Write-Host 'Unknown key: ' \$key.Key; } }"

goto :end


:end

echo All checks completed.

pause