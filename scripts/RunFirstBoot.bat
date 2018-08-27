@echo off
xcopy "\\vboxsrv\vagrant\scripts\wallpaper.jpg" "C:\Users\IEUser\" /y
xcopy "\\vboxsrv\vagrant\scripts\SetWallPaper.ps1" "C:\Users\IEUser\" /y
xcopy "\\vboxsrv\vagrant\scripts\SetWallPaper.bat" "C:\Users\IEUser\" /y
xcopy "\\vboxsrv\vagrant\scripts\SetWallpaper.bat" "C:\Users\IEUser\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" /y
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v SetWallpaper /d "C:\Users\IEUser\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\SetWallpaper.bat" /f

powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-NetConnectionProfile -NetworkCategory Private"

rd /S /Q C:\BGInfo

netsh advfirewall firewall set rule group="remote administration" new enable=yes
netsh advfirewall firewall add rule name="Open Port 5985" dir=in action=allow protocol=TCP localport=5985
netsh advfirewall firewall add rule name="Open Port 3389" dir=in action=allow protocol=TCP localport=3389

net stop termservice /y
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v TSEnabled /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
sc.exe config TermService start= auto
net start termservice /y

call winrm quickconfig -q
call winrm quickconfig -transport:http

powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-PSRemoting -Force"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Item WSMan:\localhost\MaxTimeoutms 1800000"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Item WSMan:\localhost\WinRS\MaxMemoryPerShellMB 0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Item WSMan:\localhost\WinRS\MaxProcessesPerShell 0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Item WSMan:\localhost\WinRS\MaxShellsPerUser 0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Item WSMan:\localhost\Service\AllowUnencrypted -Value True"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Item WSMan:\localhost\Service\Auth\Basic -Value True"

powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Item WSMan:\localhost\Client\Auth\Basic -Value True"

net stop winrm /y
sc triggerinfo winrm start/networkon stop/networkoff
sc.exe config "WinRM" start= auto
net start winrm /y
