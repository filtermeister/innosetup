; Simple install script for a Windows Photoshop Plugin
; Written for the FilterMeister plugin community
; by Kohan Ikin / namesuppressed.com
; syneryder@namesuppressed.com

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

; Change these to the name of your 32-bit & 64-bit 8BF plugin files.
; If you don't have one of these lines, you can just delete it.
#define ThirtyTwoBit8BFFile  "example32.8bf"
#define SixtyFourBit8BFFile  "example64.8bf"

; If your project has more plugins, you'll need to modify the
; InstallPlugins and UninstallPlugins functions below to account
; for your additional plugin files & uninstalling them correctly.

; If you don't want a License or ReadMe, just delete these lines.
#define LicenseFileName "Files\license.txt"
#define ReadMeFile      "Files\readme.txt"

; If you don't want a background, delete this line.
#define UseInstallBackground "USEBACKGROUND"

; Support for additional files (data files etc) isn't included in
; this example.  You will need to figure this out for yourself, but
; you can start by adding these files to the [Files] section of the
; script below.

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
Compression=lzma

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
  LicenseFile = {#LicenseFilename}
#endif

; Keep all blank for 32-bit only install. Set to x64 for 64-bit (non-Itanium) installs.
; Remember that x86 is 32-bit, x64 is 64-bit!
ArchitecturesAllowed=x86 x64
ArchitecturesInstallIn64BitMode=x64




[Files]
#ifdef ThirtyTwoBit8BFFile
  Source: "Files\{#ThirtyTwoBit8BFFile}"; DestDir: "{app}"; Flags: ignoreversion
#endif
#ifdef SixtyFourBit8BFFile
  Source: "Files\{#SixtyFourBit8BFFile}"; DestDir: "{app}"; Flags: ignoreversion; Check: Is64BitInstallMode
#endif
#ifdef ReadMeFile
  Source: "{#ReadMeFile}"; DestDir: "{app}"; Flags: isreadme
#endif
; You might need to insert your own files here if you have additional
; support files to be installed.  You might need to work on this on
; your own or wait for the FilterMeister Mailing List folks to update
; this to add support for extra files.



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

[CustomMessages]
english.NameAndVersion=%1 version %2
english.AdditionalIcons=Additional icons:
english.CreateDesktopIcon=Create a &desktop icon
english.CreateQuickLaunchIcon=Create a &Quick Launch icon
english.ProgramOnTheWeb=%1 on the Web
english.UninstallProgram=Uninstall %1
english.LaunchProgram=Launch %1
english.AssocFileExtension=&Associate %1 with the %2 file extension
english.AssocingFileExtension=Associating %1 with the %2 file extension...
brazilianportuguese.NameAndVersion=%1 versão %2
brazilianportuguese.AdditionalIcons=Ícones adicionais:
brazilianportuguese.CreateDesktopIcon=Criar um ícone na &Área de Trabalho
brazilianportuguese.CreateQuickLaunchIcon=Criar um ícone na &Barra de Inicialização Rápida
brazilianportuguese.ProgramOnTheWeb=%1 na Internet
brazilianportuguese.UninstallProgram=Desinstalar %1
brazilianportuguese.LaunchProgram=Executar %1
brazilianportuguese.AssocFileExtension=&Associar %1 com a extensão de arquivo %2
brazilianportuguese.AssocingFileExtension=Associando %1 com a extensão de arquivo...
catalan.NameAndVersion=%1 versió %2
catalan.AdditionalIcons=Icones addicionals:
catalan.CreateDesktopIcon=Crea una icona a l'&Escriptori
catalan.CreateQuickLaunchIcon=Crea una icona a la &Barra de tasques
catalan.ProgramOnTheWeb=%1 a Internet
catalan.UninstallProgram=Desinstal·la %1
catalan.LaunchProgram=Obre %1
catalan.AssocFileExtension=&Associa %1 amb l'extensió de fitxer %2
catalan.AssocingFileExtension=Associant %1 amb l'extensió de fitxer %2...
czech.NameAndVersion=%1 verze %2
czech.AdditionalIcons=Další zástupci:
czech.CreateDesktopIcon=Vytvoøit zástupce na &ploše
czech.CreateQuickLaunchIcon=Vytvoøit zástupce na panelu &Snadné spuštìní
czech.ProgramOnTheWeb=Aplikace %1 na internetu
czech.UninstallProgram=Odinstalovat aplikaci %1
czech.LaunchProgram=Spustit aplikaci %1
czech.AssocFileExtension=Vytvoøit &asociaci mezi soubory typu %2 a aplikací %1
czech.AssocingFileExtension=Vytváøí se asociace mezi soubory typu %2 a aplikací %1...
danish.NameAndVersion=%1 version %2
danish.AdditionalIcons=Ekstra ikoner:
danish.CreateDesktopIcon=Lav ikon på &skrivebordet
danish.CreateQuickLaunchIcon=Lav &hurtigstart-ikon
danish.ProgramOnTheWeb=%1 på internettet
danish.UninstallProgram=Afinstaller (fjern) %1
danish.LaunchProgram=Kør %1
danish.AssocFileExtension=&Sammenkæd %1 med filtypen %2
danish.AssocingFileExtension=Sammenkæder %1 med filtypen %2...
dutch.NameAndVersion=%1 versie %2
dutch.AdditionalIcons=Extra snelkoppelingen:
dutch.CreateDesktopIcon=Maak een snelkoppeling op het &bureaublad
dutch.CreateQuickLaunchIcon=Maak een snelkoppeling op de &Snel starten werkbalk
dutch.ProgramOnTheWeb=%1 op het Web
dutch.UninstallProgram=Verwijder %1
dutch.LaunchProgram=&Start %1
dutch.AssocFileExtension=&Koppel %1 aan de %2 bestandsextensie
dutch.AssocingFileExtension=Bezig met koppelen van %1 aan de %2 bestandsextensie...
finnish.NameAndVersion=%1 versio %2
finnish.AdditionalIcons=Lisäkuvakkeet:
finnish.CreateDesktopIcon=Luo kuvake &työpöydälle
finnish.CreateQuickLaunchIcon=Luo kuvake &pikakäynnistyspalkkiin
finnish.ProgramOnTheWeb=%1 Internetissä
finnish.UninstallProgram=Poista %1
finnish.LaunchProgram=Käynnistä %1
finnish.AssocFileExtension=&Yhdistä %1 tiedostopäätteeseen %2
finnish.AssocingFileExtension=Yhdistetään %1 tiedostopäätteeseen %2 ...
french.NameAndVersion=%1 version %2
french.AdditionalIcons=Icônes supplémentaires :
french.CreateDesktopIcon=Créer une icône sur le &Bureau
french.CreateQuickLaunchIcon=Créer une icône dans la barre de &Lancement rapide
french.ProgramOnTheWeb=Page d'accueil de %1
french.UninstallProgram=Désinstaller %1
french.LaunchProgram=Exécuter %1
french.AssocFileExtension=&Associer %1 avec l'extension de fichier %2
french.AssocingFileExtension=Associe %1 avec l'extension de fichier %2...
german.NameAndVersion=%1 Version %2
german.AdditionalIcons=Zusätzliche Symbole:
german.CreateDesktopIcon=&Desktop-Symbol erstellen
german.CreateQuickLaunchIcon=Symbol in der Schnellstartleiste erstellen
german.ProgramOnTheWeb=%1 im Internet
german.UninstallProgram=%1 entfernen
german.LaunchProgram=%1 starten
german.AssocFileExtension=&Registriere %1 mit der %2-Dateierweiterung
german.AssocingFileExtension=%1 wird mit der %2-Dateierweiterung registriert...
hebrew.NameAndVersion=%1 âéøñä %2
hebrew.AdditionalIcons=ñéîìåğéí ğåñôéí:
hebrew.CreateDesktopIcon=öåø ÷éöåø ãøê òì &ùåìçï äòáåãä
hebrew.CreateQuickLaunchIcon=öåø ñéîìåï áùåøú ääøöä äîäéøä
hebrew.ProgramOnTheWeb=%1 áøùú
hebrew.UninstallProgram=äñø àú %1
hebrew.LaunchProgram=äôòì %1
hebrew.AssocFileExtension=&÷ùø àú %1 òí ñéåîú ä÷åáõ %2
hebrew.AssocingFileExtension=î÷ùø àú %1 òí ñéåîú ä÷åáõ %2
hungarian.NameAndVersion=%1 %2 verzió
hungarian.AdditionalIcons=További ikonok:
hungarian.CreateDesktopIcon=Ikon létrehozása az &Asztalon
hungarian.CreateQuickLaunchIcon=Ikon létrehozása a &Gyorsindítás eszköztáron
hungarian.ProgramOnTheWeb=%1 a weben
hungarian.UninstallProgram=%1 eltávolítása
hungarian.LaunchProgram=%1 elindítása
hungarian.AssocFileExtension=A(z) %1 &társítása a(z) %2 fájlkiterjesztéssel
hungarian.AssocingFileExtension=A(z) %1 társítása a(z) %2 fájlkiterjesztéssel...
italian.NameAndVersion=%1 versione %2
italian.AdditionalIcons=Icone aggiuntive:
italian.CreateDesktopIcon=Crea un'icona sul &desktop
italian.CreateQuickLaunchIcon=Crea un'icona nella barra &Avvio veloce
italian.ProgramOnTheWeb=%1 sul Web
italian.UninstallProgram=Disinstalla %1
italian.LaunchProgram=Avvia %1
italian.AssocFileExtension=&Associa l'estensione %2 a %1
italian.AssocingFileExtension=Associazione dell'estensione %2 a %1 in corso...
japanese.NameAndVersion=%1 ƒo[ƒWƒ‡ƒ“ %2
japanese.AdditionalIcons=ƒAƒCƒRƒ“‚ğ’Ç‰Á‚·‚é:
japanese.CreateDesktopIcon=ƒfƒXƒNƒgƒbƒvã‚ÉƒAƒCƒRƒ“‚ğì¬‚·‚é(&d)
japanese.CreateQuickLaunchIcon=&Quick Launch ƒAƒCƒRƒ“‚ğì¬‚·‚é
japanese.ProgramOnTheWeb=%1 on the Web
japanese.UninstallProgram=%1 ‚ğƒAƒ“ƒCƒ“ƒXƒg[ƒ‹‚·‚é
japanese.LaunchProgram=%1 ‚ğÀs‚·‚é
japanese.AssocFileExtension=%2 ƒtƒ@ƒCƒ‹Šg’£‚É %1‚ğŠÖ˜A•t‚¯‚Ü‚·B
japanese.AssocingFileExtension=%2 ‚É %1‚ğŠÖ˜A•t‚¯‚Ü‚·B
norwegian.NameAndVersion=%1 versjon %2
norwegian.AdditionalIcons=Ekstra-ikoner:
norwegian.CreateDesktopIcon=Lag ikon på &skrivebordet
norwegian.CreateQuickLaunchIcon=Lag et &Hurtigstarts-ikon
norwegian.ProgramOnTheWeb=%1 på nettet
norwegian.UninstallProgram=Avinstaller %1
norwegian.LaunchProgram=Kjør %1
norwegian.AssocFileExtension=&Koble %1 med filetternavnet %2
norwegian.AssocingFileExtension=Kobler %1 med filetternavnet %2...
polish.NameAndVersion=%1 wersja %2
polish.AdditionalIcons=Dodatkowe ikony:
polish.CreateDesktopIcon=Utwórz ikonê na &pulpicie
polish.CreateQuickLaunchIcon=Utwórz ikonê na pasku &szybkiego uruchamiania
polish.ProgramOnTheWeb=Strona WWW programu %1
polish.UninstallProgram=Deinstalacja programu %1
polish.LaunchProgram=Uruchom program %1
polish.AssocFileExtension=&Przypisz program %1 do rozszerzenia pliku %2
polish.AssocingFileExtension=Przypisywanie programu %1 do rozszerzenia pliku %2...
portuguese.NameAndVersion=%1 versão %2
portuguese.AdditionalIcons=Ícones adicionais:
portuguese.CreateDesktopIcon=Criar ícone no Ambiente de &Trabalho
portuguese.CreateQuickLaunchIcon=&Criar ícone na barra de Iniciação Rápida
portuguese.ProgramOnTheWeb=%1 na Web
portuguese.UninstallProgram=Desinstalar o %1
portuguese.LaunchProgram=Executar o %1
portuguese.AssocFileExtension=Associa&r o %1 aos ficheiros com a extensão %2
portuguese.AssocingFileExtension=A associar o %1 aos ficheiros com a extensão %2...
russian.NameAndVersion=%1, âåğñèÿ %2
russian.AdditionalIcons=Äîïîëíèòåëüíûå çíà÷êè:
russian.CreateDesktopIcon=Ñîçäàòü çíà÷îê íà &Ğàáî÷åì ñòîëå
russian.CreateQuickLaunchIcon=Ñîçäàòü çíà÷îê â &Ïàíåëè áûñòğîãî çàïóñêà
russian.ProgramOnTheWeb=Ñàéò %1 â Èíòåğíåòå
russian.UninstallProgram=Äåèíñòàëëèğîâàòü %1
russian.LaunchProgram=Çàïóñòèòü %1
russian.AssocFileExtension=Ñâ&ÿçàòü %1 ñ ôàéëàìè, èìåşùèìè ğàñøèğåíèå %2
russian.AssocingFileExtension=Ñâÿçûâàíèå %1 ñ ôàéëàìè %2...
slovenian.NameAndVersion=%1 razlièica %2
slovenian.AdditionalIcons=Dodatne ikone:
slovenian.CreateDesktopIcon=Ustvari ikono na &namizju
slovenian.CreateQuickLaunchIcon=Ustvari ikono za &hitri zagon
slovenian.ProgramOnTheWeb=%1 na spletu
slovenian.UninstallProgram=Odstrani %1
slovenian.LaunchProgram=Odpri %1
slovenian.AssocFileExtension=&Povei %1 s pripono %2
slovenian.AssocingFileExtension=Povezujem %1 s pripono %2...
spanish.NameAndVersion=%1 versión %2
spanish.AdditionalIcons=Iconos adicionales:
spanish.CreateDesktopIcon=Crear un icono en el &escritorio
spanish.CreateQuickLaunchIcon=Crear un icono de Inicio Rápido
spanish.ProgramOnTheWeb=%1 en la Web
spanish.UninstallProgram=Desinstalar %1
spanish.LaunchProgram=Ejecutar %1
spanish.AssocFileExtension=&Asociar %1 con la extensión de archivo %2
spanish.AssocingFileExtension=Asociando %1 con la extensión de archivo %2...
greek.NameAndVersion=%1 İêäïóç %2
greek.AdditionalIcons=Åğéğëİïí åéêïíßäéá:
greek.CreateDesktopIcon=Äçìéïõñãßá åíüò &åéêïíéäßïõ óôçí åğéöÜíåéá åñãáóßáò
greek.CreateQuickLaunchIcon=Äçìéïõñãßá åíüò åéêïíéäßïõ óôç &ÃñŞãïñç Åêêßíçóç
greek.ProgramOnTheWeb=Ôï %1 óôï Internet
greek.UninstallProgram=ÁğåãêáôÜóôáóç ôïõ %1
greek.LaunchProgram=Åêêßíçóç ôïõ %1
greek.AssocFileExtension=%Áíôéóôïß÷éóç ôïõ %1 ìå ôçí %2 åğİêôáóç áñ÷åßïõ
greek.AssocingFileExtension=Ãßíåôáé áíôéóôïß÷çóç ôïõ %1 ìå ôçí %2 åğİêôáóç áñ÷åßïõ...


[Languages]
; These files are stubs
; To achieve better results after recompilation, use the real language files
Name: "english"; MessagesFile: "compiler:Default.isl"; 
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"; 
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"; 
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"; 
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"; 
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"; 
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"; 
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"; 
Name: "french"; MessagesFile: "compiler:Languages\French.isl"; 
Name: "german"; MessagesFile: "compiler:Languages\German.isl"; 
Name: "greek"; MessagesFile: "compiler:Languages\Greek.isl"; 
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"; 
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"; 
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"; 
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"; 
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"; 
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"; 
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"; 
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"; 
Name: "serbiancyrillic"; MessagesFile: "compiler:Languages\SerbianCyrillic.isl";
Name: "serbianlatin"; MessagesFile: "compiler:Languages\SerbianLatin.isl";
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"; 
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"; 
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"; 





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



/////////////////////////////////////////////////////////////////////////////
///  Photshop Plugin Detection Functions and Procedures
/////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////
///  GetGenericDirectory
///
///  Returns a single PSPlugDir Photoshop plugin directory object,
///  located by a plugin path stored in a specific registry location.
///
///  @param regkey   Windows Registry key where we find plugin path
///  @param regparam Windows Registry param under that key
///  @param prodname Name of the product we're looking for (eg PSP)
///  @param sixtyfourbit Whether to access 64-bit registry or not
///  @param version  Product Version (double) (eg 6.0 for Photoshop)
/////////////////////////////////////////////////////////////////////

function GetGenericDirectory(var NewPluginFolder: TPluginFolder; Hive: Integer; RegKey: String; regparam: String; prodname: String; version: String; sixtyfourbit: Boolean): Boolean;
var
	RegValue: String;
begin
	Result := False;
	if RegKeyExists(Hive, RegKey) then
	begin
    //MsgBox('RegKey exists for ' + prodname, mbInformation, mb_Ok);
		RegQueryStringValue(Hive, RegKey, RegParam, RegValue);
		if RegValue <> '' then
		begin
			//MsgBox(prodname + ' detected' + sLineBreak + 'Folder: ' + RegValue, mbInformation, mb_Ok);
			NewPluginFolder.ProductName := prodname;
			NewPluginFolder.Version := version;
			NewPluginFolder.IsSixtyFourBit := sixtyfourbit;
			NewPluginFolder.Folder := AddBackslash(RegValue);
      // AddBackslash is super important!  Lots of programs don't
      // add a backslash to the end of their plug-in folder in the
      // registry, and that really messes us up.
			Result := True;
		end;
	end;
end;



/////////////////////////////////////////////////////////////////////
///  AddToPluginFolders
///
///  Takes a PluginFolder object (describing all the characteristics
///  of a Photoshop Plugin Folder we've discovered, ie which program
///  and whether it's 32 or 64 bit), and add it to an array of
///  PluginFolders that is provided by a reference (pointer).
/////////////////////////////////////////////////////////////////////

procedure AddToPluginFolders(var TempPluginFolder: TPluginFolder; var pluginFolders: TArrayOfPluginFolders);
var
	lastindex: Integer;
begin
	// Increase the size of the array before adding new item
	lastindex := GetArrayLength(pluginFolders);
	SetArrayLength(pluginFolders, lastindex + 1);
	pluginFolders[lastindex] := TempPluginFolder;
end;



/////////////////////////////////////////////////////////////////////
///  DetectPhotolineFolder
///
///  Detects plug-in folder for Computerinsel Photoline 10.5.  Tests
///  for the presence of the relevant registry string, and if found,
///  it adds the folder value to our array of folders to install to.
///
///  Photoline plug-ins folder is usually stored at:
///
///  HKCU\Software\Computerinsel\PhotoLine\Settings
///
///  This is a 'procedure', not a 'function', because in Pascal a
///  function that doesn't return a value is called a procedure.
/////////////////////////////////////////////////////////////////////

function DetectPhotolineFolder(var pluginFolderResult: TPluginFolder): Boolean;
var
	Hive: Integer;
	KeyName: String;
	Param: String;
	ProdName: String;
	Version: String;
begin
	Hive     := HKCU;
	KeyName  := 'Software\Computerinsel\PhotoLine\Settings';
	Param    := 'PlugInPathNew1';
	ProdName := 'Computerinsel PhotoLine';
	Version  := '10.5';
	Result   := GetGenericDirectory(pluginFolderResult, Hive, KeyName, Param, ProdName, Version, FALSE);
end;



/////////////////////////////////////////////////////////////////////
///  DetectPhotoshopFolders
///
///  Detects plug-in folders for versions of Adobe Photoshop
///  from 5 through CS9.  Tests for the presence of the relevant
///  registry string, and if found, it adds the folder value listed
///  there to our array of folders to install to.
///
///  Photoshop plug-ins folder is usually stored at:
///
///  HKLM\Software\Adobe\Photoshop\x.0\
///
///  where x is the version number (ie 5 - 15).
///
///  This is a 'procedure', not a 'function', because in Pascal a
///  function that doesn't return a value is called a procedure.
/////////////////////////////////////////////////////////////////////

procedure DetectPhotoshopFolders(var pluginFolders: TArrayOfPluginFolders);
var
  i: Integer;
  s: Integer;
  TempPluginFolder: TPluginFolder;
	KeyName: String;
	Param: String;
	ProdName: String;
	Version: String;
  Subdirs: array of String;
begin
  SetArrayLength(Subdirs, 9);
  Subdirs[0] := 'Zusatzmodule';
  Subdirs[1] := 'Modules Externes';
  Subdirs[2] := 'Insteekmodules';
  Subdirs[3] := 'Plugins';
  Subdirs[4] := 'Plug-in';
  Subdirs[5] := 'Plug-ins';
  Subdirs[6] := 'Plug-in-program';
  Subdirs[7] := 'Plugin-moduler';
  Subdirs[8] := 'Ekstramoduler';

  // Photoshop versions 5 - 7
  Param := 'PluginPath';
  for i := 5 to 7 do
  begin
    KeyName   := 'Software\Adobe\Photoshop\' + IntToStr(i) + '.0\';
    Version   := IntToStr(i) + '.0';
    ProdName  := 'Photoshop ' + IntToStr(i)
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  end;

  // Photoshop 5.5
	KeyName  := 'Software\Adobe\Photoshop\5.5\';
	Param    := 'PluginPath';
	ProdName := 'Photoshop 5.5';
	Version  := '5.5';
  if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);

  // Photoshop CS
	KeyName  := 'Software\Adobe\Photoshop\8.0\';
	Param    := 'PluginPath';
	ProdName := 'Photoshop CS';
	Version  := '8.0';
  if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);

  // Photoshop CS2 and CS3
  for i := 9 to 10 do
  begin
    KeyName  := 'Software\Adobe\Photoshop\' + IntToStr(i) + '.0\';
    Param    := 'PluginPath';
    ProdName := 'Photoshop CS' + IntToStr(2 + (i - 9));
    Version  := IntToStr(i) + '.0';
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, ProdName, Version, FALSE) then begin
      for s := 0 to length(SubDirs) - 1 do
      begin;
        if DirExists(TempPluginFolder.Folder + Subdirs[s] + '\') then TempPluginFolder.Folder := TempPluginFolder.Folder + Subdirs[s] + '\'
      end;
      AddToPluginFolders(TempPluginFolder, pluginFolders);
    end;
  end;

  // Photoshop CS4 and CS5 (64-bit support for Windows from CS4)
  for i := 11 to 12 do
  begin
    KeyName  := 'Software\Adobe\Photoshop\' + IntToStr(i) + '.0\';
    Param    := 'PluginPath';
    ProdName := 'Photoshop CS' + IntToStr(4 + (i - 11));
    Version  := IntToStr(i) + '.0';
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    if Is64BitInstallMode then
    begin
      ProdName := ProdName + ' (64-bit)';
      if GetGenericDirectory(TempPluginFolder, HKLM64, KeyName, Param, ProdName, Version, TRUE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    end;
  end;

  // Photoshop CS5.1
  KeyName  := 'Software\Adobe\Photoshop\55.0\';
	Param    := 'PluginPath';
	ProdName := 'Photoshop CS5.1';
	Version  := '55.0';
  if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  if Is64BitInstallMode then
  begin
    ProdName := ProdName + ' (64-bit)';
    if GetGenericDirectory(TempPluginFolder, HKLM64, KeyName, Param, ProdName, Version, TRUE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  end;

  // Photoshop CS6 - CC2015 - CC2019 (hopefully)
  for i := 6 to 13 do
  begin
    KeyName  := 'Software\Adobe\Photoshop\' + IntToStr(i) + '0.0\';
    Param    := 'PluginPath';
    if i = 6 then ProdName := 'Photoshop CS6'
    else if i = 7 then ProdName := 'Photoshop CC'     
    else ProdName := 'Photoshop CC ' + IntToStr(2014 + (i - 8));
    Version  := IntToStr(i) + '0.0';
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    if Is64BitInstallMode then
    begin
      ProdName := ProdName + ' (64-bit)';
      if GetGenericDirectory(TempPluginFolder, HKLM64, KeyName, Param, ProdName, Version, TRUE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    end;
  end;
end;



/////////////////////////////////////////////////////////////////////
///  DetectPhotoshopElementsFolders
///
///  Detects plug-in folders for versions of Adobe Photoshop Elements
///  from 5 through 9.  Tests for the presence of the relevant
///  registry string, and if found, it adds the folder value listed
///  there to our array of folders to install to.
///
///  Photoshop Elements plug-ins folder is usually stored at:
///
///  HKLM\Software\Adobe\Photoshop Elements\x.0\
///
///  where x is the version number (ie 5 - 7).
///
///  This is a 'procedure', not a 'function', because in Pascal a
///  function that doesn't return a value is called a procedure.
/////////////////////////////////////////////////////////////////////

procedure DetectPhotoshopElementsFolders(var pluginFolders: TArrayOfPluginFolders);
var
  i: Integer;
  TempPluginFolder: TPluginFolder;
	KeyName: String;
	Param: String;
	ProdName: String;
	Version: String;
begin
  Param := 'PluginPath';
  for i := 3 to 9  do     // Photoshop Elements versions 3 - 9
  begin
    KeyName   := 'Software\Adobe\Photoshop Elements\' + IntToStr(i) + '.0\';
    Version   := IntToStr(i) + '.0';
    ProdName  := 'Photoshop Elements ' + IntToStr(i);
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  end;
end;



/////////////////////////////////////////////////////////////////////
///  DetectJascPaintShopProFolders
///
///  Detects plug-in folders for versions of Jasc Paint Shop Pro
///  from 5 through 9.  Tests for the presence of the relevant
///  registry string, and if found, it adds the folder value listed
///  there to our array of folders to install to.
///
///  Paint Shop Pro plug-ins folder is usually stored at:
///
///  HKCU\SOFTWARE\Jasc\Paint Shop Pro x\ImageProcessingFilter\
///
///  where x is the version number (ie 5 - 7).
///
///  This is a 'procedure', not a 'function', because in Pascal a
///  function that doesn't return a value is called a procedure.
/////////////////////////////////////////////////////////////////////

procedure DetectJascPaintShopProFolders(var pluginFolders: TArrayOfPluginFolders);
var
  i: Integer;
  TempPluginFolder: TPluginFolder;
	KeyName: String;
	Param: String;
	ProdName: String;
	Version: String;
begin
  Param := 'Directory1';
  for i := 5 to 7  do     // Paint Shop Pro versions 5 - 9
  begin
    KeyName   := 'SOFTWARE\Jasc\Paint Shop Pro ' + IntToStr(i) + '\ImageProcessingFilter\';
    Version   := IntToStr(i) + '.0';
    ProdName  := 'Paint Shop Pro ' + IntToStr(i);
    if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  end;

  // Paint Shop Pro 8 has slightly different methods
	Param     := 'Dir';
  KeyName   := 'Software\Jasc\Paint Shop Pro 8\FileLocations\PlugIns\0\';
  Version   := '8.0';
  ProdName  := 'Paint Shop Pro 8';
  if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);

  // Paint Shop Pro 9 is different too
	Param     := 'Dir';
  KeyName   := 'Software\Jasc\Paint Shop Pro 9\FileLocations\PlugIns\0\';
  Version   := '9.0';
  ProdName  := 'Paint Shop Pro 9';
  if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);

  // Jasc also made Paint Shop Pro Studio, just to mess with us....
	Param     := 'Dir';
  KeyName   := 'Software\Jasc\Paint Shop Pro Studio 1\FileLocations\PlugIns\0\';
  Version   := '1.0';
  ProdName  := 'Paint Shop Pro Studio';
  if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
end;



/////////////////////////////////////////////////////////////////////
///  DetectPaintShopProEarlyXFolders
///
///  Detects plug-in folders for versions of Corel PaintShop Pro
///  from X through X3.  Tests for the presence of the relevant
///  registry string, and if found, it adds the folder value listed
///  there to our array of folders to install to.
///
///  Paint Shop Pro plug-ins folder is usually stored at:
///
///  HKCU\SOFTWARE\Corel\Paint Shop Pro\xx\FileLocations\PlugIns\0\
///
///  where xx is the version number (ie 10 - 13).
///
///  This is a 'procedure', not a 'function', because in Pascal a
///  function that doesn't return a value is called a procedure.
/////////////////////////////////////////////////////////////////////

procedure DetectPaintShopProEarlyXFolders(var pluginFolders: TArrayOfPluginFolders);
var
  i: Integer;
  TempPluginFolder: TPluginFolder;
	KeyName: String;
	Param: String;
	ProdName: String;
	Version: String;
begin
  Param := 'Dir';
  for i := 10 to 13  do     // PaintShopPro versions X - X3
  begin
    KeyName   := 'SOFTWARE\Corel\Paint Shop Pro\' + IntToStr(i) + '\FileLocations\PlugIns\0\';
    Version   := IntToStr(i) + '.0';
    ProdName  := 'Paint Shop Pro X';
    if i > 10 then ProdName  := ProdName + IntToStr(i - 10);
    if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  end;

  // Corel also made a version 12.5, just to mess with us...
  KeyName   := 'SOFTWARE\Corel\Paint Shop Pro\12.5\FileLocations\PlugIns\0\';
  Version   := '12.5';
  ProdName  := 'Paint Shop Pro X2 2010';
  if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
end;



/////////////////////////////////////////////////////////////////////
///  DetectPaintShopProModernFolders
///
///  Detects plug-in folders for versions of Corel PaintShop Pro
///  from X4 through X9.  Tests for the presence of the relevant
///  registry string, and if found, it adds the folder value listed
///  there to our array of folders to install to.
///
///  Paint Shop Pro plug-ins folder is usually stored at:
///
///  HKCU\SOFTWARE\Corel\PaintShop Pro\Xx\FileLocations\PlugIns\0\
///
///  where x is the version number.  For 64-bit versions, it will
///  be in the 64-bit registry (ie HKLM64 in InnoSetup syntax).
///
///  This is a 'procedure', not a 'function', because in Pascal a
///  function that doesn't return a value is called a procedure.
/////////////////////////////////////////////////////////////////////

procedure DetectPaintShopProModernFolders(var pluginFolders: TArrayOfPluginFolders);
var
  i: Integer;
  TempPluginFolder: TPluginFolder;
	KeyName: String;
	Param: String;
	ProdName: String;
	Version: String;
begin
  Param := 'Dir';
  for i := 14 to 19 do     // PaintShopPro versions X4 - X9
  begin
    KeyName   := 'SOFTWARE\Corel\PaintShop Pro\X' + IntToStr(i - 10) + '\FileLocations\PlugIns\0\';
    Version   := IntToStr(i) + '.0';
    ProdName  := 'Paint Shop Pro X' + IntToStr(i - 10);
    if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    if Is64BitInstallMode then
    begin
      ProdName := ProdName + ' (64-bit)';
      if GetGenericDirectory(TempPluginFolder, HKCU64, KeyName, Param, ProdName, Version, TRUE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    end;
  end;
end;



/////////////////////////////////////////////////////////////////////
///  DetectPhotoplusFolders
///
///  Detects plugin folders for versions of Serif Photoplus from
///  version 6 through X9.  Tests for the presence of the relevant
///  registry string, and if found, it adds the folder value listed
///  there to our array of folders to install to.  The user has the
///  option later whether to install there or not.
///
///  Photoplus plug-ins folder is usually stored at:
///
///     HKLM\SOFTWARE\Serif\PhotoPlus\x.0\Directories\
///
///  where x is the version number.  For 64-bit versions, it will
///  be in the 64-bit registry (ie HKLM64 in InnoSetup syntax).
///
///  This is a 'procedure', not a 'function', because in Pascal a
///  function that doesn't return a value is called a procedure.
/////////////////////////////////////////////////////////////////////

procedure DetectPhotoplusFolders(var pluginFolders: TArrayOfPluginFolders);
var
  i: Integer;
  TempPluginFolder: TPluginFolder;
	KeyName: String;
	Param: String;
	ProdName: String;
	Version: String;
begin
  Param := 'PluginRootDir';
  for i := 6 to 19 do     // Photoplus versions 6 - 9, X - X9
  begin
    KeyName   := 'SOFTWARE\Serif\PhotoPlus\' + IntToStr(i) + '.0\Directories\';
    Version   := IntToStr(i) + '.0';
    if i < 10 then
      ProdName  := 'Serif PhotoPlus ' + IntToStr(i)
    else if i = 10 then
      ProdName  := 'Serif PhotoPlus X'
    else
      ProdName  := 'Serif PhotoPlus X' + IntToStr(i - 10);
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    if Is64BitInstallMode then
    begin
      ProdName := ProdName + ' (64-bit)';
      if GetGenericDirectory(TempPluginFolder, HKLM64, KeyName, Param, ProdName, Version, TRUE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    end;
  end;
end;



/////////////////////////////////////////////////////////////////////
///  GetPluginFolders
///
///  Detects all the Photoshop plugin folders on the computer and
///  adds them to a global array of folders where we can install
///  plugins later.  This is the main detection routine but calls
///  out to many procedures that do the real detection work.
///
///  The returned value is the 'main' folder where install should
///  occur, ie the folder in Program Files that the user has selected
///  for you to install your main data/resources to.  You'll need
///  to write your own code for installing the plugins to the
///  folders that this code has found.
///
///  @returns String with path to the main folder to install to
/////////////////////////////////////////////////////////////////////

function GetPluginFolders(Param: String): String;
var
	I: Integer;
	TempPluginFolder: TPluginFolder;
begin
	I := 0;
	SetArrayLength(pluginFolders, 0);

	// Photoshop versions
	DetectPhotoshopFolders(pluginFolders);

	// Photoshop Elements versions
	DetectPhotoshopElementsFolders(pluginFolders);

	// Corel Paint Shop Pro versions
	DetectJascPaintShopProFolders(pluginFolders);
	DetectPaintShopProEarlyXFolders(pluginFolders);
	DetectPaintShopProModernFolders(pluginFolders);

	// Serif PhotoPlus versions
	DetectPhotoplusFolders(pluginFolders);

	// Miscellaneous other PS Plugin compatible apps
	if DetectPhotolineFolder(TempPluginFolder) then AddToPluginFolders(TempPluginFolder, pluginFolders);

	// Also install into the default install folder in Program Files
	Result := ExpandConstant('{pf}');
end;



procedure InstallPlugins();
var
  I: Integer;
  ok: Boolean;
  folderPath: String;
begin
  // How do we decide if we should only install the 32-bit
  // version, 64-bit version, or both?
  #ifdef ThirtyTwoBit8BFFile
    ExtractTemporaryFile('{#ThirtyTwoBit8BFFile}')
  #endif
  #ifdef SixtyFourBit8BFFile
    ExtractTemporaryFile('{#SixtyFourBit8BFFile}')
  #endif
  for I := 0 to GetArrayLength(pluginFolders) - 1 do
  begin
    if WizardForm.TasksList.Checked[I + 2] then
    begin
      // This next line necessary with Paint Shop Pro X2, which doesn't
      // create its own default PlugIns folder automatically!
      If Not DirExists(pluginFolders[I].Folder) Then CreateDir(pluginFolders[I].Folder);
      folderPath := pluginFolders[I].Folder + '\{#ProductName} {#MajorVersion}'
      CreateDir(folderPath);
      ok := DirExists(folderPath);
      If ok Then
      Begin
        #ifdef ThirtyTwoBit8BFFile
        If Not pluginFolders[I].IsSixtyFourBit then
          FileCopy(ExpandConstant('{tmp}\{#ThirtyTwoBit8BFFile}'), folderPath + '\{#ThirtyTwoBit8BFFile}', False);
        #endif
        #ifdef SixtyFourBit8BFFile
        if (Is64BitInstallMode And pluginFolders[I].IsSixtyFourBit) then
          FileCopy(ExpandConstant('{tmp}\{#SixtyFourBit8BFFile}'), folderPath + '\{#SixtyFourBit8BFFile}', False);
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

  // We can do better than a magic number hard-coded for-loop here!
  // We should be able to inspect all the sub-keys beginning with
  // Install and work from those instead of this weird limit on 30
  // graphics programs.

  for I := 0 To 29 do
  begin
    if RegQueryStringValue(HKLM, 'Software\{#CompanyName}\{#ProductName} {#MajorVersion}', 'Install' + IntToStr(I), TempString) then
  	begin
      // Can either of these lines cause problems if TempString is blank?
      FolderPath := TempString + '{#ProductName} {#MajorVersion}\'
      //MsgBox(FolderPath, mbInformation, mb_Ok);
      #ifdef ThirtyTwoBit8BFFile
        FileName := FolderPath + '{#ThirtyTwoBit8BFFile}';
        //If FileExists(FileName) Then MsgBox('File Exists: ' + FileName, mbInformation, mb_Ok);
        DeleteFile(FileName);
        //MsgBox(FileName, mbInformation, mb_Ok);
      #endif
      #ifdef SixtyFourBit8BFFile
        FileName := FolderPath + '{#SixtyFourBit8BFFile}';
        //If FileExists(FileName) Then MsgBox('File Exists: ' + FileName, mbInformation, mb_Ok);
        DeleteFile(FileName);
        //MsgBox(FileName, mbInformation, mb_Ok);
      #endif
      // Delete folder, but only if empty, and do not delete recursively.
      DelTree(folderPath, True, False, False); 
  	end;
	RegDeleteValue(HKLM, 'Software\{#CompanyName}\{#ProductName} {#MajorVersion}', 'Install' + IntToStr(I));
  end;
end;


procedure GenerateTaskList();
var
  I: Integer;
begin
  if externalProgramsAdded = False then
  begin
    // We have to have one prefilled task, so we'll repurpose it as
    // a reminder of the install folder, and disable it so the
    // user can't edit it.
    WizardForm.TasksList.ItemCaption[1] := ExpandConstant('{app}');
    WizardForm.TasksList.Checked[1]     := True;
    WizardForm.TasksList.ItemEnabled[1] := False;

    // Now add all the graphics programs we found installed
    for I := 0 to GetArrayLength(pluginFolders) - 1 do
    begin
      WizardForm.TasksList.AddCheckBox(pluginFolders[I].ProductName, '', 0, true, true, false, false, nil);
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
var
  I: Integer;
begin

  // On the Installing page, check which tasks were checked.
  // We'll need to run code here to install the plugins
  // to their respective folders here (except that goes on wpInstalling)

  case CurPageID of
    wpReady:
      begin
        InstallPlugins();
      end;

    // If the user has clicked back to the ProgramGroup screen,
    // the task list has been deleted, so we need to set a flag
    // here so we know to recreate the Tasks list again.
    wpSelectProgramGroup:
      begin
      externalProgramsAdded := False
      end;
    wpSelectDir:
      begin
      externalProgramsAdded := False
      end;

    wpSelectTasks:
      begin
      GenerateTaskList();
      end;
  else
    begin
    end;
  end;
end;


procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  case CurUninstallStep of
    usUninstall:
      begin
        UninstallPlugins();
      end;
  end;
end;