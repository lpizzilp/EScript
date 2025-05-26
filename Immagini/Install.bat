@echo off
set "destination=C:\Esagra"
echo ====================================================================
SETLOCAL

REM Chiedi all'utente di confermare
:ASK_CONFIRMATION
echo Stai per installare le immagini Esagra 
echo.
SET /P CONFIRM="Vuoi continuare con l'installazione? (S/N): "

REM Converti l'input in maiuscolo per facilitarne la gestione
SET CONFIRM=%CONFIRM:~0,1%

IF /I "%CONFIRM%"=="S" (
    echo Hai scelto di continuare.
) ELSE IF /I "%CONFIRM%"=="N" (
    echo Hai scelto di non continuare. Uscita dallo script.
    exit /b 0
) ELSE (
    echo Input non valido. Inserisci S o N.
    GOTO ASK_CONFIRMATION
)

echo ====================================================================
echo - Creo una directory c:\Esagra
echo ====================================================================

IF NOT EXIST "%destination%" (
    mkdir "%destination%"
    echo Directory "%destination%" creata.
) ELSE (
    echo Directory già esistente.
)

echo ====================================================================
echo Copia cartella immagini"
echo ====================================================================
set "source1=Img"
set "source2=Boot"

echo Copia in corso...
xcopy /E /I ".\%source1%" "%destination%\%source1%"
xcopy /E /I ".\%source2%" "%destination%\%source2%"

:: Verifica se la copia è avvenuta con successo
if %errorLevel% == 0 (
    echo Copia completata con successo.
) else (
    echo Si è verificato un errore durante la copia del file.
)
GOTO NOSFONDO

echo ====================================================================
echo imposta sfondo
echo ====================================================================
SET /P CONFIRM="Vuoi continuare con l'installazione? (S/N): "
SET CONFIRM=%CONFIRM:~0,1%
IF /I "%CONFIRM%"=="S" (
    echo Hai scelto di Impostare lo sfondo.
) ELSE IF /I "%CONFIRM%"=="N" (
    echo Hai scelto di non continuare. Uscita dallo script.
    GOTO NOSFONDO
) ELSE (
echo gogo
)
set "wallpaper=%destination%\%source2%\Windows-Esagra-Client.jpg"

:: Abilita Active Desktop
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General" /v Wallpaper /t REG_SZ /d "%wallpaper%" /f

:: Aggiorna lo sfondo
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

echo Sfondo impostato con successo!
:NOSFONDO

echo ====================================================================
echo END
echo ====================================================================


pause
