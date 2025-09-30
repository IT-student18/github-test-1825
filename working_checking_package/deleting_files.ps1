try {
	del 4checking.xlsx;
	del 4checking.docx;
	Write-Host "Deleted Files EEEasily."
	Read-Host
}
catch {
	Write-Host "Error: $($_.Exception.Message) (may god smite us all) "
	Read-Host
}
