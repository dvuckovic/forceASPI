@Echo off
SET ver=1.7
IF %OS%==Windows_NT Goto WinNT

:Win9x
CLS
Echo DumpASPI %ver%
Echo.
Echo Windows 9x or ME Detected.
Echo Windows is in : %winbootdir%
Echo Dumping Files...
IF NOT EXIST Win9xDUMP\frcASPI.txt md Win9xDUMP
Echo DO NOT DELETE! This is dummy file created by frcASPI for Dump/Restore validation > Win9xDUMP\frcASPI.txt

Echo   * WINASPI.DLL
IF EXIST %winbootdir%\system\winaspi.dll copy %winbootdir%\system\winaspi.dll Win9xDUMP > nul
IF NOT EXIST %winbootdir%\system\winaspi.dll Echo     [ file does not exist, backup not possible ]

Echo   * WNASPI32.DLL
IF EXIST %winbootdir%\system\wnaspi32.dll copy %winbootdir%\system\wnaspi32.dll Win9xDUMP > nul
IF NOT EXIST %winbootdir%\system\wnaspi32.dll Echo     [ file does not exist, backup not possible ]

Echo   * ASPIENUM.VXD
IF EXIST %winbootdir%\system\aspienum.vxd copy %winbootdir%\system\aspienum.vxd Win9xDUMP > nul
IF NOT EXIST %winbootdir%\system\aspienum.vxd Echo     [ file does not exist, backup not possible ]

Echo   * APIX.VXD
IF EXIST %winbootdir%\system\iosubsys\apix.vxd copy %winbootdir%\system\iosubsys\apix.vxd Win9xDUMP > nul
IF NOT EXIST %winbootdir%\system\iosubsys\apix.vxd Echo     [ file does not exist, backup not possible ]

Echo Done!
Echo.
Echo Current ASPI Layer is Dumped.
Goto End

:WinNT
CLS
Echo DumpASPI %ver%
Echo.
Echo Windows NT or 2000 Detected.
Echo Windows is in : %windir%
Echo Dumping Files...
IF %PROCESSOR_ARCHITECTURE%==x86 Goto Intel
Goto Alpha

:Intel
IF NOT EXIST WinNTDUMP\frcASPI.txt md WinNTDUMP
Echo DO NOT DELETE! This is dummy file created by frcASPI for Dump/Restore validation > WinNTDUMP\frcASPI.txt
Echo  * WINASPI.DLL
IF EXIST %windir%\system\winaspi.dll (
  copy %windir%\system\winaspi.dll WinNTDUMP > nul
) ELSE (
  Echo    [ file does not exist, backup not possible ]
)
Echo  * WOWPOST.EXE
IF EXIST %windir%\system\wowpost.exe (
  copy %windir%\system\wowpost.exe WinNTDUMP > nul
) ELSE (
  Echo    [ file does not exist, backup not possible ]
)
Echo  * WNASPI32.DLL
IF EXIST %windir%\system32\wnaspi32.dll (
  copy %windir%\system32\wnaspi32.dll WinNTDUMP > nul
) ELSE (
  Echo    [ file does not exist, backup not possible ]
)
Echo  * ASPI32.DLL
IF EXIST %windir%\system32\drivers\aspi32.sys (
  copy %windir%\system32\drivers\aspi32.sys WinNTDUMP > nul
) ELSE (
  Echo    [ file does not exist, backup not possible ]
)
Echo Done!
Echo.
Echo Current ASPI Layer is Dumped.
Goto End

:Alpha
Echo Alpha CPU Detected.
Echo Sorry, only Intel x86 and compatible platforms are supported.
Goto End

:End
SET ver=
pause
exit
