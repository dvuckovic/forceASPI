@Echo off
SET ver=1.7
IF %OS%==Windows_NT Goto WinNT

:Win9x
CLS
Echo killDUMP %ver%
Echo.
Echo Windows 9x or ME Detected.
Echo Windows is in : %winbootdir%
Echo Killing Dumped Files...
Echo   - Win9xDUMP
IF EXIST Win9xDUMP\frcASPI.txt deltree /y Win9xDUMP > nul 
IF NOT EXIST Win9xDUMP\frcASPI.txt Echo   [ no dumped files to kill ]
Echo Done!
Echo.
Echo Your dumped files have been killed.
Goto End

:WinNT
CLS
Echo killDUMP %ver%
Echo.
Echo Windows NT or 2000 Detected.
Echo Windows is in : %windir%
Echo Killing Dumped Files...
IF %PROCESSOR_ARCHITECTURE%==x86 Goto Intel
Goto Alpha

:Intel
Echo   - WinNTDUMP
IF EXIST WinNTDUMP\frcASPI.txt (
  del /q /s WinNTDUMP > nul
  rd WinNTDUMP > nul
) ELSE (
Echo   [ no dumped files to kill ]
)
Echo Done!
Echo.
Echo Your dumped files have been killed.
Goto End

:Alpha
Echo Alpha CPU Detected.
Echo Sorry, only Intel x86 and compatible platforms are supported.
Goto End

:End
SET ver=
pause
exit
