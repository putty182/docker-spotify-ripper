@echo off
SET DIR=%~dp0%

::check if Admin
net session 1>NUL 2>NUL
IF %ERRORLEVEL% EQU 0 (
    ECHO you are Administrator
) ELSE (
    ECHO you are NOT Administrator. Exiting...
    echo.
    echo Datei mit "Rechtsklick / Als Administrator ausfuehren" starten
    echo.
    goto end
)

@echo on
::install WSL2
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi','%DIR%wsl_update_x64.msi'))"
msiexec /i "%DIR%wsl_update_x64.msi" /qb
del "%DIR%wsl_update_x64.msi"
wsl --set-default-version 2

::download chocolatey install.ps1
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://chocolatey.org/install.ps1','%DIR%install.ps1'))"
::run chocolatey installer
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%DIR%install.ps1' %*"
del "%DIR%install.ps1"
::run docker installer
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "choco upgrade docker-desktop -y"

:end
@pause