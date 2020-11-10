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
OutFile "restoreASPI.exe"
PageEx instfiles
	Caption " > Restoring..."
PageExEnd
Section "-Program files"
	ReadEnvStr $WINVER "OS"
	StrCmp $WINVER "Windows_NT" winnt 0
	StrCpy $WINVER "Win9x"
	IfFileExists "$EXEDIR\winaspi.dll" 0 chk_wnaspi
		ClearErrors
chk_wnaspi:
	IfFileExists "$EXEDIR\wnaspi32.dll" 0 chk_aspienum
		ClearErrors
chk_aspienum:
	IfFileExists "$EXEDIR\aspienum.vxd" 0 chk_apix
		ClearErrors
chk_apix:
	IfFileExists "$EXEDIR\apix.sys" 0 chk_done
		ClearErrors
	GoTo chk_done
winnt:
	StrCpy $WINVER "WinNT"
	SetErrors
	IfFileExists "$EXEDIR\winaspi.dll" 0 chk_wowpost
		ClearErrors
chk_wowpost:
	IfFileExists "$EXEDIR\wowpost.exe" 0 chk_wnaspi32
		ClearErrors
chk_wnaspi32:
	IfFileExists "$EXEDIR\wnaspi32.dll" 0 chk_aspi32
		ClearErrors
chk_aspi32:
	IfFileExists "$EXEDIR\aspi32.sys" 0 chk_done
		ClearErrors
chk_done:
	IfErrors 0 cont
	MessageBox MB_OK|MB_ICONSTOP "No backup files found!"
	Quit
cont:
	MessageBox MB_YESNO|MB_ICONQUESTION " This will restore previous ASPI32 layer.$\n \
										Continue?" IDNO exit
	GoTo cont2
exit:
	Quit
cont2:							
	StrCmp $WINVER "WinNT" winnt2 0
	DetailPrint "Killing current $WINVER ASPI32 layer..."
	IfFileExists "$SYSDIR\winaspi.dll" 0 err_winaspi
		Delete /REBOOTOK "$SYSDIR\winaspi.dll"
		DetailPrint "Deleted file: winaspi.dll"
		GoTo wnaspi32
err_winaspi:
	DetailPrint "winaspi.dll not found! File could not be deleted!"
wnaspi32:
	IfFileExists "$SYSDIR\wnaspi32.dll" 0 err_wnaspi32
		Delete /REBOOTOK "$SYSDIR\wnaspi32.dll"
		DetailPrint "Deleted file: wnaspi32.dll"
		GoTo aspienum
err_wnaspi32:
	DetailPrint "wnaspi32.dll not found! File could not be deleted!"
aspienum:
	IfFileExists "$SYSDIR\aspienum.vxd" 0 err_aspienum
		Delete /REBOOTOK "$SYSDIR\aspienum.vxd"
		DetailPrint "Deleted file: aspienum.vxd"
		GoTo apix
err_aspienum:
	DetailPrint "aspienum.vxd not found! File could not be deleted!"
apix:
	IfFileExists "$SYSDIR\iosubsys\apix.vxd" 0 err_apix
		Delete /REBOOTOK "$SYSDIR\iosubsys\apix.vxd"
		DetailPrint "Deleted file: apix.vxd"
		ClearErrors
		GoTo done
err_apix:
	DetailPrint "apix.vxd not found! File could not be deleted!"
	GoTo done
winnt2:
	DetailPrint "Killing current $WINVER ASPI32 layer..."
	IfFileExists "$WINDIR\system\winaspi.dll" 0 err_winaspi2
		Delete /REBOOTOK "$WINDIR\system\winaspi.dll"
		DetailPrint "Deleted file: winaspi.dll"
		GoTo wowpost
err_winaspi2:
	DetailPrint "winaspi.dll not found! File could not be deleted!"
wowpost:
	IfFileExists "$WINDIR\system\wowpost.exe" 0 err_wowpost
		Delete /REBOOTOK "$WINDIR\system\wowpost.exe"
		DetailPrint "Deleted file: wowpost.exe"
		GoTo wnaspi322
err_wowpost:
	DetailPrint "wowpost.exe not found! File could not be deleted!"
wnaspi322:
	IfFileExists "$SYSDIR\wnaspi32.dll" 0 err_wnaspi322
		Delete /REBOOTOK "$SYSDIR\wnaspi32.dll"
		DetailPrint "Deleted file: wnaspi32.dll"
		GoTo aspi32
err_wnaspi322:
	DetailPrint "wnaspi32.dll not found! File could not be deleted!"
aspi32:
	IfFileExists "$SYSDIR\drivers\aspi32.sys" 0 err_aspi32
		Delete /REBOOTOK "$SYSDIR\drivers\aspi32.sys"
		DetailPrint "Deleted file: aspi32.sys"
		GoTo done
err_aspi32:
	DetailPrint "aspi32.sys not found! File could not be deleted!"
done:
	DetailPrint "$WINVER ASPI32 layer killed!"
	DetailPrint "Restoring $WINVER ASPI32 layer..."
	StrCmp $WINVER "WinNT" winaspi4 0
	IfFileExists "$EXEDIR\winaspi.dll" 0 err_winaspi3
		CopyFiles /SILENT "$EXEDIR\winaspi.dll" "$SYSDIR\"
		DetailPrint "Copied file: winaspi.dll"
	GoTo wnaspi323
err_winaspi3:
	DetailPrint "wnaspi32.dll not found! File missing!"
wnaspi323:
	IfFileExists "$EXEDIR\wnaspi32.dll" 0 err_wnaspi323
		CopyFiles /SILENT "$EXEDIR\wnaspi32.dll" "$SYSDIR\"
		DetailPrint "Copied file: wnaspi32.dll"
	GoTo aspienum2
err_wnaspi323:
	DetailPrint "wnaspi32.dll not found! File missing!"
aspienum2:
	IfFileExists "$EXEDIR\aspienum.vxd" 0 err_aspienum2
		CopyFiles /SILENT "$EXEDIR\aspienum.vxd" "$SYSDIR\"
		DetailPrint "Copied file: aspienum.vxd"
	GoTo apix2
err_aspienum2:
	DetailPrint "aspienum.vxd not found! File missing!"
apix2:
	IfFileExists "$EXEDIR\apix.vxd" 0 err_apix2
		CopyFiles /SILENT "$EXEDIR\apix.vxd" "$SYSDIR\iosubsys\apix.vxd"
		DetailPrint "Copied file: aspienum.vxd"
	GoTo reg
err_apix2:
	DetailPrint "apix.vxd not found! File missing!"
reg:
	DetailPrint "Adding registry settings..."
	WriteRegStr HKLM "SYSTEM\CurrentControlSet\Services\VxD\APIX" "ExcludeMiniports" ""
	WriteRegDWORD HKLM "SYSTEM\CurrentControlSet\Services\VxD\ASPIENUM" "Start" "00000000"
	WriteRegStr HKLM "SYSTEM\CurrentControlSet\Services\VxD\ASPIENUM" "StaticVxD" "ASPIENUM.VXD"
	GoTo done2
winaspi4:
	IfFileExists "$EXEDIR\winaspi.dll" 0 err_winaspi4
		CopyFiles /SILENT "$EXEDIR\winaspi.dll" "$WINDIR\system\"
		DetailPrint "Copied file: winaspi.dll"
	GoTo wowpost2
err_winaspi4:
	DetailPrint "winaspi.dll not found! File missing!"
wowpost2:
	IfFileExists "$EXEDIR\wowpost.exe" 0 err_wowpost2
		CopyFiles /SILENT "$EXEDIR\wowpost.exe" "$WINDIR\system\"
		DetailPrint "Copied file: wowpost.exe"
	GoTo wnaspi324
err_wowpost2:
	DetailPrint "wowpost.exe not found! File missing!"
wnaspi324:
	IfFileExists "$EXEDIR\wnaspi32.dll" 0 err_wnaspi324
		CopyFiles /SILENT "$EXEDIR\wnaspi32.dll" "$SYSDIR\"
		DetailPrint "Copied file: wnaspi32.dll"
	GoTo aspi322
err_wnaspi324:
	DetailPrint "wnaspi32.dll not found! File missing!"
aspi322:
	IfFileExists "$EXEDIR\aspi32.sys" 0 err_aspi322
		CopyFiles /SILENT "$EXEDIR\aspi32.sys" "$SYSDIR\drivers\"
		DetailPrint "Copied file: aspi32.sys"
	GoTo reg2
err_aspi322:
	DetailPrint "aspi32.sys not found! File missing!"
reg2:
	DetailPrint "Adding registry settings..."
	WriteRegDWORD HKLM "SYSTEM\CurrentControlSet\Services\ASPI32" "ErrorControl" "00000001"
	WriteRegDWORD HKLM "SYSTEM\CurrentControlSet\Services\ASPI32" "Start" "00000001"
	WriteRegDWORD HKLM "SYSTEM\CurrentControlSet\Services\ASPI32" "Type" "00000001"
	WriteRegStr HKLM "SYSTEM\CurrentControlSet\Services\ASPI32\Parameters" "ExcludeMiniports" ""
done2:	
	Delete /REBOOTOK "$EXEDIR\*.*"
	RMDir /REBOOTOK $EXEDIR
	MessageBox MB_OK " Previous $WINVER ASPI32 layer restored.$\n \
					System will now reboot!"
	Reboot
	IfErrors 0
	Quit
SectionEnd
Function .onGUIEnd
	Delete /REBOOTOK "$EXEDIR\*.*"
	RMDir /REBOOTOK $EXEDIR
FunctionEnd