# 1. Update definitions
Write-Host "Updating definitions..."
& "$env:ProgramFiles\Windows Defender\MpCmdRun.exe" -SignatureUpdate

# 2. Run a Quick Scan
Write-Host "Running Quick Scan..."
& "$env:ProgramFiles\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1

# 3. Display Real-Time Protection Status
Write-Host "---------------------------------------"
$RTP = (Get-MpComputerStatus).RealTimeProtectionEnabled
Write-Host "Real-Time Protection Enabled: $RTP"
Write-Host "---------------------------------------"

$Status=Get-MpComputerStatus
Write-Host "Last Scan Completed : $($Status.QuickScanEndTime)"
Write-Host "Anti-virus Signature Version : $($Status.AntivirusSignatureVersion)"
Write-Host "Engine Version: $($Status.AMEngineVersion)"
Write-Host "Anti-Spyware Version: $($Status.AntispywareSignatureVersion )"
Write-Host "Service Version: $($Status.AMServiceVersion )"
Read-Host "Done! Press Enter to exit"