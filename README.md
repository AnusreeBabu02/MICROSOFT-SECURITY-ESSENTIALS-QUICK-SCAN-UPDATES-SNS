# Windows Defender Security Scripts

PowerShell and batch scripts for automating a Windows Defender quick scan, updating malware signatures, and checking protection status.

> **Academic / Lab Project:** This repository is based on a cybersecurity laboratory experiment covering Windows Security and endpoint protection.

## Overview

This project demonstrates two approaches to interacting with Microsoft antimalware tools:

- **Batch (`.bat`)** — uses `MpCmdRun.exe` and `sc.exe`.
- **PowerShell (`.ps1`)** — uses `MpCmdRun.exe` together with `Get-MpComputerStatus`.

The workflow is:

1. Update antivirus/malware signatures.
2. Start a Windows Defender Quick Scan.
3. Display or query protection status.
4. Report useful Defender version and scan information.

## Repository Structure

```text
windows-defender-security-scripts/
├── scripts/
│   ├── scan_mse.bat
│   └── exp3.ps1
├── docs/
│   └── experiment-notes.md
├── .gitignore
└── README.md
```

## Requirements

### Modern Windows

- Windows 10/11
- Windows Defender / Microsoft Defender Antivirus
- Administrator privileges
- `MpCmdRun.exe`
- Windows PowerShell 5.1 or PowerShell

### Legacy Windows 7

The batch approach can be adapted for Microsoft Security Essentials (MSE), where the service is `MsMpSvc` and the executable may be under:

```text
C:\Program Files\Microsoft Security Client
```

The supplied scripts target the modern Windows Defender path by default.

## Script 1 — Batch

### `scripts/scan_mse.bat`

This script:

1. Changes to the Windows Defender directory.
2. Updates malware signatures.
3. Starts a Quick Scan.
4. Queries the `WinDefend` service.
5. Displays the service state.

Run **Command Prompt as Administrator**, then execute:

```cmd
scan_mse.bat
```

The main commands are:

```cmd
MpCmdRun.exe -SignatureUpdate
MpCmdRun.exe -Scan -ScanType 1
sc query WinDefend
```

For a Windows 7 MSE environment, the service name may be `MsMpSvc` instead.

## Script 2 — PowerShell

### `scripts/exp3.ps1`

The PowerShell version performs the same basic security workflow and additionally retrieves structured Defender telemetry.

It uses:

```powershell
MpCmdRun.exe -SignatureUpdate
MpCmdRun.exe -Scan -ScanType 1
Get-MpComputerStatus
```

The script reports:

- Real-time protection status
- Last Quick Scan completion time
- Antivirus signature version
- Engine version
- Antispyware signature version
- Defender service version

### Running the PowerShell Script

Open PowerShell as Administrator and navigate to the repository:

```powershell
cd path\to\windows-defender-security-scripts
```

Then run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\exp3.ps1
```

`-ExecutionPolicy Bypass` applies to that PowerShell process invocation and does not permanently change the machine's execution-policy settings.

## Expected Behaviour

A successful run should show that:

- Signature update completes successfully.
- Quick Scan completes successfully.
- The Defender service is running.
- Real-time protection is enabled when queried through `Get-MpComputerStatus`.

An `hr=0` result from `MpCmdRun.exe` indicates successful completion of the operation.

## Batch vs PowerShell

| Feature | Batch | PowerShell |
|---|---|---|
| Main interpreter | `cmd.exe` | PowerShell |
| Defender command | `MpCmdRun.exe` | `MpCmdRun.exe` |
| Status query | `sc.exe` | `Get-MpComputerStatus` |
| Output | Plain text | Structured PowerShell objects |
| Best suited for | Simple automation / legacy compatibility | Modern Windows Defender telemetry |

## Troubleshooting

### `The system cannot find the path specified`

The Defender installation path may differ.

Check the location of `MpCmdRun.exe` and update the script if necessary.

### `Failed with hr = 0x8050111c`

Run the terminal with **Administrator** privileges. Another Windows Defender operation or system task may also be in progress.

### `[SC] OpenService FAILED 5: Access is denied`

Run Command Prompt as Administrator.

### PowerShell says `.\exp3.ps1` cannot be found

Make sure PowerShell is in the correct directory, or provide the full path to the script.

### `PSSecurityException` / script is not digitally signed

For a controlled lab environment, the documented invocation is:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\exp3.ps1
```

## Security Notes

- Run these scripts only on systems you are authorized to administer.
- A Quick Scan is not a guarantee that a system is completely malware-free.
- Do not disable Microsoft Defender protections just to make the scripts run.
- Keep Windows and Defender signatures updated.
- Review scan output and Defender status rather than relying on a single success code.

## Learning Outcomes

This project demonstrates:

- Basic Windows endpoint security administration
- Command-line antivirus automation
- PowerShell security automation
- Windows service inspection
- Defender status monitoring
- The difference between unstructured command output and structured PowerShell/CIM telemetry

## Academic Reference

The repository was prepared from the supplied laboratory experiment covering:

**Experiment 3: Microsoft Security Essentials Quick Scan & Updates**

The source experiment documents both the batch workflow (`scan_mse.bat`) and the PowerShell workflow (`exp3.ps1`), including execution steps, results, viva questions, and common errors. 

## Disclaimer

This repository is intended for educational and authorized system-administration use. It does not provide malware, exploit code, or instructions for bypassing endpoint security.
