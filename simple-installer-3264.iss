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

; Specify a list of common files to install for both the 32-bit &
; 64-bit version of your installation.
; If you don't have any common files, then comment these lines out.
#dim Files[1]
#define Files[0] "common.txt"

; Specify a list of files to install for the 32-bit version only.
; If you don't have any 32-bit files, then comment these lines out.
#dim Files32[1]
#define Files32[0] "example32.8bf"

; Specify a list of files to install for the 64-bit version only.
; If you don't have any 64-bit files, then comment these lines out.
#dim Files64[1]
#define Files64[0] "example64.8bf"

; The License fill must be agreed to by the user before installing.
#define LicenseFileName "Files\license.txt"

; The ReadMe file will be shown after installation by default.
#define ReadMeFile      "Files\readme.txt"

; If you don't want a background, delete this line.
#define UseInstallBackground "USEBACKGROUND"

; Support for code-signing (both with SHA-1 and SHA-256 certificates)
; is possible, but not included in this script yet.  SignTool is the
; [Setup] command you'll need to use.  I highly recommend using kSign
; from kSoftware for your code-signing, so you don't have to download
; the entire Windows Platform SDK just to get a code signing app.



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
DefaultDirName={code:GetPluginFolders}\{#ProductName} {#MajorVersion}
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
#ifdef LicenseFile
  LicenseFile = {#LicenseFile}
#endif

; Keep all blank for 32-bit only install. Set to x64 for 64-bit (non-Itanium) installs.
; Remember that x86 is 32-bit, x64 is 64-bit!
ArchitecturesAllowed=x86 x64
ArchitecturesInstallIn64BitMode=x64



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The following is required for the Inno-Setup preprocessor and should not be changed. ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#define I



[Files]
#sub FileEntry
  Source: "Files/{#Files[I]}"; DestDir: "{app}"; Flags: ignoreversion
#endsub
#for {I = 0; I < DimOf(Files); I++} FileEntry

#sub File32Entry
  Source: "Files/{#Files32[I]}"; DestDir: "{app}"; Flags: ignoreversion; Check: not Is64BitInstallMode
#endsub
#for {I = 0; I < DimOf(Files32); I++} File32Entry

#sub File64Entry
  Source: "Files/{#Files64[I]}"; DestDir: "{app}"; Flags: ignoreversion; check: Is64BitInstallMode
#endsub
#for {I = 0; I < DimOf(Files64); I++} File64Entry

#ifdef ReadMeFile
 Source: "{#ReadMeFile}"; DestDir: "{app}"; Flags: isreadme solidbreak
#endif

[Tasks]
Name: "installplugins"; Description: "Install Folder and Graphics Programs"; GroupDescription: "Install plug-ins into:";

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

#include "common/detect.iss"

procedure InstallPlugins();
var
  I: Integer;
  ok: Boolean;
  folderPath: String;
  isFile32Extracted: Boolean;
  isFile64Extracted: Boolean;
  isFileExtracted: Boolean;
begin
  for I := 0 to GetArrayLength(pluginFolders) - 1 do
  begin
    if WizardForm.TasksList.Checked[I + 1] then
    begin
      // This next line necessary with Paint Shop Pro X2, which doesn't
      // create its own default PlugIns folder automatically!
      If Not DirExists(pluginFolders[I].Folder) Then CreateDir(pluginFolders[I].Folder);
      folderPath := pluginFolders[I].Folder + '\{#ProductName} {#MajorVersion}'
      CreateDir(folderPath);
      ok := DirExists(folderPath);
      If ok Then
      Begin
        // 32-bit files
        If Not pluginFolders[I].IsSixtyFourBit then
        Begin
          If Not isFile32Extracted then
          Begin
            #sub File32Extract
             ExtractTemporaryFile('{#Files32[I]}');
            #endsub
            #for {I = 0; I < DimOf(Files32); I++} File32Extract
            isFile32Extracted := True;
          End;
          #sub File32Copy
           FileCopy(ExpandConstant('{tmp}\{#Files32[I]}'), folderPath + '\{#Files32[I]}', False);
          #endsub
          #for {I = 0; I < DimOf(Files32); I++} File32Copy
        End;

        // 64-bit files
        if (Is64BitInstallMode And pluginFolders[I].IsSixtyFourBit) then
        Begin
          If Not isFile64Extracted then
          Begin
            #sub File64Extract
              ExtractTemporaryFile('{#Files64[I]}');
            #endsub
            #for {I = 0; I < DimOf(Files64); I++} File64Extract
            isFile64Extracted := True;
          End;
          #sub File64Copy
           FileCopy(ExpandConstant('{tmp}\{#Files64[I]}'), folderPath + '\{#Files64[I]}', False);
          #endsub
          #for {I = 0; I < DimOf(Files64); I++} File64Copy
        End;

        // Common files
        #ifdef Files
          If Not isFileExtracted then
          Begin
            #sub FileExtract
              ExtractTemporaryFile('{#Files[I]}');
            #endsub
            #for {I = 0; I < DimOf(Files); I++} FileExtract
            isFileExtracted := True;
          End;
          #sub FileCopy
            FileCopy(ExpandConstant('{tmp}\{#Files[I]}'), folderPath + '\{#Files[I]}', False);
          #endsub
          #for {I = 0; I < DimOf(Files); I++} FileCopy
        #endif

        RegWriteStringValue(HKLM, 'Software\{#CompanyName}\{#ProductName} {#MajorVersion}', 'Install' + IntToStr(I), AddBackslash(pluginFolders[I].Folder))
      End
      Else MsgBox('Unable to install in ' + pluginFolders[I].ProductName + #13#13 + 'Unable to create folder: ' + folderPath, mbInformation, mb_Ok);
    end;
  end;
end;



procedure UninstallPlugins();
var
	TempString: String;
	I: Integer;
  FolderPath: String;
  FileName: String;
begin
  for I := 0 To 99 do
  begin
    if RegQueryStringValue(HKLM, 'Software\{#CompanyName}\{#ProductName} {#MajorVersion}', 'Install' + IntToStr(I), TempString) then
  	begin
      // Can either of these lines cause problems if TempString is blank?
      FolderPath := TempString + '{#ProductName} {#MajorVersion}\'
      //MsgBox(FolderPath, mbInformation, mb_Ok);

      // 32-bit files
      #sub File32Delete
        FileName := FolderPath + '\{#Files32[I]}';
        //If FileExists(FileName) Then MsgBox('File Exists: ' + FileName, mbInformation, mb_Ok);
        DeleteFile(FileName);
        //MsgBox(FileName, mbInformation, mb_Ok);
      #endsub
      #for {I = 0; I < DimOf(Files32); I++} File32Delete

      // 64-bit files
      #sub File64Delete
        FileName := FolderPath + '\{#Files64[I]}';
        //If FileExists(FileName) Then MsgBox('File Exists: ' + FileName, mbInformation, mb_Ok);
        DeleteFile(FileName);
        //MsgBox(FileName, mbInformation, mb_Ok);
      #endsub
      #for {I = 0; I < DimOf(Files64); I++} File64Delete

      // Common files
      #sub FileDelete
        FileName := FolderPath + '\{#Files[I]}';
        //If FileExists(FileName) Then MsgBox('File Exists: ' + FileName, mbInformation, mb_Ok);
        DeleteFile(FileName);
        //MsgBox(FileName, mbInformation, mb_Ok);
      #endsub
      #for {I = 0; I < DimOf(Files); I++} FileDelete

      // Delete folder, but only if empty, and do not delete recursively.
      DelTree(folderPath, True, False, False);

      // Delete the registry key
      RegDeleteValue(HKLM, 'Software\{#CompanyName}\{#ProductName} {#MajorVersion}', 'Install' + IntToStr(I));
    end
    else
      // Since the indexes are an unbroken sequence, a missing index
      // indicates the end of the sequence and we can stop.
      Break;
  end;
end;


procedure GenerateTaskList();
var
  I: Integer;
begin
  if externalProgramsAdded = False then
  begin
    if GetArrayLength(pluginFolders) = 0 then
    begin
      // This situation should be dealt with some other way. Perhaps a prompt for a directory
      WizardForm.TasksList.ItemCaption[1] := ExpandConstant('{app}');
      WizardForm.TasksList.Checked[1]     := false;
      WizardForm.TasksList.ItemEnabled[1] := false;
    end
    else
    begin
      // Now add all the graphics programs we found installed
      for I := 0 to GetArrayLength(pluginFolders) - 1 do
      begin
        if I = 0 then
        begin
          WizardForm.TasksList.ItemCaption[1] := pluginFolders[I].ProductName;
          WizardForm.TasksList.Checked[1]     := True;
        end
        else
          WizardForm.TasksList.AddCheckBox(pluginFolders[I].ProductName, '', 0, true, true, false, false, nil);
      end;
    end;
  end;
  externalProgramsAdded := True;
end;



/////////////////////////////////////////////////////////////////////////////
/// Innosetup Install Control Functions
/////////////////////////////////////////////////////////////////////////////

procedure InitializeWizard();
begin
  // This is where custom wizard pages are defined.
end;


/////////////////////////////////////////////
///  Code adapted from http://stackoverflow.com/questions/10490046/how-do-read-and-set-the-value-of-a-checkbox-in-an-innosetup-wizard-page
/////////////////////////////////////////////

procedure CurPageChanged(CurPageID: Integer);
begin

  // On the Installing page, check which tasks were checked.
  // We'll need to run code here to install the plugins
  // to their respective folders here (except that goes on wpInstalling)
  case CurPageID of
    wpReady:
      InstallPlugins();

    // If the user has clicked back to the ProgramGroup screen,
    // the task list has been deleted, so we need to set a flag
    // here so we know to recreate the Tasks list again.
    wpSelectProgramGroup:
      externalProgramsAdded := False;

    wpSelectDir:
      externalProgramsAdded := False;

    wpSelectTasks:
      GenerateTaskList();

    //else
  end;
end;


procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  case CurUninstallStep of
    usUninstall:
      UninstallPlugins();
  end;
end;

#include "common/locale.iss"                           

#expr SaveToFile(AddBackslash(SourcePath) + "Debug/preprocessed.iss")