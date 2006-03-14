[_TopOfScript]
; This is a Innoscript generate with ScriptMaker version  5.1.6.7 

[_Project]
ProjectNr=0.1.0.0
ProjectName=
ProjectExeFileName=
ProjectMainFileName=C:\Documents and Settings\André\Desktop\crap.iss
ProjectAuthor=Copyright © 2006 Drapeau
ProjectCreateDate=3/13/2006
ProjectAccessDate=3/13/2006 6:41:06 PM

[_ISPP]
#Pragma Option -v+
#Pragma VerboseLevel 9 ;Macro and functions successfull call acknowledgements
#Pragma SpanSymbol "\"
#Define AppVersion "0.1.0.0" ;Here the Software versionsnumber
#define AppID ""
#define AppCopyright "Copyright © 2006 Drapeau"

[Setup]
AppName=Numgen 2006 XP Edition
AppVerName=Numgen 2006 XP Edition 0.1
AppPublisher=Paper Programs
AppPublisherURL=http://paperprogs.berlios.de
AppSupportURL=http://paperprogs.berlios.de
AppUpdatesURL=http://paperprogs.berlios.de
DefaultDirName={pf}\Paperprogs\Numgen2006
DefaultGroupName=PaperProgs\Numgen 2006 XP Edition
AllowNoIcons=yes
LicenseFile=C:\Documents and Settings\André\Desktop\gpl.txt
OutputDir=C:\Documents and Settings\André\Desktop
OutputBaseFilename=rand06setup
SetupIconFile=C:\Documents and Settings\André\Desktop\pp.ico
SolidCompression=yes
VersionInfoVersion=0.1.0.0
VersionInfoTextVersion=0.1.0.0
AppCopyright={#AppCopyright}
WizardImageBackColor=$00006600
WizardImageFile=C:\Documents and Settings\André\Desktop\leftpannel.bmp
WizardSmallImageFile=C:\Documents and Settings\André\Desktop\top.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[INI]
Filename: "{app}\rand.url"; Section: "InternetShortcut"; Key: "URL"; String: "http://paperprogs.berlios.de"

[Files]
Source: "D:\dump2\paperprogs\Numgen\rand.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\dump2\paperprogs\Numgen\splash.png"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\Numgen 2006 XP Edition"; Filename: "{app}\rand.exe"
Name: "{group}\{cm:ProgramOnTheWeb,Numgen 2006 XP Edition}"; Filename: "{app}\rand.url"
Name: "{group}\{cm:UninstallProgram,Numgen 2006 XP Edition}"; Filename: "{uninstallexe}"
Name: "{userdesktop}\Numgen 2006 XP Edition"; Filename: "{app}\rand.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Numgen 2006 XP Edition"; Filename: "{app}\rand.exe"; Tasks: quicklaunchicon

[UninstallDelete]
Type: files; Name: "{app}\rand.url"

[Run]
Filename: "{app}\rand.exe"; Description: "{cm:LaunchProgram,Numgen 2006 XP Edition}"; Flags: nowait postinstall skipifsilent

[_EndOfScript]
; © HiSoft2000 http://www.Hisoft2000.de Mail: HiSoft2000@HiSoft2000.de © 2002-2005
; Visual dBase, dB2K, dBase SE and dBase Plus © dataBased Intelligence.Inc Homepage: http://www.databi.com/
; dQuery for Delphi,C++,dBASE PLUS © dataBased Intelligence.Inc see also Homepage: http://www.dQuery.com/
