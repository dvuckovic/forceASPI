Var WINVER
Var BACKERR
Var ENDTYPE
SetCompressor lzma
XPStyle on
Name "forceASPI"
BrandingText " "
SetFont "MS Sans Serif" "8"
CompletedText " "
InstallColors 000000 FFFFFF
Icon "aspi.ico"
Caption "forceASPI Installer"
InstProgressFlags
ShowInstDetails show
AutoCloseWindow false
MiscButtonText "< Back" "Next >" "Cancel" "Next >"
OutFile "forceASPI.exe"
LicenseData "license.txt"
LicenseBkColor FFFFFF
SubCaption 0 " > Readme"
SubCaption 2 " > Backup folder"
SubCaption 3 " > Backing up..."
SubCaption 4 " > Completed backup operations"
PageEx license
	LicenseText "Please read thoroughly text in the box below before proceeding..." "Proceed"
PageExEnd
PageEx directory
	DirText "$WINVER ASPI32 installation detected. Please confirm or browse a backup folder for your current ASPI32 installation."
	PageCallbacks .initDir
PageExEnd
Page instfiles
Section "-Program files"
	IntCmp $BACKERR 1 noreboot
	DetailPrint "Backing up current $WINVER ASPI32 layer..."
	SetOutPath $INSTDIR
	File "restoreASPI.exe"
	StrCmp $WINVER "WinNT" winnt 0
	IfFileExists "$SYSDIR\winaspi.dll" 0 err_winaspi
		CopyFiles /SILENT "$SYSDIR\winaspi.dll" "$INSTDIR\"
		DetailPrint "Backed up file: winaspi.dll"
	GoTo wnaspi32
err_winaspi:
	DetailPrint "winaspi.dll not found! File could not be backed up!"
wnaspi32:
	IfFileExists "$SYSDIR\wnaspi32.dll" 0 err_wnaspi32
		CopyFiles /SILENT "$SYSDIR\wnaspi32.dll" "$INSTDIR\"
		DetailPrint "Backed up file: wnaspi32.dll"
	GoTo aspienum
err_wnaspi32:
	DetailPrint "wnaspi32.dll not found! File could not be backed up!"
aspienum:
	IfFileExists "$SYSDIR\aspienum.vxd" 0 err_aspienum
		CopyFiles /SILENT "$SYSDIR\aspienum.vxd" "$INSTDIR\"
		DetailPrint "Backed up file: aspienum.vxd"
	GoTo apix
err_aspienum:
	DetailPrint "aspienum.vxd not found! File could not be backed up!"
apix:
	IfFileExists "$SYSDIR\iosubsys\apix.vxd" 0 err_apix
		CopyFiles /SILENT "$SYSDIR\iosubsys\apix.vxd" "$INSTDIR\"
		DetailPrint "Backed up file: apix.vxd"
	GoTo done
err_apix:
	DetailPrint "apix.vxd not found! File could not be backed up!"
	GoTo done
winnt:
	IfFileExists "$WINDIR\system\winaspi.dll" 0 err_winaspi2
		CopyFiles /SILENT "$WINDIR\system\winaspi.dll" "$INSTDIR\"
		DetailPrint "Backed up file: winaspi.dll"
	GoTo wowpost
err_winaspi2:
	DetailPrint "winaspi.dll not found! File could not be backed up!"
wowpost:
	IfFileExists "$WINDIR\system\wowpost.exe" 0 err_wowpost
		CopyFiles /SILENT "$WINDIR\system\wowpost.exe" "$INSTDIR\"
		DetailPrint "Backed up file: wowpost.exe"
	GoTo wnaspi322
err_wowpost:
	DetailPrint "wowpost.exe not found! File could not be backed up!"
wnaspi322:
	IfFileExists "$SYSDIR\wnaspi32.dll" 0 err_wnaspi322
		CopyFiles /SILENT "$SYSDIR\wnaspi32.dll" "$INSTDIR\"
		DetailPrint "Backed up file: wnaspi32.dll"
	GoTo aspi32
err_wnaspi322:
	DetailPrint "wnaspi32.dll not found! File could not be backed up!"
aspi32:
	IfFileExists "$SYSDIR\drivers\aspi32.sys" 0 err_aspi32
		CopyFiles /SILENT "$SYSDIR\drivers\aspi32.sys" "$INSTDIR\"
		DetailPrint "Backed up file: aspi32.sys"
	GoTo done
err_aspi32:
	DetailPrint "aspi32.sys not found! File could not be backed up!"
done:
	DetailPrint "Current $WINVER ASPI32 layer backed up!"
	DetailPrint "Killing current $WINVER ASPI32 layer..."
	SetErrors
	StrCmp $WINVER "WinNT" winaspi4 0
	IfFileExists "$SYSDIR\winaspi.dll" 0 err_winaspi3
		Delete /REBOOTOK "$SYSDIR\winaspi.dll"
		DetailPrint "Deleted file: winaspi.dll"
		ClearErrors
		GoTo wnaspi323
err_winaspi3:
	DetailPrint "winaspi.dll not found! File could not be deleted!"
wnaspi323:
	IfFileExists "$SYSDIR\wnaspi32.dll" 0 err_wnaspi323
		Delete /REBOOTOK "$SYSDIR\wnaspi32.dll"
		DetailPrint "Deleted file: wnaspi32.dll"
		ClearErrors
		GoTo aspienum2
err_wnaspi323:
	DetailPrint "wnaspi32.dll not found! File could not be deleted!"
aspienum2:
	IfFileExists "$SYSDIR\aspienum.vxd" 0 err_aspienum2
		Delete /REBOOTOK "$SYSDIR\aspienum.vxd"
		DetailPrint "Deleted file: aspienum.vxd"
		ClearErrors
		GoTo apix2
err_aspienum2:
	DetailPrint "aspienum.vxd not found! File could not be deleted!"
apix2:
	IfFileExists "$SYSDIR\iosubsys\apix.vxd" 0 err_apix2
		Delete /REBOOTOK "$SYSDIR\iosubsys\apix.vxd"
		DetailPrint "Deleted file: apix.vxd"
		ClearErrors
		GoTo done2
err_apix2:
	DetailPrint "apix.vxd not found! File could not be deleted!"
	GoTo done2
winaspi4:
	IfFileExists "$WINDIR\system\winaspi.dll" 0 err_winaspi4
		Delete /REBOOTOK "$WINDIR\system\winaspi.dll"
		DetailPrint "Deleted file: winaspi.dll"
		ClearErrors
		GoTo wowpost2
err_winaspi4:
	DetailPrint "winaspi.dll not found! File could not be deleted!"
wowpost2:
	IfFileExists "$WINDIR\system\wowpost.exe" 0 err_wowpost2
		Delete /REBOOTOK "$WINDIR\system\wowpost.exe"
		DetailPrint "Deleted file: wowpost.exe"
		ClearErrors
		GoTo wnaspi324
err_wowpost2:
	DetailPrint "wowpost.exe not found! File could not be deleted!"
wnaspi324:
	IfFileExists "$SYSDIR\wnaspi32.dll" 0 err_wnaspi324
		Delete /REBOOTOK "$SYSDIR\wnaspi32.dll"
		DetailPrint "Deleted file: wnaspi32.dll"
		ClearErrors
		GoTo aspi322
err_wnaspi324:
	DetailPrint "wnaspi32.dll not found! File could not be deleted!"
aspi322:
	IfFileExists "$SYSDIR\drivers\aspi32.sys" 0 err_aspi322
		Delete /REBOOTOK "$SYSDIR\drivers\aspi32.sys"
		DetailPrint "Deleted file: aspi32.sys"
		ClearErrors
		GoTo done2
err_aspi322:
	DetailPrint "aspi32.sys not found! File could not be deleted!"
done2:
	IfErrors noreboot 0
		DetailPrint "$WINVER ASPI32 layer killed!"
		DetailPrint "Unpacking installation..."
		SetOutPath "$TEMP\forceASPI"
		File "installASPI.exe"
		DetailPrint "Writing startup key..."
		WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\RunOnce" "Continue forceASPI installation" "$TEMP\forceASPI\installASPI.exe"
		DetailPrint "Click Next to reboot and continue with instalation..."
		IntFmt $ENDTYPE "%u" 2
		GoTo exit_section
noreboot:
	DetailPrint "No $WINVER ASPI32 layer found!"
	DetailPrint "Skipping reboot..."
	SetOutPath "$TEMP\forceASPI"
	File "installASPI.exe"
	DetailPrint "Click Next to continue with installation..."
	IntFmt $ENDTYPE "%u" 1
exit_section:
SectionEnd
Function .onGUIEnd
	IntCmp $ENDTYPE 1 toinstall
	IntCmp $ENDTYPE 2 toreboot	
	Quit
toinstall:
	Exec "$TEMP\forceASPI\installASPI.exe"
	Quit
toreboot:
	MessageBox MB_OK " forceASPI need to reboot your computer$\n \
						in order to finalize installation. Please$\n \
						close all programs and click OK."
	Reboot
	IfErrors 0
	Quit
FunctionEnd
Function .onInit
	IntFmt $BACKERR "%u" 0
	IntFmt $ENDTYPE "%u" 0
FunctionEnd
Function .initDir
	ReadEnvStr $WINVER "OS"
	StrCmp $WINVER "Windows_NT" winnt 0
	StrCpy $WINVER "Win9x"
	IfFileExists "$SYSDIR\winaspi.dll" 0 chk_wnaspi
		ClearErrors
chk_wnaspi:
	IfFileExists "$SYSDIR\wnaspi32.dll" 0 chk_aspienum
		ClearErrors
chk_aspienum:
	IfFileExists "$SYSDIR\aspienum.vxd" 0 chk_apix
		ClearErrors
chk_apix:
	IfFileExists "$SYSDIR\iosubsys\apix.sys" 0 chk_done
		ClearErrors
	GoTo chk_done
winnt:
	StrCpy $WINVER "WinNT"
	SetErrors
	IfFileExists "$WINDIR\system\winaspi.dll" 0 chk_wowpost
		ClearErrors
chk_wowpost:
	IfFileExists "$WINDIR\system\wowpost.exe" 0 chk_wnaspi32
		ClearErrors
chk_wnaspi32:
	IfFileExists "$SYSDIR\wnaspi32.dll" 0 chk_aspi32
		ClearErrors
chk_aspi32:
	IfFileExists "$SYSDIR\drivers\aspi32.sys" 0 chk_done
		ClearErrors
chk_done:
	StrCpy $INSTDIR "C:\ASPI32-$WINVER-Backup"
	IfErrors 0 done
	IntFmt $BACKERR "%u" 1
	Abort
done:
FunctionEnd