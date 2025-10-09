#$word = New-Object -ComObject Word.Application
#$word.Visible = $true
#$doc = $word.Documents.Add()

#try {
#        Write-Host "Styles in doc '$($doc.Name)':"
#	foreach ($style in $doc.Styles) {
#	Write-Host "- $($style.NameLocal) (BuiltIn: $($style.BuiltIn))";
#	}
#} catch {
#	Write-Host "error with getting styles: $($_.Exception.Message)"
#}
#Read-Host
#$doc.Close()
#$word.Quit()
try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $true
    $doc = $word.Documents.Add()
    Write-Host "Word and document created."

    Start-Sleep -Milliseconds 1000

    $styleName = "CustomHeading1"
    #$customStyle1 = $doc.Styles.Add($styleName) # Add with only the name

    Write-Host "Custom style '$styleName' added (name only)."

    $range = $doc.Content
    $range.Text = "Title"
    Write-Host "Text added."

    #$range.Style = $customStyle1 Try applying the basic style

    Write-Host "Style unapplied."

    Read-Host
    $doc.Close()
    $word.Quit()

} catch {
    Write-Host "An error occurred: $($_.Exception.Message)"
}
Read-Host