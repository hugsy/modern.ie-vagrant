@xcopy "\\vboxsrv\vagrant\scripts\wallpaper.jpg" "C:\Users\IEUser\" /y
@xcopy "\\vboxsrv\vagrant\scripts\SetWallPaper.ps1" "C:\Users\IEUser\" /y
@xcopy "\\vboxsrv\vagrant\scripts\SetWallPaper.bat" "C:\Users\IEUser\" /y
@xcopy "\\vboxsrv\vagrant\scripts\SetWallpaper.bat" "C:\Users\IEUser\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" /y

@reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v SetWallpaper /d "C:\Users\IEUser\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\SetWallpaper.bat" /f

@powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-NetConnectionProfile -NetworkCategory Private"

netsh advfirewall firewall set rule group="remote administration" new enable=yes
netsh advfirewall firewall add rule name="Open Port 5985" dir=in action=allow protocol=TCP localport=5985
netsh advfirewall firewall add rule name="Open Port 3389" dir=in action=allow protocol=TCP localport=3389

winrm quickconfig -q
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Item WSMan:\localhost\Service\AllowUnencrypted -Value True; Set-Item WSMan:\localhost\Service\Auth\Basic -Value True"
winrm quickconfig -transport:http
winrm set winrm/config '@{MaxTimeoutms="7200000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="0"}'
winrm set winrm/config/winrs '@{MaxProcessesPerShell="0"}'
winrm set winrm/config/winrs '@{MaxShellsPerUser="0"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'
net stop winrm
sc triggerinfo winrm start/networkon stop/networkoff
sc.exe config "WinRM" start= auto
net start winrm

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v TSEnabled /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

sc.exe config TermService start= auto
net start termservice
