$word = New-Object -ComObject Word.Application
$word.Visible = $true
$doc = $word.Documents.Add()

$Selection = $word.Selection
$Selection.Font.Name = 'Times New Roman'
$Selection.Font.Size = 18
$Selection.TypeText('Working with Word thru PowerShell')
$Selection.ParagraphFormat.Alignment = 1
$Selection.TypeParagraph()
$Selection.Font.Name = 'Arial'
$Selection.Font.Size = 12
$Selection.TypeText('J some Text')
$Selection.TypeParagraph()

$start = 0;
$end = $doc.Content.End;
$range1 = $doc.Range($start, $end);
$range1.Text = 'FIRST';

$SH1 = [Microsoft.Office.Interop.Word.WdBuiltinStyle]::wdStyleHeading1;
$hs = $doc.Styles.Add("CHS");

$hs.Font.Size = 48;
$hs.Font.ColorIndex = 1;
$hs.Font.Bold = $true;

function Copy-Props {
param (
[Parameter(Mandatory=$true)]
[Microsoft.Office.Interop.Word.Style]$sourceStyle,

[Parameter(Mandatory=$true)]
[Microsoft.Office.Interop.Word.Range]$targetRange
)

$targetRange.Font.Size = $sourceStyle.Font.Size
#$targetRange.Font.ColorIndex = $sourceStyle.ColorIndex;
#$targetRange.Font.Bold = $sourceStyle.Font.Bold;
}
Start-Sleep -Seconds 1
Copy-Props -sourceStyle $SH1 -targetRange $range1;

$filePath = "$env:USERPROFILE\Documents\MyDocument.docx"  # Изменено на папку "Documents"
if (-Not (Test-Path -Path "$env:USERPROFILE\Documents")) {
    New-Item -Path "$env:USERPROFILE\Documents" -ItemType Directory;
}

$filePath = "C:\Temp\MyDocument.docx"
if (-Not (Test-Path -Path "C:\Temp")) {
	New-Item -Path "C:\Temp" -ItemType Directory;
}
try {
	$doc.SaveAs([ref] $filePath);
	Write-Host "Doc Saved successfully";
} catch {
	Write-Host "Error: $($_.Exception.Message)";
}
Read-Host
$doc.Close()
$word.Quit()
Remove-Item -Path $filePath -Force