cls

echo off
echo "===================================================================="
echo "disabilitazione servizi inutili"
echo "===================================================================="
rem if not exist %1 goto :endpoint

@Echo On
SC CONFIG "stisvc" start= disabled
SC CONFIG "wuauserv" start= disabled
SC CONFIG "Alerter" start= disabled
SC CONFIG "COMSysApp" start= disabled
SC CONFIG "Browser" start= disabled
SC CONFIG "ClipSrv" start= disabled
SC CONFIG "mnmsrvc" start= disabled
SC CONFIG "helpsvc" start= disabled
SC CONFIG "Uninterruptible" start= disabled
SC CONFIG "Messenger" start= disabled
SC CONFIG "SENS" start= disabled
SC CONFIG "WmdmPmSN" start= disabled
SC CONFIG "RemoteRegistry" start= disabled
SC CONFIG "RemoteAccess" start= disabled
SC CONFIG "TermService" start= disabled
SC CONFIG "CiSvc" start= disabled
SC CONFIG "ERSvc" start= disabled
SC CONFIG "srservice" start= disabled
SC CONFIG "BITS" start= disabled



echo ""
echo "===================================================================="
echo "Fine "

echo "===================================================================="
rem

pause


  
