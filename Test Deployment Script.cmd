@echo off



echo This script will prepare GCPW, please sit tight while I run the installs. Be sure that I'm connected to the internet before continuing.
timeout /t 15


wmic useraccount get sid | findstr /i "1001" >D:/quickDeployment/findstr.txt
set /p uzer= < D:\quickDeployment\findstr.txt


echo Parameters set!
echo Installing chrome...
start /w D:\quickDeployment\ChromeSetup.exe

taskkill /f /im "chrome.exe" /T

echo Installing Slack (Machine Wide)...
start /w D:\quickDeployment\SlackInstall.bat

echo Starting GCPW rollout...
start /w D:\quickDeployment\gcpwstandaloneenterprise64.exe

echo Finishing touches...
REG ADD HKLM\Software\Google\GCPW\Users\%uzer%
REG ADD HKLM\Software\Google\GCPW\Users\%uzer% /v email /t REG_SZ /d usait@myscopetech.com
start /w D:\quickDeployment\HideAcc.reg
echo All done! Restart to finalize changes!

echo Experimental Changes: Installing RC Phone (Machine Wide)
start /w D:\quickDeployment\RCPhoneInstall.bat

timeout /t 30
exit