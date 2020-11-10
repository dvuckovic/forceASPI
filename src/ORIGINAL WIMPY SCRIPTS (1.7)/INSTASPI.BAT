@Echo off
SET ver=1.7
IF %OS%==Windows_NT Goto WinNT

:Win9x
CLS
Echo InstASPI %ver%
Echo.
Echo Windows 9x or ME Detected.
Echo Windows is in : %winbootdir%
Echo Installing Files...
Echo   + WINASPI.DLL
copy Win9x\winaspi.dll %winbootdir%\system > nul
Echo   + WNASPI32.DLL
copy Win9x\wnaspi32.dll %winbootdir%\system > nul
Echo   + ASPIENUM.DLL
copy Win9x\aspienum.vxd %winbootdir%\system > nul
Echo   + APIX.VXD
copy Win9x\apix.vxd %winbootdir%\system\iosubsys > nul
Echo.
Echo Add Registry Settings...
%winbootdir%\regedit.exe /s Win9x\win9x.reg
Echo Done!
Echo.
Echo Adaptec ASPI 4.60 (1021) Installed.
Echo Reboot your PC to make the changes active.
Goto End

:WinNT
CLS
Echo InstASPI %ver%
Echo.
Echo Windows NT or 2000 Detected.
Echo Windows is in : %windir%
IF %PROCESSOR_ARCHITECTURE%==x86 Goto Intel
Goto Alpha

:Intel
Echo Installing Files...
Echo   + WINASPI.DLL
copy WinNT\winaspi.dll %windir%\system > nul
Echo   + WOWPOST.EXE
copy WinNT\wowpost.exe %windir%\system > nul
Echo   + WNASPI32.DLL
copy WinNT\wnaspi32.dll %windir%\system32 > nul
Echo   + ASPI32.SYS
copy WinNT\aspi32.sys %windir%\system32\drivers > nul
Echo.
Echo Add Registry Settings...
%windir%\regedit.exe /s WinNT\winnt.reg
Echo Done!
Echo.
Echo Adaptec ASPI 4.60 (1021) Installed.
Echo Reboot your PC to make the changes active.
Goto End

:Alpha
Echo Alpha CPU Detected.
Echo Sorry, only Intel x86 and compatible platforms are supported.
Goto End

:End
SET ver=
pause
exit
