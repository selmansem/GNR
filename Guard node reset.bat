:: Name:     Guard node reset.bat
:: Purpose:  Reset Tor Guard node
:: Author:   https://github.com/selmansem
:: Revision: March 2021 - initial version
::           March 2021 - v1.1 -> Design modification | Process lookup | Code cleanup
::           March 2021 - v1.1.1 -> Design modification

@ECHO off
TITLE Guard node reset
SETLOCAL

:: Variables
SET filename="Browser\TorBrowser\Data\Tor\state"

CALL :setESC
FOR /f "useback delims=" %%_ in (%0) do (
    IF "%%_"=="____HEADEREND____" SET $=
    IF DEFINED $ ECHO(%%_
    IF "%%_"=="____HEADERSTART____" SET $=1
)
GOTO :startCommand

:: Header ascii art
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
ECHO ^.---------------------------------------------------^.
ECHO ^|   LEGEND:                                         ^|
ECHO ^|   %ESC%[92m[OK] = CORRECT%ESC%[0m  %ESC%[93m[AL] = ALERT%ESC%[0m    %ESC%[91m[DG] = DANGER%ESC%[0m   ^|
ECHO ^`---------------------------------------------------^'
ECHO.
ECHO %ESC%[104;93m INITIALIZING COMMAND... %ESC%[0m
ECHO.
ECHO 1. I'm panoid %ESC%[93m(AL: This operation will end all Firefox processes)%ESC%[0m
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
ECHO %ESC%[93m[AL] Deleting saved guard node...%ESC%[0m
IF EXIST %filename% (
    del %filename%
    ECHO %ESC%[92m[OK] Done%ESC%[0m
) ELSE (
    ECHO %ESC%[92m[OK] Already deleted%ESC%[0m
)
GOTO :end

:cancelCommand
ECHO Operation cancelled
GOTO :end

:: For colors
:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & ECHO on & for %%b in (1) do rem"') do (
    set ESC=%%b
    exit /B 0
)
exit /B 0
:: End for colors

:end
ECHO Bye :)
timeout /t 3 /nobreak > NUL
ENDLOCAL
ECHO ON
@EXIT /B 0
