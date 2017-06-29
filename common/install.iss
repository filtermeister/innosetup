[Code]

procedure InstallPlugins();
var
  I: Integer;
  ok: Boolean;
  folderPath: String;
  isFile32Extracted: Boolean;
  isFile64Extracted: Boolean;
  isFileExtracted: Boolean;
  offset: Integer;
begin
  for I := 0 to GetArrayLength(pluginFolders) - 1 do
  begin
    // If the entry is our additional plugin folder, just skip it
    // otherwise we get an out of bounds error. The pluginFolders
    // is meant to be synchronized with the end of
    // WizardForm.TasksList but adding an additional plugin folder
    // affects this and causes an out-of-bounds exception when
    // trying to check if the last item in the TasksList is
    // checked or not. So here we skip it by detecting a 'internal'
    // plugin folder, knowing it will always be the last one.
    // This isn't the best way to handle this - but it works, and
    // will do for now until we can refactor how additional folders
    // are handled.
    if (pluginFolders[I].VendorName = 'Internal') then continue;

    // NB: If changing offset code here, also change the corresponding
    // offset code in the root level install.iss file as well.
    // Note on the TasksList offset:
    // WizardForm.TasksList starts at 1 (1-based array, not 0-based).
    // TasksList[1] refers to the always ticked Program Files folder,
    // so our offset needs to at least start at 2.
    
    #ifdef CustomDirectory
      // When enabled, we also need to +1 the offset again to skip
      // over the User Defined plugin folder, to start at item #3.
      offset := 3
    #else
      offset := 2
    #endif

    if WizardForm.TasksList.Checked[I + offset] then
    begin
      // This next line necessary with Paint Shop Pro X2, which doesn't
      // create its own default PlugIns folder automatically!
      If Not DirExists(pluginFolders[I].Folder) Then
        CreateDir(pluginFolders[I].Folder);
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