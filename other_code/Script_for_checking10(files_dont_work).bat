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


:: Создание файлов Microsoft Office на рабочем столе

echo Creating files for Microsoft Office applications...

set "desktop=%USERPROFILE%\Desktop"


set "word_file=%desktop%\NewDocument.docx"
set "excel_file=%desktop%\NewWorkbook.xlsx"
set "powerpoint_file=%desktop%\NewPresentation.pptx"


:: Создание файла Word с текстом
echo.> "%word_file%"
echo Lorem Ipsum>> "%word_file%"
echo.>> "%word_file%"
echo "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...">> "%word_file%"
echo "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...">> "%word_file%"
echo.>> "%word_file%"
echo What is Lorem Ipsum?>> "%word_file%"
echo Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.>> "%word_file%"
echo.>> "%word_file%"
echo Why do we use it?>> "%word_file%"
echo It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).>> "%word_file%"
echo.>> "%word_file%"
echo Where does it come from?>> "%word_file%"
echo Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.>> "%word_file%"
echo.>> "%word_file%"
echo The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.>> "%word_file%"
echo.>> "%word_file%"
echo Where can I get some?>> "%word_file%"
echo There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.>> "%word_file%"


:: Создание пустого файла Excel
echo. > "%excel_file%"


:: Создание пустого файла PowerPoint
echo. > "%powerpoint_file%"


echo Opening created files...

start "" "%word_file%"

start "" "%excel_file%"

start "" "%powerpoint_file%"


:: Ожидание, пока пользователь закроет файлы

echo Please close the opened files to continue.

pause


:: Expected string for checking (буквы от 'q' до 'm') etc

set "expected_string=qrstuvwxyzabcdefghijklm[];'\,./`1234567890-="


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

goto :end


:end

echo All checks completed.

pause