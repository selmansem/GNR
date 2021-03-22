:: Name:     Guard node reset.bat
:: Purpose:  Reset Tor Guard node
:: Author:   https://github.com/selmansem
:: Revision: March 2021 - initial version

@ECHO off
CHCP 65001
TITLE Guard node reset
SETLOCAL
SET checkMarck=✓
SET filename="Browser\TorBrowser\Data\Tor\state"
CALL :setESC
FOR /f "useback delims=" %%_ in (%0) do (
    IF "%%_"=="____HEADEREND____" SET $=
    IF DEFINED $ ECHO(%%_
    IF "%%_"=="____HEADERSTART____" SET $=1
)
GOTO :startCommand

____HEADERSTART____
.------..------..------.
|G.--. ||N.--. ||R.--. |
| :/\: || :(): || :(): |
| :\/: || ()() || ()() |
| '--'G|| '--'N|| '--'R|
`------'`------'`------'
____HEADEREND____

:startCommand
ECHO.
ECHO %ESC%[104;93m INITIALIZING COMMAND... %ESC%[0m
ECHO.
ECHO 1. I'm panoid %ESC%[91m(! ALERT: This operation will end all Firefox processes)%ESC%[0m
ECHO 2. Exit
ECHO.
CHOICE /C 12 /M "Enter your choice:"

IF ERRORLEVEL 2 GOTO cancelCommand
IF ERRORLEVEL 1 GOTO deletingCommand

:deletingCommand
QPROCESS "firefox.exe" > NUL
IF %ERRORLEVEL% EQU 0 (
    taskkill /f /im firefox.exe
)
ECHO %ESC%[93m^[!^] Deleting saved guard node...%ESC%[0m
IF EXIST %filename% (
    del %filename%
    ECHO %ESC%[92m^[%checkMarck%^] Done%ESC%[0m
) ELSE (
    ECHO %ESC%[92m^[%checkMarck%^] Already deleted%ESC%[0m
)
GOTO :end

:cancelCommand
ECHO Operation cancelled
GOTO :end

:::::::::::::Para los colores:::::::::::::
:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & ECHO on & for %%b in (1) do rem"') do (
    set ESC=%%b
    exit /B 0
)
exit /B 0
:::::::::::Fin para los colores:::::::::::

:end
ECHO Bye :)
timeout /t 5 /nobreak > NUL
exit