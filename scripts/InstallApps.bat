@echo off


REM Install tools (generic)
C:\ProgramData\Chocolatey\choco.exe install -y 7zip.install
C:\ProgramData\Chocolatey\choco.exe install -y python2
C:\ProgramData\Chocolatey\choco.exe install -y python3
C:\ProgramData\Chocolatey\choco.exe install -y ConEmu
C:\ProgramData\Chocolatey\choco.exe install -y GoogleChrome
C:\ProgramData\Chocolatey\choco.exe install -y SysInternals
C:\ProgramData\Chocolatey\choco.exe install -y processhacker
C:\ProgramData\Chocolatey\choco.exe install -y firefox
C:\ProgramData\Chocolatey\choco.exe install -y notepadplusplus.install
C:\ProgramData\Chocolatey\choco.exe install -y irfanview
C:\ProgramData\Chocolatey\choco.exe install -y sumatrapdf sumatrapdf.install
C:\ProgramData\Chocolatey\choco.exe install -y windbg
REM C:\ProgramData\Chocolatey\choco.exe install -y windowsdriverkit10
C:\ProgramData\Chocolatey\choco.exe install -y HxD
C:\ProgramData\Chocolatey\choco.exe install -y explorersuite
C:\ProgramData\Chocolatey\choco.exe install -y apimonitor
REM C:\ProgramData\Chocolatey\choco.exe install -y resourcehacker.portable
REM C:\ProgramData\Chocolatey\choco.exe install -y wireshark winpcap
C:\ProgramData\Chocolatey\choco.exe install -y ghidra --version=9.0.2

REM Install Python modules
C:\ProgramData\Chocolatey\choco.exe install -y vcpython27
C:\Python27\python.exe -m pip install pip -U
C:\Python27\Scripts\pip2.exe install pywin32
C:\Python27\Scripts\pip2.exe install pycrypto
C:\Python27\Scripts\pip2.exe install lief
C:\Python27\Scripts\pip2.exe install winappdbg
C:\Python27\Scripts\pip2.exe install requests

C:\Python37\Scripts\pip3.exe install frida-tools
C:\Python37\Scripts\pip3.exe install requests
C:\Python37\Scripts\pip3.exe install lief
C:\Python37\Scripts\pip3.exe install pywin32

REM Install tools (x64 only)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" goto Finish
C:\ProgramData\Chocolatey\choco.exe install -y ida-free

:Finish
exit
