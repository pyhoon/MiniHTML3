@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage:
    echo    create_snippets.bat file1.bas file2.bas
    pause
    exit /b
)

:nextfile

if "%~1"=="" goto done

set "INPUT=%~f1"
if not exist "%INPUT%" (
    echo ERROR: File not found - %INPUT%
    shift
    goto nextfile
)

set "OUTDIR=%~dp1Snippets"
if not exist "%OUTDIR%" mkdir "%OUTDIR%" || (
    echo ERROR: Could not create folder %OUTDIR%
    shift
    goto nextfile
)

set "OUTPUT=%OUTDIR%\%~n1.txt"

echo.
echo Processing: %INPUT%
echo Output:     %OUTPUT%

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $lines=@(Get-Content -Path '%INPUT%' -ErrorAction Stop); $idx=$lines | %%{$i=0}{if($_ -match 'Sub Class_Globals'){$i;break} else {$i++}}; if($idx -ne $null){$snippet=$lines[($idx+1)..($lines.Count-1)]; if($snippet.Count -gt 0 -and $snippet[-1].Trim() -eq 'End Sub'){$snippet=$snippet[0..($snippet.Count-2)]}; $snippet | Set-Content -Path '%OUTPUT%' -ErrorAction Stop; Write-Host 'Snippet written.'} else {Write-Host 'Marker not found.'}"

if exist "%OUTPUT%" (
    echo Success: %OUTPUT% created.
) else (
    echo ERROR: Output file not created. Check the PowerShell output above.
)

shift
goto nextfile

:done

echo.
echo Finished.
pause