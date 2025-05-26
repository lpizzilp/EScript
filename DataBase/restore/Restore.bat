cls

echo off
echo "===================================================================="
echo "STARTA SQL SERVER 2000 SU QUESTO COMPUTER"
echo "===================================================================="
scm -action 1 -service MSSQLSERVER

echo "===================================================================="
echo "RIPRISTINO DEL BACKUP SQL SERVER "
echo "===================================================================="
rem if not exist %1 goto :endpoint

osql.exe -S SERVER-BK  -U sa -P sa -i Restore.sql


:endpoint


echo.
echo "===================================================================="
echo.
echo.
echo "Modifica indirizzo ip"
echo.
echo.
echo "===================================================================="
rem
netsh interface ip set address name="Connessione alla rete locale (LAN) 4"   static 192.168.0.11 255.255.255.0

echo.
echo "===================================================================="
echo "Controlla l'esito del restore. Se tutto ok "
echo "===================================================================="
echo.
echo.
echo "===================================================================="
echo "===================================================================="
echo "===================================================================="
REM msg "%username%" "COMUNICA A TUTTI CHE DEVONO COLLEGARSI CON 192.168.0.12 (o al SERVER-BK)"
echo "===================================================================="
echo "===================================================================="
echo "===================================================================="
echo.
rem msg "%username%"  "Il computer sarà riavviato..."
echo "===================================================================="
rem

echo off
echo "===================================================================="
echo "START AUTOMATICO DEL SERVER "
echo "===================================================================="
rem if not exist %1 goto :endpoint

echo set WshShell = WScript.CreateObject("WScript.Shell") > %tmp%\tmp.vbs
echo WScript.Quit (WshShell.Popup( "Ripristino Database Eseguito. Il sistema sarà riavviato in 10 Secondi..." ,10 ,"Click OK", 0)) >> %tmp%\tmp.vbs
cscript /nologo %tmp%\tmp.vbs


sc config MSSQLSERVER start= auto



shutdown /r /t 2 /c "Riavvio Sistema"

REM pause

