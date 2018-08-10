@echo off

REM
REM Increase Windows kernel verbosity level to view the debug message from WinDBG
REM
REM For local use, use
REM kd> ed nt!Kd_Default_Mask 0xf
REM from WinDBG
REM

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v DEFAULT /t REG_DWORD /d 0xf
