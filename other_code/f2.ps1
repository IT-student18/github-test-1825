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
try {
$range1 = $doc.Range(3, 4)
$range1.Text = 'TEXT'
Write-Host "Successfully added text"
} catch {
	Write-Host "Error: $($_.Exception.Message)"
}
#$range1 = $doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 1)
#$range1.Text = 'FIRST'
#$range1.Style = [Microsoft.Office.Interop.Word.WdBuiltinStyle]::wdStyleHeading1
#$doc.Content.InsertParagraphAfter()
#$range2 = $doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 2)
#$range2.Text = 'the quick brown fox jumps over the lazy dog'
#$doc.Content.InsertParagraphAfter()
#$range3 = $doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 3)
#$range3.Text = 'SECOND'
#$range3.Style = [Microsoft.Office.Interop.Word.WdBuiltinStyle]::wdStyleHeading1
#$doc.Content.InsertParagraphAfter()
#$range4 = $doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 4)
#$range4.Text = 'the lazy dog follows it with its eyes'
#$doc.Content.InsertParagraphAfter()
#$range5 = $doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 5)
#$range5.Text = 'THIRD'
#$range5.Style = [Microsoft.Office.Interop.Word.WdBuiltinStyle]::wdStyleHeading1
#$doc.Content.InsertParagraphAfter()
#$range6 = $doc.Content.GoTo([Microsoft.Office.Interop.Word.WdGoToItem]::wdGoToLine, [Microsoft.Office.Interop.Word.WdGoToDirection]::wdGoToAbsolute, 6)
#$range6.Text = 'the quick brown fox lands and looks at the lazy dog'
#$doc.Content.InsertParagraphAfter()
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
#$doc.Close()
$word.Quit()
Read-Host