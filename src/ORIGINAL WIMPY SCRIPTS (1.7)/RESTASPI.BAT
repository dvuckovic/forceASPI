@Echo off
SET ver=1.7
IF %OS%==Windows_NT Goto WinNT

:Win9x
CLS
Echo RestASPI %ver%
Echo.
IF EXIST Win9xDUMP\frcASPI.txt Goto 9xDumpOK

:No9xDUMP
Echo You do not have a Dumped ASPI Layer to restore.
GOTO End

:9xDumpOK
Echo Found a Dumped ASPI Layer.
Echo Windows 9x or ME Detected.
Echo Windows is in : %winbootdir%
Echo Restoring Files...

Echo   * WINASPI.DLL
IF EXIST Win9xDUMP\winaspi.dll copy Win9xDUMP\winaspi.dll %winbootdir%\system > nul
IF NOT EXIST Win9xDUMP\winaspi.dll del %winbootdir%\system\winaspi.dll > nul

Echo   * WNASPI32.DLL
IF EXIST Win9xDUMP\wnaspi32.dll copy Win9xDUMP\wnaspi32.dll %winbootdir%\system > nul
IF NOT EXIST Win9xDUMP\wnaspi32.dll del %winbootdir%\system\wnaspi32.dll > nul

Echo   * ASPIENUM.VXD
IF EXIST Win9xDUMP\aspienum.vxd copy Win9xDUMP\aspienum.vxd %winbootdir%\system > nul
IF NOT EXIST Win9xDUMP\aspienum.vxd del %winbootdir%\system\aspienum.vxd > nul

Echo   * APIX.VXD
IF EXIST Win9xDUMP\apix.vxd copy Win9xDUMP\apix.vxd %winbootdir%\system\iosubsys > nul
IF NOT EXIST Win9xDUMP\apix.vxd del %winbootdir%\system\iosubsys\apix.vxd > nul

Echo Done!
Echo.
Echo Your Dumped ASPI Layer has been restored.
Echo Reboot you PC to make the changes active.
Goto End

:WinNT
CLS
Echo RestASPI %ver%
Echo.
IF %PROCESSOR_ARCHITECTURE%==x86 Goto Intel
Goto Alpha

:Intel
IF EXIST WinNTDUMP\frcASPI.txt Goto NTDumpOK

:NoNTDUMP
Echo You do not have a Dumped ASPI Layer to restore.
GOTO End

:NTDumpOK
Echo Found a Dumped ASPI Layer.
Echo Windows NT or 2000 Detected.
Echo Windows is in : %windir%
Echo Restoring Files...
Echo   * WINASPI.DLL
IF EXIST WinNTDUMP\winaspi.dll (
  copy WinNT\winaspi.dll %windir%\system > nul
  Echo     [ restored ]
) ELSE (
  del %windir%\system\winaspi.dll > nul
  Echo     [ no backup, therefore killed ]
)
Echo   * WOWPOST.EXE
IF EXIST WinNTDUMP\wowpost.exe (
  copy WinNT\wowpost.exe %windir%\system > nul
  Echo     [ restored ]
) ELSE (
  del %windir%\system\wowpost.exe > nul
  Echo     [ no backup, therefore killed ]
)
Echo   * WNASPI32.DLL
IF EXIST WinNTDUMP\wnaspi32.dll (
  copy WinNT\wnaspi32.dll %windir%\system32 > nul
  Echo     [ restored ]
) ELSE (
  del %windir%\system32\wnaspi32.dll > nul
  Echo     [ no backup, therefore killed ]
)
Echo   * ASPI32.SYS
IF EXIST WinNTDUMP\aspi32.sys (
  copy WinNT\aspi32.sys %windir%\system32\drivers > nul
  Echo     [ restored ]
) ELSE (
  del %windir%\system32\drivers\aspi32.sys > nul
  Echo     [ no backup, therefore killed ]
)
Echo Done!
Echo.
Echo Your Dumped ASPI Layer has been restored.
Echo Reboot you PC to make the changes active.
Goto End

:Alpha
Echo Alpha CPU Detected.
Echo Sorry, only Intel x86 and compatible platforms are supported.
Goto End


:End
SET ver=
pause
exit
