# Внимание: Этот способ может быть ненадежным и зависит от стабильности работы COM-объектов.
try {
    $word = [System.Runtime.InteropServices.Marshal]::GetActiveObject("Word.Application")
} catch {
    $word = New-Object -ComObject Word.Application
}
$word.Visible = $true
$doc = $word.Documents.Add()
Start-Sleep -Seconds 2
# ... остальной код для работы с документом ...

#$word | Get-Member
#$word.ActiveDocument | Get-Member

<#
# Попытка найти и закрыть окно с заголовком "Мастер активации Microsoft Office"
$signature = @"
[DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

[DllImport("user32.dll", SetLastError = true)]
[return: MarshalAs(UnmanagedType.Bool)]
public static extern bool PostMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);

public const uint WM_CLOSE = 0x0010;
"@

$user32 = Add-Type -MemberDefinition $signature -Name "NativeMethods" -Namespace "Win32" -PassThru

Start-Sleep -Seconds 1 # Даем время окну появиться
Write-Host "Time's UP!"
#try {$activationWindow = [Win32.NativeMethods]::FindWindow(null, "Мастер активации Microsoft Office"); Write-Host "Kind_of_smth..."} catch {Write-Host "FUCK"}

if ($activationWindow -ne [IntPtr]::Zero) {
    Write-Host "Обнаружено окно активации. Попытка закрытия..."
    [Win32.NativeMethods]::PostMessage($activationWindow, [Win32.NativeMethods]::WM_CLOSE, [IntPtr]::Zero, [IntPtr]::Zero)
    Start-Sleep -Seconds 2 # Даем время окну закрыться
} else {
    Write-Host "Окно активации не обнаружено."
}
#>
# ... остальной код для сохранения и закрытия Word ...
Read-Host