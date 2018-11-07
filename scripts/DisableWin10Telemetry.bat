@echo off

REM This should be run with command prompt as an adminstrator.
REM Disable the antivirus and Windows Defender.
REM After disabling those, rename the file extension from .txt to .cmd
REM Then run this script.
REM This does not fix all privacy issues, you will still need to turn off some.

REM First, block Windows from sending data about you to their servers.

echo ## BEGIN Windows 10 privacy settings ##>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	vortex.data.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	vortex-win.data.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 telecommand.telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 telecommand.telemetry.microsoft.com.nsatc.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 oca.telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 oca.telemetry.microsoft.com.nsatc.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 sqm.telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 sqm.telemetry.microsoft.com.nsatc.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 watson.telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 watson.telemetry.microsoft.com.nsatc.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 redir.metaservices.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	choice.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 choice.microsoft.com.nsatc.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	df.telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 reports.wes.df.telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 wes.df.telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 services.wes.df.telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 sqm.df.telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 watson.ppe.telemetry.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	telemetry.appex.bing.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 telemetry.urs.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 telemetry.appex.bing.net:443>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	settings-sandbox.data.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	vortex-sandbox.data.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 survey.watson.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	watson.live.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	watson.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	statsfe2.ws.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 corpext.msitadfs.glbdns2.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 compatexchange.cloudapp.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	cs1.wpc.v0cdn.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	a-0001.a-msedge.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 statsfe2.update.microsoft.com.akadns.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 diagnostics.support.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	corp.sts.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	statsfe1.ws.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	pre.footprintpredict.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 i1.services.social.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 i1.services.social.microsoft.com.nsatc.net>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1	bingads.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo 127.0.0.1 www.bingads.microsoft.com>>%windir%\system32\drivers\etc\hosts
echo ## END Windows 10 privacy settings ##>>%windir%\system32\drivers\etc\hosts

REM settings -> privacy -> general -> let apps use my ID 
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo\ /v Enabled /t REG_DWORD /d 0 /f
reg delete HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo\ /v Id /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo\ /v Enabled /t REG_DWORD /d 0 /f

REM settings -> privacy -> general -> let websites provide locally 
reg add "HKCU\Control Panel\International\User Profile\" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f

REM settings -> privacy -> general -> speech, inking, & typing
reg add HKCU\SOFTWARE\Microsoft\InputPersonalization\ /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
reg add HKCU\SOFTWARE\Microsoft\InputPersonalization\ /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f
reg add HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore\ /v HarvestContacts /t REG_DWORD /d 0 /f
reg add HKCU\SOFTWARE\Microsoft\Personalization\Settings\ /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f

REM Disables web search in the search box
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\ /v BingSearchEnabled /t REG_DWORD /d 0 /f

REM Block telemetry services
powershell.exe -command "Get-Service DiagTrack | Set-Service -StartupType Disabled"
powershell.exe -command "Get-Service dmwappushservice | Set-Service -StartupType Disabled"
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection\ /v AllowTelemetry /t REG_DWORD /d 0 /f

REM Enable Windows Defender sandboxing
setx /M MP_FORCE_USE_SANDBOX 1

REM Finished.
