; Simple install script for a Windows Photoshop Plugin
; Written for the FilterMeister plugin community
; by Kohan Ikin / namesuppressed.com
; syneryder@namesuppressed.com
;
; Includes contributions by the following:
;   Martijn van der Lee / vanderlee.com

; Change these values to those for your own plugin
#define CompanyName     "My Company"
#define ProductName     "My Example Plugin"
#define MajorVersion    "2"
#define VersionNumber   "2.0"
#define FullVersion     "2.0.0.0"
#define CopyrightYear   "2016"
#define CompanyURL      "http://www.example.com/"
#define SupportURL      "http://www.example.com/"
#define InstallName     "ExamplePluginInstall"

; "Plug-in" spelling.
; This defines how the word "Plug-in" should be spelled in the
; various languages. Specify the capitalized form; the word will
; be automatically uncapitalized if needed.
#define english_Plugin "Plug-in"
#define brazilianportuguese_Plugin "Plug-in"
#define catalan_Plugin "Plug-in"
#define czech_Plugin "Plug-in"
#define danish_Plugin "Plug-in"
#define dutch_Plugin "Plug-in"
#define finnish_Plugin "Plug-in"
#define french_Plugin "Plug-in"
#define german_Plugin "Plug-in"
#define hebrew_Plugin "Plug-in"
#define hungarian_Plugin "Plug-in"
#define italian_Plugin "Plug-in"
#define japanese_Plugin "Plug-in"
#define norwegian_Plugin "Plug-in"
#define polish_Plugin "Plug-in"
#define portuguese_Plugin "Plug-in"
#define russian_Plugin "Plug-in"
#define slovenian_Plugin "Plug-in"
#define spanish_Plugin "Plug-in"
#define greek_Plugin "Plug-in"

; Specify a list of files to install to the installation directory.
; If you want to share physical files on disk, this would be the 
; most common place to install those files.
#dim InstallFiles[1]
#define InstallFiles[0] "install.txt"

; Specify a list of common files to install for both the 32-bit &
; 64-bit version of your installation.
; If you don't have any common files, then comment these lines out.
#dim Files[1]
#define Files[0]        "common.txt"

; Specify a list of files to install for the 32-bit version only.
; If you don't have any 32-bit files, then comment these lines out.
#dim Files32[1]
#define Files32[0]      "example32.8bf"

; Specify a list of files to install for the 64-bit version only.
; If you don't have any 64-bit files, then comment these lines out.
#dim Files64[1]
#define Files64[0]      "example64.8bf"

; The License file must be agreed to by the user before installing.
#define LicenseFileName "Files\license.txt"

; The ReadMe file will be shown after installation by default.
#define ReadMeFile      "Files\readme.txt"

; If you don't want a background, delete this line.
;#define UseInstallBackground

; By default, the uninstaller and any specified InstallFiles files, but
; not the plugin itself, will be installed in a predefined subdirectory
; of "Program Files" (or the x86 equivalent). The user will not be asked
; to specify this folder.
; Comment out if you don't want to ask the user for the install directory
;#define AskInstallDirectory

; Allow the user to specify a custom directory to install the plugin to.
; Comment out if you want to disable this feature
#define CustomDirectory

; Comment this line out if you don't want to use Company / Vendor names
; (eg Adobe, Jasc, Corel, Serif) when describing graphics programs.
#define UseVendorNames

; Code signing with Authenticode certificate.  If you don't have a code
; signing certificate (eg from Comodo or Verisign) leave this commented out.
; Uncomment only one of UseKSign or UseSignTool, depending which you use.
;#define SignInstaller
;#define UseKSign
;#define UseSignTool
;#define PFXFile "C:\Full_Path_To_Your_PFX_File\example_certificate.pfx"
;#define PFXPassword "PASSWORD"
;#define TimestampServer "http://timestamp.comodoca.com/authenticode"



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; You should not need to change anything below this for a simple install.  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Setup]
AppName={#ProductName}
AppVerName={#ProductName} {#VersionNumber}
AppVersion={#VersionNumber}
VersionInfoVersion={#FullVersion}
AppPublisher={#CompanyName}
AppPublisherURL={#CompanyURL}
AppContact={#ProductName} Customer Support
AppSupportURL={#SupportURL}
AppCopyright=Copyright ©{#CopyrightYear} by {#CompanyName}
UsePreviousAppDir=yes
UsePreviousGroup=yes
ShowTasksTreeLines=yes
DefaultDirName={pf}\{#ProductName} {#MajorVersion}
DefaultGroupName={#ProductName} {#MajorVersion}
OutputBaseFilename={#InstallName}

; Compression method. By default, lzma2/max compression is used, which
; typically offers the best compression rate.
;Compression=lzma

; Solid compression creates a smaller installer executable, at the cost of
; additional time during installation.
;SolidCompression=yes

; Enable these to change images in the installer
;SetupIconFile=Saki-Snowish-Install.ico
;WizardSmallImageFile=wizardsmall.bmp

; Enable these to show a background gradient.
; If you don't want a background, delete these lines
#ifdef UseInstallBackground
  BackColor=$000000
  BackColor2=$660000
  WindowShowCaption=no
  WindowVisible=yes
#endif

; Optionally display a user license if defined
#ifdef LicenseFileName
  LicenseFile = {#LicenseFileName}
#endif

; Keep all blank for 32-bit only install. Set to x64 for 64-bit (non-Itanium) installs.
; Remember that x86 is 32-bit, x64 is 64-bit!
ArchitecturesAllowed=x86 x64
ArchitecturesInstallIn64BitMode=x64

; Code signing with Authenticode certificate.
; The following demonstrates using the "kSign" tool by K Software to sign
; installers. The example used a self-signed PFX certificate. Note that self-
; signed certificates are not recognized by computers other than your own;
; you must get a certificate from a Certificate Authority (CA) trusted by
; Microsoft.
; 1. Setup kSign
; 1a. Download and install kSign (free) from http://codesigning.ksoftware.net/
; 1b. Find the path where kSign was installed.
; 1c. In Inno Setup, go to menu "Tools" > "Configure Sign Tools...".
; 1d. Add a new Sign Tool, named "ksign" with command "<PATH TO KSIGN>\kSignCMD.exe $p".
; 2. Obtain a "Microsoft Authenticode" certificate from any provider.
; 3. Change the SignTool directive. 
; 3a. Specify the full path to the certificate (relative path won't work).
; 3b. Specify the password for the certificate (in our example "PASSWORD").
; 3c. Optionally, specify a description (/d) and/or URL (/du).
; Self-signed certificate generated using https://www.pluralsight.com/blog/software-development/selfcert-create-a-self-signed-certificate-interactively-gui-or-programmatically-in-net
#ifdef SignInstaller
  #ifdef UseKSign
    SignTool=kSign /f "{#PFXFile}" /p {#PFXPassword} /d "{#ProductName} {#VersionNumber}" /du "{#CompanyURL}" $f
  #endif
  #ifdef UseSignTool
    SignTool=signtool sign /f $q{#PFXFile}$q /p {#PFXPassword} /fd sha256 /td sha256 /tr {#TimestampServer} /as /d $q{#ProductName} {#VersionNumber}$q /du $q{#CompanyURL}$q  $f
    SignTool=signtool sign /f $q{#PFXFile}$q /p {#PFXPassword} /fd sha1 /td sha1 /tr {#TimestampServer} /as /d $q{#ProductName} {#VersionNumber}$q /du $q{#CompanyURL}$q $f
  #endif
#endif



; This is required for the InnoSetup preprocessor (ISPP). Do not change it.
#define I

[Files]
#sub InstallFile
  Source: "Files/{#InstallFiles[I]}"; DestDir: "{app}"; Flags: ignoreversion
#endsub
#for {I = 0; I < DimOf(InstallFiles); I++} InstallFile

#sub FileEntry
  Source: "Files/{#Files[I]}"; DestDir: "{app}"; Flags: ignoreversion dontcopy
#endsub
#for {I = 0; I < DimOf(Files); I++} FileEntry

#sub File32Entry
  Source: "Files/{#Files32[I]}"; DestDir: "{app}"; Flags: ignoreversion dontcopy; Check: not Is64BitInstallMode
#endsub
#for {I = 0; I < DimOf(Files32); I++} File32Entry

#sub File64Entry
  Source: "Files/{#Files64[I]}"; DestDir: "{app}"; Flags: ignoreversion dontcopy; check: Is64BitInstallMode
#endsub
#for {I = 0; I < DimOf(Files64); I++} File64Entry

#ifdef ReadMeFile
 Source: "{#ReadMeFile}"; DestDir: "{app}"; Flags: isreadme solidbreak
#endif

#include "common/locale.iss"

[Tasks]
Name: "InstallPluginTask"; Description: "{#ProductName} {#MajorVersion}"; GroupDescription: "{cm:InstallPluginsInto}";
#ifdef CustomDirectory
  Name: "CustomDirTask"; Description: "{cm:CustomDirTask}"; GroupDescription: "{cm:InstallPluginsInto}"; Flags: unchecked
#endif

[Registry]
Root: HKCU; Subkey: "Software\{#CompanyName}"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\{#CompanyName}\{#ProductName} {#MajorVersion}"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\{#CompanyName}"; Flags: uninsdeletekeyifempty
Root: HKLM; Subkey: "Software\{#CompanyName}\{#ProductName} {#MajorVersion}"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\{#CompanyName}\{#ProductName} {#MajorVersion}"; ValueName: "InstallPath"; ValueType: String; ValueData: "{app}\"; Flags: uninsdeletevalue 

[UninstallDelete]
Type: dirifempty; Name: "{app}\"; 

[Code]
////////////////////////////////////////
// Important global constant definitions
////////////////////////////////////////

type TPluginFolder = record
  VendorName     : string;
  ProductName    : string;
  Version        : string;
  IsSixtyFourBit : Boolean;
  Folder         : string;
end;

type TArrayOfPluginFolders = array of TPluginFolder;

const sLineBreak = #13#10;

var
  pluginFolders: TArrayOfPluginFolders;
  externalProgramsAdded: Boolean;
  CustomDirPage: TInputDirWizardPage;

#include "common/detect.iss"
#include "common/install.iss"

/////////////////////////////////////////////////////////////////////////////
/// Innosetup Install Control Functions
/////////////////////////////////////////////////////////////////////////////

//---------------------------------------------------------------------------
// Add the detected plugins to the task list
procedure GenerateTaskList();
var
  I: Integer;
  productLabel: string;
begin
  if externalProgramsAdded = False then
  begin
    // Check and disable the top (install) task
    WizardForm.TasksList.Checked[1]     := True;
    WizardForm.TasksList.ItemEnabled[1] := False;

    // Now add all the graphics programs we found installed
    for I := 0 to GetArrayLength(pluginFolders) - 1 do
    begin
      #ifdef UseVendorNames
        productLabel := pluginFolders[I].VendorName + ' ' + pluginFolders[I].ProductName
      #else
        productLabel := pluginFolders[I].ProductName;
      #endif
      WizardForm.TasksList.AddCheckBox(productLabel, '', 0, true, true, false, false, nil);
    end;
  end;
  externalProgramsAdded := True;
end;

//---------------------------------------------------------------------------
// Add checked plugin tasks to the list of tasks reported will be installed
// Also adds the directory name of the customdir, if checked
procedure ShowPluginTasks();
var
  I: Integer;
  offset: Integer;
  CustomPluginFolder: TPluginFolder;
  productLabel: string;
begin
  #ifdef CustomDirectory
    // Add the directory path if customdir is used
    if IsTaskSelected('CustomDirTask') and not (CustomDirPage.Values[0] = '') then
    begin
      Wizardform.ReadyMemo.Lines.Add(StringOfChar(' ', 4 * 3) + CustomDirPage.Values[0]);
    end;
  #endif

  // Add the plugins
  for I := 0 to GetArrayLength(pluginFolders) - 1 do
  begin
    // Note on the TasksList offset:
    // WizardForm.TasksList starts at 1 (1-based array, not 0-based).
    // TasksList[1] refers to the always ticked Program Files folder,
    // so our offset needs to start at 2.
    #ifdef CustomDirectory
      // When enabled, we also need to +1 the offset to skip over the
      // User Defined plugin folder, to start at item #3.
      offset := 3
    #else
      offset := 2
    #endif
    if WizardForm.TasksList.Checked[I + offset] then
    begin
      #ifdef UseVendorNames
        productLabel := pluginFolders[I].VendorName + ' ' + pluginFolders[I].ProductName
      #else
        productLabel := pluginFolders[I].ProductName;
      #endif
      Wizardform.ReadyMemo.Lines.Add(StringOfChar(' ', 3 * 3) + productLabel);
    end;
  end;

  #ifdef CustomDirectory
    // Add the CustomDir to the list of plugins if used
    if IsTaskSelected('CustomDirTask') and not (CustomDirPage.Values[0] = '') then
    begin
      CustomPluginFolder.IsSixtyFourBit := Is64BitInstallMode;
      CustomPluginFolder.Folder := AddBackslash(CustomDirPage.Values[0]);
      AddToPluginFolders(CustomPluginFolder, pluginFolders);
    end
  #endif
end;

//---------------------------------------------------------------------------
// Add an extra page to ask for a custom directory, after selecting tasks
procedure InitializeWizard();
begin
  GetPluginFolders('');

  #ifdef CustomDirectory
    CustomDirPage := CreateInputDirPage(wpSelectTasks,
      CustomMessage('CustomDirCaption'), CustomMessage('CustomDirDescription'), CustomMessage('CustomDirSubCaption'),
      False, '');
    CustomDirPage.Add('');
    CustomDirPage.Values[0] := GetPreviousData('CustomDir', ExpandConstant('{pf}\{#ProductName} {#MajorVersion}'));
  #endif
end;

//---------------------------------------------------------------------------
// Register the customdir for uninstalling
procedure RegisterPreviousData(PreviousDataKey: Integer);
begin
  #ifdef CustomDirectory
    SetPreviousData(PreviousDataKey, 'CustomDir', CustomDirPage.Values[0]);
  #endif
end;

//---------------------------------------------------------------------------
// Skip pages depending on developer and/or user choices
function ShouldSkipPage(PageID: Integer): Boolean;
begin
  #ifdef CustomDirectory
    if (PageId = CustomDirPage.id) and not IsTaskSelected('CustomDirTask') then
      Result := True
    else
  #endif

  #ifndef AskInstallDirectory
    if (PageId = wpSelectDir) then
      Result := True
    else
  #endif

  Result := False
end;

//---------------------------------------------------------------------------
// Page flow during install
// Code adapted from http://stackoverflow.com/questions/10490046/how-do-read-and-set-the-value-of-a-checkbox-in-an-innosetup-wizard-page
procedure CurPageChanged(CurPageID: Integer);
begin
  // On the Installing page, check which tasks were checked.
  // We'll need to run code here to install the plugins
  // to their respective folders here (except that goes on wpInstalling)
  case CurPageID of
    // If the user has clicked back to the ProgramGroup screen,
    // the task list has been deleted, so we need to set a flag
    // here so we know to recreate the Tasks list again.
    wpLicense:
      externalProgramsAdded := False;

    wpSelectProgramGroup:
      externalProgramsAdded := False;

    wpSelectDir:
      externalProgramsAdded := False;

    wpSelectTasks:
      GenerateTaskList();

    wpReady:
      ShowPluginTasks();

    wpInstalling:
      InstallPlugins();
  end;
end;

//---------------------------------------------------------------------------
// Page flow during uninstall
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  case CurUninstallStep of
    usUninstall:
      UninstallPlugins();
  end;
end;
