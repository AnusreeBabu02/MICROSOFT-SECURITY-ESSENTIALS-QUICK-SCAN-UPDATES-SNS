@echo off
cd /d "C:\Program Files\Windows Defender"

echo [1/3] Updating malware signatures...
MpCmdRun.exe -SignatureUpdate

echo.
echo [2/3] Starting Quick Scan...
MpCmdRun.exe -Scan -ScanType 1

echo.
echo [3/3] Querying Service Status...
sc query WinDefend | findstr /i "STATE"

pause