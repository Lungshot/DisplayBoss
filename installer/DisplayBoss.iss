[Setup]
AppId={{B8E3F2A1-5C4D-4E6F-9A7B-1D2E3F4A5B6C}
AppName=DisplayBoss
AppVersion=1.0.0
AppPublisher=Lungshot
AppPublisherURL=https://github.com/Lungshot/Displayboss
DefaultDirName={autopf}\DisplayBoss
DefaultGroupName=DisplayBoss
UninstallDisplayIcon={app}\DisplayBoss.exe
OutputDir=..\publish
OutputBaseFilename=DisplayBoss-1.0.0-Setup
SetupIconFile=..\Dlogo.ico
Compression=lzma2
SolidCompression=yes
PrivilegesRequired=lowest
ArchitecturesInstallIn64BitMode=x64compatible
WizardStyle=modern
LicenseFile=
DisableProgramGroupPage=yes
CloseApplications=force

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "..\publish\final\DisplayBoss.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\publish\final\DisplayBoss.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\publish\final\DisplayBoss.deps.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\publish\final\DisplayBoss.runtimeconfig.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\publish\final\DisplayBoss.Core.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\publish\final\displayboss-cli.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\publish\final\displayboss-cli.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\publish\final\displayboss-cli.deps.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\publish\final\displayboss-cli.runtimeconfig.json"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\DisplayBoss"; Filename: "{app}\DisplayBoss.exe"; IconFilename: "{app}\DisplayBoss.exe"
Name: "{autodesktop}\DisplayBoss"; Filename: "{app}\DisplayBoss.exe"; Tasks: desktopicon
Name: "{userstartup}\DisplayBoss"; Filename: "{app}\DisplayBoss.exe"; Tasks: startupicon

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop shortcut"; GroupDescription: "Additional shortcuts:"
Name: "startupicon"; Description: "Start DisplayBoss with &Windows"; GroupDescription: "Startup:"; Flags: checkedonce
Name: "addtopath"; Description: "Add CLI tool to system &PATH"; GroupDescription: "CLI:"

[Run]
Filename: "{app}\DisplayBoss.exe"; Description: "Launch DisplayBoss"; Flags: nowait postinstall skipifsilent

[Registry]
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "Path"; ValueData: "{olddata};{app}"; Tasks: addtopath; Check: NeedsAddPath(ExpandConstant('{app}'))

[Code]
function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', OrigPath) then
  begin
    Result := True;
    exit;
  end;
  Result := Pos(';' + Param + ';', ';' + OrigPath + ';') = 0;
end;

[UninstallDelete]
Type: files; Name: "{app}\*"
Type: dirifempty; Name: "{app}"
