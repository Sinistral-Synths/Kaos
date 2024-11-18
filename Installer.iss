#define MyAppName "Kaos"

[Setup]
AppName={#MyAppName}
AppVersion=1.0
AppPublisher="Kedar Panchal"
ArchitecturesInstallIn64BitMode=x64compatible
DefaultDirName={commonpf}\VST3\{#MyAppName}
LicenseFile="./LICENSE"
OutputBaseFilename="KaosInstaller"
Compression=lzma
SolidCompression=yes
ChangesEnvironment=yes
ShowLanguageDialog=no

[Components]
Name: "main"; Description: "Kaos Installation"; Types: full custom; Flags: fixed;
Name: "csound"; Description: "Installs CSound (skip if you have CSound 6.17 or later already installed)"; Types: full;

[Dirs]
Name: "{app}\images"; Permissions: users-full;