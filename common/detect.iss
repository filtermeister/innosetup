[code]
/////////////////////////////////////////////////////////////////////
///  Photoshop Plugin Detection Functions and Procedures
/////////////////////////////////////////////////////////////////////

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

function GetGenericDirectory(var NewPluginFolder: TPluginFolder; Hive: Integer; RegKey: String; regparam: String; vendname: String; prodname: String; version: String; sixtyfourbit: Boolean): Boolean;
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
			NewPluginFolder.VendorName := vendname;
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
	VendName: String;
	ProdName: String;
	Version: String;
begin
	Hive     := HKCU;
	KeyName  := 'Software\Computerinsel\PhotoLine\Settings';
	Param    := 'PlugInPathNew1';
	VendName := 'Computerinsel';
	ProdName := 'PhotoLine';
	Version  := '10.5';
	Result   := GetGenericDirectory(pluginFolderResult, Hive, KeyName, Param, VendName, ProdName, Version, FALSE);
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
	VendName: String;
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

  VendName  := 'Adobe';

  // Photoshop versions 5 - 7
  Param := 'PluginPath';
  for i := 5 to 7 do
  begin
    KeyName   := 'Software\Adobe\Photoshop\' + IntToStr(i) + '.0\';
    Version   := IntToStr(i) + '.0';
    ProdName  := 'Photoshop ' + IntToStr(i);
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  end;

  // Photoshop 5.5
	KeyName  := 'Software\Adobe\Photoshop\5.5\';
	Param    := 'PluginPath';
	ProdName := 'Photoshop 5.5';
	Version  := '5.5';
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);

  // Photoshop CS
	KeyName  := 'Software\Adobe\Photoshop\8.0\';
	Param    := 'PluginPath';
	ProdName := 'Photoshop CS';
	Version  := '8.0';
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);

  // Photoshop CS2 and CS3
  for i := 9 to 10 do
  begin
    KeyName  := 'Software\Adobe\Photoshop\' + IntToStr(i) + '.0\';
    Param    := 'PluginPath';
    ProdName := 'Photoshop CS' + IntToStr(2 + (i - 9));
    Version  := IntToStr(i) + '.0';
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, VendName, ProdName, Version, FALSE) then begin
      for s := 0 to GetArrayLength(SubDirs) - 1 do
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
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    if Is64BitInstallMode then
    begin
      ProdName := ProdName + ' (64-bit)';
      if GetGenericDirectory(TempPluginFolder, HKLM64, KeyName, Param, VendName, ProdName, Version, TRUE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    end;
  end;

  // Photoshop CS5.1
  KeyName  := 'Software\Adobe\Photoshop\55.0\';
	Param    := 'PluginPath';
	ProdName := 'Photoshop CS5.1';
	Version  := '55.0';
	if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  if Is64BitInstallMode then
  begin
    ProdName := ProdName + ' (64-bit)';
    if GetGenericDirectory(TempPluginFolder, HKLM64, KeyName, Param, VendName, ProdName, Version, TRUE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
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
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    if Is64BitInstallMode then
    begin
      ProdName := ProdName + ' (64-bit)';
      if GetGenericDirectory(TempPluginFolder, HKLM64, KeyName, Param, VendName, ProdName, Version, TRUE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    end;
  end;
end;



/////////////////////////////////////////////////////////////////////
///  DetectPhotoshopElementsFolders
///
///  Detects plug-in folders for versions of Adobe Photoshop Elements
///  from 2 through 14, and adds untested support for future versions
///  up to version 20.  It tests for the presence of the relevant
///  registry string, and if found, it adds the folder value listed
///  there to our array of folders to install to.
///
///  Photoshop Elements plug-ins folder is usually stored at:
///
///  HKLM\Software\Adobe\Photoshop Elements\x.0\
///
///  where x is the version number (ie 2- 14).
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
  VendName: String;
  ProdName: String;
  Version: String;
begin
  Param := '';
  for i := 2 to 20  do     // Photoshop Elements versions 2 - 14 tested
  begin
    KeyName   := 'Software\Adobe\Photoshop Elements\' + IntToStr(i) + '.0\PluginPath';
    Version   := IntToStr(i) + '.0';
    VendName  := 'Adobe';
    ProdName  := 'Photoshop Elements ' + IntToStr(i);
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    if (i >= 13) and Is64BitInstallMode then  // 64-bit support starting version 13
    begin
      ProdName := ProdName + ' (64-bit)';
      if GetGenericDirectory(TempPluginFolder, HKLM64, KeyName, Param, VendName, ProdName, Version, TRUE) then begin
        AddToPluginFolders(TempPluginFolder, pluginFolders);
      end
    end;
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
	VendName: String;
	ProdName: String;
	Version: String;
begin

  VendName := 'JASC';

  Param := 'Directory1';
  for i := 5 to 7  do     // Paint Shop Pro versions 5 - 9
  begin
    KeyName   := 'SOFTWARE\Jasc\Paint Shop Pro ' + IntToStr(i) + '\ImageProcessingFilter\';
    Version   := IntToStr(i) + '.0';
    ProdName  := 'Paint Shop Pro ' + IntToStr(i);
    if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  end;

  // Paint Shop Pro 8 has slightly different methods
	Param     := 'Dir';
  KeyName   := 'Software\Jasc\Paint Shop Pro 8\FileLocations\PlugIns\0\';
  Version   := '8.0';
  ProdName  := 'Paint Shop Pro 8';
  if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);

  // Paint Shop Pro 9 is different too
	Param     := 'Dir';
  KeyName   := 'Software\Jasc\Paint Shop Pro 9\FileLocations\PlugIns\0\';
  Version   := '9.0';
  ProdName  := 'Paint Shop Pro 9';
  if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);

  // Jasc also made Paint Shop Pro Studio, just to mess with us....
	Param     := 'Dir';
  KeyName   := 'Software\Jasc\Paint Shop Pro Studio 1\FileLocations\PlugIns\0\';
  Version   := '1.0';
  ProdName  := 'Paint Shop Pro Studio';
  if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
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
	VendName: String;
	ProdName: String;
	Version: String;
begin
  VendName := 'Corel';
  Param := 'Dir';
  for i := 10 to 13  do     // PaintShopPro versions X - X3
  begin
    KeyName   := 'SOFTWARE\Corel\Paint Shop Pro\' + IntToStr(i) + '\FileLocations\PlugIns\0\';
    Version   := IntToStr(i) + '.0';
    ProdName  := 'Paint Shop Pro X';
    if i > 10 then ProdName  := ProdName + IntToStr(i - 10);
    if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  end;

  // Corel also made a version 12.5, just to mess with us...
  KeyName   := 'SOFTWARE\Corel\Paint Shop Pro\12.5\FileLocations\PlugIns\0\';
  Version   := '12.5';
  ProdName  := 'Paint Shop Pro X2 2010';
  if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
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
	VendName: String;
	ProdName: String;
	Version: String;
begin
  VendName := 'Corel';
  Param := 'Dir';
  for i := 14 to 19 do     // PaintShopPro versions X4 - X9
  begin
    KeyName   := 'SOFTWARE\Corel\PaintShop Pro\X' + IntToStr(i - 10) + '\FileLocations\PlugIns\0\';
    Version   := IntToStr(i) + '.0';
    ProdName  := 'Paint Shop Pro X' + IntToStr(i - 10);
    if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    if Is64BitInstallMode then
    begin
      ProdName := ProdName + ' (64-bit)';
      if GetGenericDirectory(TempPluginFolder, HKCU64, KeyName, Param, VendName, ProdName, Version, TRUE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
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
	VendName: String;
	ProdName: String;
	Version: String;
begin
  VendName := 'Serif';
  Param := 'PluginRootDir';
  for i := 6 to 19 do     // Photoplus versions 6 - 9, X - X9
  begin
    KeyName   := 'SOFTWARE\Serif\PhotoPlus\' + IntToStr(i) + '.0\Directories\';
    Version   := IntToStr(i) + '.0';
    if i < 10 then
      ProdName  := 'PhotoPlus ' + IntToStr(i)
    else if i = 10 then
      ProdName  := 'PhotoPlus X'
    else
      ProdName  := 'PhotoPlus X' + IntToStr(i - 10);
    if GetGenericDirectory(TempPluginFolder, HKLM32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    if Is64BitInstallMode then
    begin
      ProdName := ProdName + ' (64-bit)';
      if GetGenericDirectory(TempPluginFolder, HKLM64, KeyName, Param, VendName, ProdName, Version, TRUE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
    end;
  end;
end;



/////////////////////////////////////////////////////////////////////
///  DetectPhotoimpactFolders
///
///  Detects plugin folders for some versions of Ulead PhotoImpact
///  (tested on X3, but the preference file is shared with earlier
///  versions).  Tests for the presence of the Ulead INI data file
///  and reads the lines related to plug-in folders that have been 
///  configured.  Photoimpact does not have a folder configured out 
///  of the box - updates to this function might want to modify the 
///  INI values so they work without user configuration.
///
///  PhotoImpact data folder is usually stored at:
///
///     C:\Program Data\Ulead Systems\ulead32.ini
///
///  There are no 64-bit versions of Ulead PhotoImpact.
/////////////////////////////////////////////////////////////////////

procedure DetectPhotoimpactFolders(var pluginFolders: TArrayOfPluginFolders);
var
  NewPluginFolder: TPluginFolder;
  Filename: String;
  FolderPath: String;
begin

  NewPluginFolder.VendorName      := 'Ulead';
  NewPluginFolder.ProductName     := 'PhotoImpact';
  NewPluginFolder.Version         := '';      // Blank because it applies to all versions
  NewPluginFolder.IsSixtyFourBit  := FALSE;   // There are no 64 bit versions

  // Ulead Photoimpact stores its preferences in an INI file that is
  // shared across all versions of Photoimpact.  Changes to plugin
  // folders in one version will affect others.

  // User must have configured the first plugin folder for this to
  // work, Photoimpact does not come preconfigured with a folder
  // out of the box.

  Filename := ExpandConstant('{commonappdata}') + '\Ulead Systems\ulead32.ini';
  if FileExists(Filename) then
  begin
    if IniKeyExists('PLUG IN', 'PLUGINDIR1', Filename) then
      FolderPath := GetIniString('PLUG IN', 'PLUGINDIR1', '', Filename);
    if Length(FolderPath) > 0 then
    begin
       NewPluginFolder.Folder := AddBackslash(folderpath);
       AddToPluginFolders(NewPluginFolder, pluginFolders)
    end;
  end;

  // Do the same thing for ulead32.ini in the Windows Folder,
  // if we want compatibility with ancient Ulead Photoimpact versions.

end;



/////////////////////////////////////////////////////////////////////
///  DetectPhotobrushFolders
///
///  Detects plugin folders for versions of MediaChance Photo-Brush
///  from version 2 - 5.  Tests for the presence of the relevant
///  registry string, and if found, it adds the folder value listed
///  there to our array of folders to install to.  The user has the
///  option later whether to install there or not.
///
///  Photo-Brush plug-ins folder is usually stored at:
///
///     HKLM\SOFTWARE\MediaChance\Photo-Brush\x\Plugins\
///
///  where x is the version number.
/////////////////////////////////////////////////////////////////////

procedure DetectPhotobrushFolders(var pluginFolders: TArrayOfPluginFolders);
var
  i: Integer;
  TempPluginFolder: TPluginFolder;
  KeyName: String;
  Param: String;
  VendName: String;
  ProdName: String;
  Version: String;
begin
  VendName := 'MediaChance';
  Param := 'Path';
  for i := 2 to 10 do
  begin
    KeyName   := 'SOFTWARE\MediaChance\Photo-Brush ' + IntToStr(i) + '\Plugins\';
    Version   := IntToStr(i);
    ProdName  := 'PhotoBrush ' + IntToStr(i)
    if GetGenericDirectory(TempPluginFolder, HKCU32, KeyName, Param, VendName, ProdName, Version, FALSE) then AddToPluginFolders(TempPluginFolder, pluginFolders);
  end;
end;



/////////////////////////////////////////////////////////////////////
///  Detect PaintDotNet Folders
///
///  Detects plugin folders for versions of dotPDN Paint.NET.
///  Tests for the presence of the Paint.NET 'Effects' folder, 
///  and if found, it adds the folder to our array of folders to
///  install to. The user has the option later whether to install
///  there or not.
///
///  Paint.NET installation folder is usually stored at:
///
///     HKLM\SOFTWARE\Paint.NET\TARGETDIR
///
///  Paint.NET installs a version matching the processor architecture
///  of the operating system, there are not separate 32-bit and
///  64-bit versions.
/////////////////////////////////////////////////////////////////////

procedure DetectPaintDotNetFolders(var pluginFolders: TArrayOfPluginFolders);
var 
  TempPluginFolder: TPluginFolder;
	KeyName: String;
	Param: String;
  RegValue: String;
  EffectsDir: String;
begin
    RegValue := '';
    EffectsDir := '';
    KeyName := 'SOFTWARE\Paint.NET';
    Param := 'TARGETDIR';
    
    TempPluginFolder.Version := '';  // Applies to all versions.
    TempPluginFolder.VendorName := 'dotPDN';
    TempPluginFolder.ProductName := 'Paint.NET';
    // Paint.NET installs a version matching the processor architecture of the OS.
    TempPluginFolder.IsSixtyFourBit := Is64BitInstallMode;
    if Is64BitInstallMode then
    begin
      TempPluginFolder.ProductName := TempPluginFolder.ProductName + ' (64-bit)';
    end;
    
    if RegKeyExists(HKLM, KeyName) then
    begin
      RegQueryStringValue(HKLM, KeyName, Param, RegValue);
      if RegValue <> '' then
      begin
        EffectsDir := AddBackslash(RegValue) + 'Effects\';
        if DirExists(EffectsDir) then
        begin
          TempPluginFolder.Folder := EffectsDir;
          AddToPluginFolders(TempPluginFolder, pluginFolders);
        end;
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

  // Ulead Photoimpact versions
  DetectPhotoimpactFolders(pluginFolders);

  // MediaChance Photo-Brush versions
  DetectPhotobrushFolders(pluginFolders);

  // dotPDN Paint.NET versions
  DetectPaintDotNetFolders(pluginFolders);

	// Miscellaneous other PS Plugin compatible apps
	if DetectPhotolineFolder(TempPluginFolder) then AddToPluginFolders(TempPluginFolder, pluginFolders);

	// Also install into the default install folder in Program Files
	Result := ExpandConstant('{pf}');
end;