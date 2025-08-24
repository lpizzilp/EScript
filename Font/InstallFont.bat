@echo off
setlocal
set FONT_NAME=Code39 (TrueType)
set FONT_FILE=Code39.ttf
set FONT_PATH=%windir%\Fonts

echo Controllo se il font è già installato...

:: Controlla se il font è già registrato nel registro di sistema
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%FONT_NAME%" >nul 2>&1
if "%errorlevel%"=="0" (
    echo Il font "%FONT_NAME%" è già registrato nel sistema.
    set REG_INSTALLED=1
) else (
    set REG_INSTALLED=0
)

:: Controlla se il file esiste nella cartella dei font
if exist "%FONT_PATH%\%FONT_FILE%" (
    echo Il file "%FONT_FILE%" è già presente nella cartella dei font.
    set FILE_INSTALLED=1
) else (
    set FILE_INSTALLED=0
)

 

:: Logica di installazione - VERSIONE CORRETTA
if "%REG_INSTALLED%"=="1" (
    if "%FILE_INSTALLED%"=="1" (
        echo Il font "%FONT_NAME%" è già completamente installato.

    ) else (
        echo Installazione del font "%FONT_NAME%"...
        copy "%FONT_FILE%" "%FONT_PATH%" >nul
        reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%FONT_NAME%" /t REG_SZ /d "%FONT_FILE%" /f >nul
        echo Font installato correttamente.

    )
) else (
    echo Installazione del font "%FONT_NAME%"...
    copy "%FONT_FILE%" "%FONT_PATH%" >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%FONT_NAME%" /t REG_SZ /d "%FONT_FILE%" /f >nul
    echo Font installato correttamente.
    echo QUI3 
)
 
pause
endlocal