Var WINVER
SetCompressor lzma
XPStyle on
Name "forceASPI"
BrandingText " "
SetFont "MS Sans Serif" "8"
CompletedText "Operations completed successfully!"
InstallColors 000000 FFFFFF
Icon "aspi.ico"
Caption "forceASPI Installer"
InstProgressFlags
ShowInstDetails show
OutFile "installASPI.exe"
PageEx instfiles
	Caption " > Installing..."
PageExEnd
Section "-Program files"
	ReadEnvStr $WINVER "OS"
	StrCmp $WINVER "Windows_NT" winnt 0
	StrCpy $WINVER "Win9x"
	DetailPrint "Installing $WINVER ASPI32 layer..."
	SetOutPath "$SYSDIR"
	File "WIN9X\winaspi.dll"
	DetailPrint "Copied file: winaspi.dll"
	File "WIN9X\wnaspi32.dll"
	DetailPrint "Copied file: wnaspi32.dll"
	File "WIN9X\aspienum.vxd"
	DetailPrint "Copied file: aspienum.vxd"
	SetOutPath "$SYSDIR\iosubsys"
	File "WIN9X\apix.vxd"
	DetailPrint "Copied file: apix.vxd"
	DetailPrint "Adding registry settings..."
	WriteRegStr HKLM "SYSTEM\CurrentControlSet\Services\VxD\APIX" "ExcludeMiniports" ""
	WriteRegDWORD HKLM "SYSTEM\CurrentControlSet\Services\VxD\ASPIENUM" "Start" "00000000"
	WriteRegStr HKLM "SYSTEM\CurrentControlSet\Services\VxD\ASPIENUM" "StaticVxD" "ASPIENUM.VXD"
	GoTo done
winnt:
	StrCpy $WINVER "WinNT"
	DetailPrint "Installing $WINVER ASPI32 layer..."
	SetOutPath "$WINDIR\system"
	File "WINNT\winaspi.dll"
	DetailPrint "Copied file: winaspi.dll"
	File "WINNT\wowpost.exe"
	DetailPrint "Copied file: wowpost.exe"
	SetOutPath "$SYSDIR"
	File "WINNT\wnaspi32.dll"
	DetailPrint "Copied file: wnaspi32.dll"
	SetOutPath "$SYSDIR\drivers"
	File "WINNT\aspi32.sys"
	DetailPrint "Copied file: aspi32.sys"
	DetailPrint "Adding registry settings..."
	WriteRegDWORD HKLM "SYSTEM\CurrentControlSet\Services\ASPI32" "ErrorControl" "00000001"
	WriteRegDWORD HKLM "SYSTEM\CurrentControlSet\Services\ASPI32" "Start" "00000001"
	WriteRegDWORD HKLM "SYSTEM\CurrentControlSet\Services\ASPI32" "Type" "00000001"
	WriteRegStr HKLM "SYSTEM\CurrentControlSet\Services\ASPI32\Parameters" "ExcludeMiniports" ""
done:	
	Delete /REBOOTOK "$EXEDIR\*.*"
	RMDir /REBOOTOK $EXEDIR
	MessageBox MB_OK " Adaptec ASPI 4.60 (1021) installed.$\n \
					System will now reboot!"
	Reboot
	IfErrors 0
	Quit
SectionEnd
#Function .onGUIEnd
#	Delete /REBOOTOK "$EXEDIR\*.*"
#	RMDir /REBOOTOK $EXEDIR
#FunctionEnd