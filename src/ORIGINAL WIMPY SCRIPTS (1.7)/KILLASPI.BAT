@Echo off
SET ver=1.7
IF %OS%==Windows_NT Goto WinNT

:Win9x
CLS
Echo KillASPI %ver%
Echo.
Echo Windows 9x or ME Detected.
Echo Windows is in : %winbootdir%
Echo Killing Files...

Echo   - WINASPI.DLL
IF NOT EXIST %winbootdir%\system\winaspi.dll Echo     [ file does not exist ]
IF EXIST %winbootdir%\system\winaspi.dll del %winbootdir%\system\winaspi.dll > nul

Echo   - WNASPI32.DLL
IF NOT EXIST %winbootdir%\system\wnaspi32.dll Echo     [ file does not exist ]
IF EXIST %winbootdir%\system\wnaspi32.dll del %winbootdir%\system\wnaspi32.dll > nul

Echo   - ASPIENUM.VXD
IF NOT EXIST %winbootdir%\system\aspienum.vxd Echo     [ file does not exist ]
IF EXIST %winbootdir%\system\aspienum.vxd del %winbootdir%\system\aspienum.vxd > nul

Echo   - APIX.VXD
IF NOT EXIST %winbootdir%\system\iosubsys\apix.vxd Echo     [ file does not exist ]
IF EXIST %winbootdir%\system\iosubsys\apix.vxd del %winbootdir%\system\iosubsys\apix.vxd > nul

Echo Done!
Echo.
Echo ASPI Layer is Killed.
Echo Reboot your PC to make the changes active.
Goto End

:WinNT
CLS
Echo KillASPI %ver%
Echo.
Echo Windows NT or 2000 Detected.
Echo Windows is in : %windir%
IF %PROCESSOR_ARCHITECTURE%==x86 Goto Intel
Goto Alpha

:Intel
Echo Killing Files...
Echo   - WINASPI.DLL
IF EXIST %windir%\system\winaspi.dll (
  del %windir%\system\winaspi.dll > nul
) ELSE (
  Echo     [ file does not exist ]
)
Echo   - WOWPOST.EXE
IF EXIST %windir%\system\wowpost.exe (
  del %windir%\system\wowpost.exe > nul
) ELSE (
  Echo     [ file does not exist ]
)
Echo   - WNASPI32.DLL
IF EXIST %windir%\system32\wnaspi32.dll (
  del %windir%\system32\wnaspi32.dll > nul
) ELSE (
Echo     [ file does not exist ]
)
Echo   - ASPI32.SYS
IF EXIST %windir%\system32\drivers\aspi32.sys (
  del %windir%\system32\drivers\aspi32.sys > nul
) ELSE (
  Echo     [ file does not exist ]
)
Echo Done!
Echo.
Echo ASPI Layer is Killed.
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
