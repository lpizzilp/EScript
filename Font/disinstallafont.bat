@echo off
setlocal
set FONT_NAME=Code39 (TrueType)
set FONT_FILE=Code39.ttf
set FONT_PATH=%windir%\Fonts

echo Disinstallazione del font "%FONT_NAME%"...

:: Rimuove il file dalla cartella dei font, se esiste
if exist "%FONT_PATH%\%FONT_FILE%" (
    del "%FONT_PATH%\%FONT_FILE%"
    echo Font rimosso dalla cartella dei font.
) else (
    echo Il file del font non esiste nella cartella dei font.
)

:: Elimina la voce dal registro di sistema, se presente
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%FONT_NAME%" >nul 2>&1
if %errorlevel%==0 (
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%FONT_NAME%" /f
    echo Voce del font rimossa dal registro.
) else (
    echo Nessuna voce trovata nel registro.
)

echo Disinstallazione completata.
pause
endlocal
