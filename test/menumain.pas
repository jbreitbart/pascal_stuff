{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                Autorin: Gabi Rosenbaum  02.09.1992               º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º      Menuprogramm zum einfachen Aufrufen von Programmen          º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program Menuprogramm_2_0;                        {Datei: Menumain.pas}
Uses
   Crt,Dos,                            {Bibliothek aus Borland Pascal}
   Objects, App, ColorSel, Dialogs,
   Drivers, Menus, Memory, Views,
   MsgBox,                                {Bibiothek aus Turbo-Vision}
   GadGets,                                {Demounit aus Turbo-Vision}          
   MenuDlg, MenuDat;                      {Units fr das Menuprogramm}

              {Globale Typen-, Variablen und Konstantenvereinbarungen}

TYPE
    PApp = ^TApp;
    TApp = Object(TApplication)
      Clock          : PClockView;
      MenuAuswahl    : PMenuAuswahl;      {Linkes Fenster Menuauswahl}
      ProgrammAuswahl: PProgrammAuswahl;{Rechtes Fenster Prog.auswahl}
      Ausstieg       : Word;                  {Errorlevel zum Beenden}
      Constructor Init;
      Procedure   Idle;Virtual;
      Procedure   InitStatusLine;Virtual;
      Procedure   InitMenuBar;Virtual;
      Function    FirstInit: Boolean;
      Procedure   GetEvent(Var Event: TEvent);Virtual;
      Procedure   HandleEvent(Var Event:TEvent);Virtual;
      Function    Getpalette: PPalette;Virtual;
      Destructor  Done;Virtual;
      Procedure   SchreibeBatchComplete(AMerker: Word);Virtual;
      Procedure   SchreibeBatchEnd;Virtual;
      Procedure   SpeicherProgrammausfuehrungen;Virtual;
      Procedure   LoadIniFile;Virtual;
      Procedure   SaveOptions(Colorpalette:Boolean);
    End;

Type
    PDeskTopStr = ^TDeskTopStr;
    TDeskTopStr = Object(TStaticText)
      Function GetPalette : PPalette;Virtual;
    end;

Var
  MyO      : PApp;                                      {Das Programm}
  BatchTime: LongInt;             {Zeit und Datem der Batcherstellung}


Function TDeskTopStr.GetPalette;
Const
  P : String[Length(CStatusLine)] = CStatusLine;
Begin
  GetPalette := @P;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Methoden von TApp                                                 ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Constructor TApp.Init;                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Initialisiert den DeskTop                                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Constructor TApp.Init;
Var
  P       : PDialog;                   {Zeiger auf ein TDialog-Object}
  Dir     : DirStr;                          {Directory des Exe-Files}
  Name    : NameStr;                {Name dieses Programms fr FSplit}
  Ext     : ExtStr;            {Extension dieses Programms fr FSplit}
  PrgStr  : String;             {Titelbergabe an das Programmfenster}
  TempChar: Char;                    {Parameterbergabe, letztes Menu}
  R       : TRect;                       {Ausmaáe eines View-Objectes}
Begin
  FSplit(ParamStr(0),Dir,Name,Ext);
  ColorFileName   := Dir+'MENU.COL';
  InitFileName    := Dir+'MENU.INI';
  AufrufDateiName := Dir+'MENU.ETG';
  BatchName       := Dir+'MENU.BAT';

  TApplication.Init;

  GetExtent(R);
  Inc(R.A.Y,2);
  Dec(R.B.Y,1);
  DeskTop^.ChangeBounds(R);

  R.Assign(0,0,80,1);
  Insert(New(PDeskTopStr,
         Init(R,^C'MENUPROGRAMM 2.0 (c) 1992 by Gabi Rosenbaum')));

  GetExtent(R);
  R.A.X := R.B.X - 9; R.B.Y := R.A.Y + 1;
  Clock := New(PClockView, Init(R));
  Insert(Clock);

                                     {Prfung der Erstinitialisierung}
  If  FirstInit then
  Begin
    Ausstieg := $FFFF;
    Done;
  end else

              {Prfung ob Menuprogramm ber MENU.BAT aufgerufen wurde}
  Begin
    If Pos('ú',Parameter) = 0 then
    Begin
       MessageBox('Programm ber MENU.BAT aufrufen !'+#13+
                  'Diese Datei wird automatisch erzeugt.',
                   NIL,mfOkButton + mferror);
       Ausstieg := $FFFF;
       Done;
    end;
  end;

  LoadIniFile;
                                {Initialisierung der Voreinstellungen}
  With VoreinData do begin
     Case ActVorEin.ScreenSaveZeit of
       2: Cluster0 := 0;
       5: Cluster0 := 1;
       10:Cluster0 := 2;
     end;
  end;

  EinGest     := ActVorEin.ScreenSaveZeit;

                                                   {Initialisierungen}
  If (ParamCount = 2) and (ParamStr(2) <> '/X') then
  Begin
    PrgStr      := System.Copy(ParamStr(2),2,1);
    TempChar    := PrgStr[1];
    ActMenuSel  := TempChar
  end else
  ActMenuSel  := 'A';
  Ausstieg    :=  0;

                       {Initialisierung von Menu- und Programmauswahl}
  P := New(PMenuAuswahl,Init);
  P^.Options := P^.Options and not ofselectable;
  If ValidView(P) <> NIL then
  DeskTop^.Insert(P);
  MenuAuswahl := PMenuAuswahl(P);

  P := New(PProgrammAuswahl,Init);
  P^.Options := P^.Options and not ofselectable;
  If ValidView(P) <> NIL then
  DeskTop^.Insert(P);
  ProgrammAuswahl := PProgrammAuswahl(P);

                              {Besetzen von Menu- und Programmauswahl}
  Message(MenuAuswahl,EvBroadCast,msMenuChanged,NIL);
  Message(Programmauswahl,evBroadCast,msTextChanged,NIL);

  If (ActMenu[Ord(ActMenuSel)-64] = '+++') or
     (ActMenu[Ord(ActMenuSel)-64] = '') then
  PrgStr := Concat('ú',ActMenuSel) else
  PrgStr := ActMenu[Ord(ActMenuSel)-64];
  Programmauswahl^.Titel^.SetItem(PrgStr);
end;                                                       {TApp.Init}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Destructor TApp.Done;                                             ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³L”scht den DeskTop, beendet das Programm                          ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

Destructor TApp.Done;
Var
  Merker : Word;
Begin
  Merker := Ausstieg;
  TApplication.Done;
  If (Merker = 0) OR (Merker = $FFFF) then
  SchreibeBatchEnd else
  SchreibeBatchComplete(Merker);
  Halt(Merker);
end;                                                       {TApp.Done}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Function TApp.FirstInit: Boolean;                                 ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Fhrt die Erstinitialisierung durch                               ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Function TApp.FirstInit: Boolean;
Var
  F           : Text;                 {Dateivariable aus der Unit DOS}
  P           : PDialog;               {Zeiger auf ein TDialog-Object}
  R           : TRect;                   {Ausmaáe eines View-Objektes}
  C           : Word;                               {Kontrollvariable}
  View        : PView;                   {Zeiger auf ein TView-Objekt}
Begin
  FirstInit := False;
                     {Datei ”ffnen und prfen, ob sie schon existiert}
  Assign(f,BatchName);
  {$I-}
  Reset(f);
  If IoResult <> 0 then
         {Wenn Menu.bat nicht existiert liegt eine Erstinitialisierung
                                            vor, dieses wird gemeldet}
  Begin
    FirstInit := True;
    LoadIniFile;
    R.Assign(0,0,60,12);
    P := New(PDialog,Init(R,'Erstinitialisierung'));
    P^.Options := P^.Options or ofCentered;
    R.Assign(3,2,57,5);
    P^.Insert(New(PStaticText,Init(R,
             'Das Menuprogramm kann nur einwandfrei arbeiten,'+#13+
             'wenn es ber die Batchdatei MENU.BAT aufgerufen,'+#13+
             'wird. Da das Programm das erstemal aufgerufen ')));
    R.Assign(3,5,59,7);
    P^.Insert(New(PStaticText,Init(R,
             'worden ist, wird jetzt eine Erstinitialisierung durch-'+#13+
             'gefhrt')));
    R.Assign(25,9,35,11);
    View := New(PButton,Init(R,'O~K~',cmOk,bfNormal));
    P^.Insert(PButton(View));
    If ValidView(P) <> NIL then
    DeskTop^.ExecView(P);
    Dispose(P,Done);
    SaveOptions(False);
    SpeicherProgrammausfuehrungen;
    C := MessageBox('Wenn das Menu beim Rechnerstart aufgerufen werden'+
               ' soll, k”nnen jetzt die Systemdateien ver„ndert werden.',
                NIL,mfInformation+mfYesNoCancel);

    If C = cmYes then
    Begin
      Assign(F,'C:\AUTOEXEC.BAT');
      {$I-}
      Append(f);
      {$I-}
      If IoResult <> 0 then
      MessageBox('Kein Zugriff auf die AUTOEXEC.BAT',NIL,
                 mferror+mfOkButton) else
      Begin
       Writeln(F,'REM Autostart des Menusystems');
       Writeln(F,BatchName);
       Close(F);
      end;
    end;

    MessageBox('Das Menu wird jetzt verlassen, Neustart nur noch '+
                   'durch Starten der Batchdatei MENU.BAT !!',NIL,
                     mfConfirmation+mfOkButton);

  end;
end;                                                  {TApp.FirstInit}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TApp.SchreibeBatchComplete;                             ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Schreibt bei Anwahl eines Programmpunktes eine Batchdatei         ³
 ³um das ausgew„hlte Programme zu starten                           ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TApp.SchreibeBatchComplete;
Var
  F            : Text;                    {Dateivariable aus Unit DOS}
  Gt           : File;                    {Dateivariable aus Unit DOS}
  I,J          : Byte;                                 {Laufvariablen}
  Param        : String;                       {Retten des Parameters}
  Dummy        : TFiles;                          {Tempor„re Variable}
  P            : PDialog;              {Zeiger auf ein TDialog-Object}
  R            : TRect;                  {Ausmaáe eines View-Objectes}
  View         : PView;                  {Zeiger auf ein TView-Object}
  DirMerker    : String;                              {Startdirectory}
  Exists       : Boolean;                       {Batchdatei existiert}
  D            : DirStr;               {Zum Ausfiltern des Directorys}
  N            : NameStr;             {Zum Ausfiltern des Dateinamens}
  E            : ExtStr;                 {Zum Ausfiltern des Dateiext}
Begin
  Exists := false;
  Dummy := ActFiles;
  Param := '';
           {Hier beginnt das Schreiben der Batchdatei, die w„hrend des
                                         Programmlaufes ben”tigt wird}
  Assign(F,BatchName);
  {$I-}
  Reset(F);
  {$I+}
                      {Zuerst wird die Zeit der ersten Batcherstellung
                                           ausgelesen und gespeichert}
  If IOResult = 0 then
  Begin
   GetFTime(F,BatchTime);
   exists := True;
  end;
    {Danach wird das Attribut auf 0 gesetzt und die Datei neu erzeugt}
  SetFAttr(F,0);
  Rewrite(F);
                                                    {Anfangsmeldungen}
  Writeln(F,'@Echo off');
  Writeln(F,'REM Batchdatei zum Menuprogramm Version 2.0');
  Writeln(F,':ANFANG');
  FSplit(BatchName,D,N,E);
  Writeln(f,D+'MENUMAIN.EXE /ú /'+ActMenuSel);

                                                          {Dateistart}
                          {Das Ausgangsdirectory wird gemerkt, um nach
                            Programmrckkehr wieder dahin zu wechseln}
  GetDir(0,DirMerker);
  I := Ord(ActMenuSel)-64;
  J := AMerker - ((I-1) * 9);
                                     {Der Parameter wird ausgefiltert}
  If (Pos(' ',Dummy[I][J]) > 0) then
  Param := Copy(Dummy[I][J], Pos(' ',Dummy[I][J])+1,
                Length(Dummy[I][J]));
  System.Delete(Dummy[I][J], Pos(' ',Dummy[I][J])+1,
                Length(Dummy[I][J])+1);
  FSplit(Dummy[I][J],D,N,E);
                           {Batchdateien werden durch CALL aufgerufen}
  If E = '.BAT' then
  Begin
   Writeln(f,'Call ',Dummy[I][J]);
   Writeln(f,'goto ANFANG');
   end else
   begin
     If D <> '' then
     begin
      Writeln(F,Copy(D,1,2));
      Writeln(F,'cd\');
      System.Delete(D,1,2);
      If Copy(D,1,1) = '\' then
      System.Delete(D,1,1);
      dec(D[0]);
      Writeln(F,'cd \'+D);
      Writeln(F,N+E+' '+Param);
      Param := '';
     end;
     Writeln(f,'Cd '+DirMerker);
     Writeln(f,'goto ANFANG');
   end;
  Close(F);
  Assign(gt,BatchName);
  Reset(gt);
                                        {Die Zeit wird wieder gesetzt}
  if Exists then
  SetFTime(gt,BatchTime);
  SetFAttr(gt,ReadOnly);
  Close(gt);
end;                                       {TApp.SchreibBatchComplete}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TApp.SchreibeBatchEnd;                                  ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Schreibt die Batchdatei zum regul„ren Ende des Programms          ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TApp.SchreibeBatchEnd;
Var
  F            : Text;                    {Dateivariable aus Unit Dos}
  BTExists     : Boolean;             {Batchdatei war schon vorhanden}
  Gf           : File;                     {Dateivariable zum L”schen}
  D            : DirStr;               {Zum Ausfiltern des Directorys}
  N            : NameStr;             {Zum Ausfiltern des Dateinamens}
  E            : ExtStr;                 {Zum Ausfiltern des Dateiext}
Begin
  BTExists := False;
                                     {Datei ”ffnen und Datum auslesen}
  Assign(f,BatchName);
  {$I-}
  Reset(F);
  {$I+}
  If IoResult = 0 then
  Begin
    GetFTime(f,BatchTime);
    BTExists := True;
    SetFAttr(f,0);
    erase(f);
    close(f);
  end;
  Assign(f,BatchName);
  FileMode := 2;
  Rewrite(f);
  Writeln(f,'@Echo off');
  Writeln(f,'REM Batchdatei zum Menuprogramm Version 2.0');
  Writeln(f,':ANFANG');
  FSplit(BatchName,D,N,E);
  Writeln(f,D+'MENUMAIN.EXE /ú /X');
  Close(F);
  Assign(gf,BatchName);
  reset(gf);
  if BTexists then
  setFTime(gf,BatchTime);
  SetFAttr(f,readOnly);
  close(gf);
end;                                           {TApp.SchreibeBatchEnd}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TApp.SpeicherProgrammausfuehrungen;                     ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Speichert die aktuellen Programmausfhrungen                      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TApp.SpeicherProgrammausfuehrungen;
Begin
  Assign(ActProgramFile,AufrufDateiName);
  Rewrite(ActProgramFile); 
  Write(ActProgramFile,ActFiles);
  Close(ActProgramFile);
end;                              {TApp.SpeicherProgrammausfuehrungen}

Procedure TApp.LoadIniFile;
{L„dt die aktuellen Menueinstellungen und die
 aktuellen Programmaufrufe in die Globalen Variablen
 ActMenu und ActProgramm
 Auáerdem werden die aktuellen Programmausfhrungen in
 die globale Variable ActFiles geladen}
Var
  F : IniFile;                                          {Dateivariable}
  R : IniDateiRec;                           {Record der Dateieintr„ge}
Begin
  Assign(F,InitFileName);
  {$I-}
   Reset(F);
  {$I+}
                    {Bei nicht vorhandenen Dateien Erstinitialisierung}
    If IoResult <> 0 then
    Begin
      InitActMenu;
      InitActProgrammAuswahl;
      InitActVoreinstellungen;
    end else
    Begin
     Read(F,R);
     With R do
     Begin
      ActMenu     := Auswahl;
      ActProgramm := Programm;
      ActVorein   := Voreinstellungen;
     end;
     Close(F);
    end;
  Assign(ActProgramFile,AufrufDateiName);
  {$I-}
  Reset(ActProgramFile);
  {$I+}
  If IoResult <> 0 then
  InitFiles else
  Begin
   Read(ActProgramFile,ActFiles);
   Close(ActProgramFile);
  end;
end;                                                     {LoadIniFile}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TApp.SaveOptions(ColorPalette: Boolean);                ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Speichert die Optionen                                            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TApp.SaveOptions(ColorPalette: Boolean);
Var
  F  : IniFile;                   {Initialisierungsdaten des Desktops}
  R  : IniDateiRec;                    {Record zum Lesen der Inidaten}
  S  : PStream;                      {Stream zum Lesen der Farbeinst.}
  Fi : File;                        {File zum L”schen der Streamdatei}
  Pal: String;                             {Paletteneintrag zum Lesen}
Begin
                         {Aktuelle Menu- und Programmpunkte speichern}
  Assign(F,InitFileName);
  {$I-}
  Rewrite(F);
  {$I+}
  If IOResult <> 0 then
  MessageBox('MENU.INI konnte nicht erstellt werden',NIL,
             mfOkButton+mfError) else
  With R do
  Begin
    Auswahl          :=  ActMenu;
    Programm         :=  ActProgramm;
    Voreinstellungen :=  ActVorein;
  end;
  Write(F,R);
  Close(F);

  If ColorPalette then
  Begin
                                {Aktuelle Farbeinstellungen speichern}
    S := New (PBufStream, Init (ColorFileName, stCreate, 1024));
    IF NOT LowMemory AND (S^.Status = stOk) THEN
    BEGIN
     Pal := Application^.GetPalette^;
     S^.WriteStr (@Pal);
     IF S^.Status <> stOk THEN
     BEGIN
       MessageBox ('MENU.COL konnte nicht erstellt werden.',
                    NIL, mfOkButton + mfError);
       Dispose (S, Done);
       {$I-}  Assign (Fi, ColorFileName);  Erase (F);  {$I+}
       Exit;
     END;
     S^.Truncate;
     Dispose (S, Done);
     MessageBox('Aktuelle Einstellungen wurden gespeichert',
                  NIL,mfOkButton+mfConfirmation);
    end;
  end;
end;                                                {TApp.SaveOptions}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TApp.Idle;                                              ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Updated die Uhr und setzt den Z„hler fr                          ³
 ³den Screensaver.                                                  ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TApp.Idle;
begin
  TApplication.Idle;
  If NOT (Dunkel(Anf,MemL[$0:$46c]) AND Zaehlt) then
  Clock^.Update;
  If not Zaehlt then
  Begin
    Anf := MemL[$0:$46c];
    Zaehlt := True;
  end;
end;                                                       {TApp.Idle}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TApp.GetEvent(Var Event: TEvent);                       ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Setzt den Z„hler zurck, wenn ein Event                           ³
 ³generiert wird                                                    ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TApp.GetEvent(Var Event: TEvent);
Begin
  TApplication.GetEvent(Event);
  If Event.What <> EvNothing then
  Begin
   anf := MemL[$0:$46c];
   Zaehlt := False;
  end;
End;{TApp.GetEvent}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Function TApp.GetPalette;                                         ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Die Applicationfarbpalette besteht  aus:                          ³
 ³ a. Der Farbpalette von TApplication      (63 Eintr„ge)           ³
 ³ b. Der Farbpalette von TMenuauswahl      (5  Eintr„ge)           ³
 ³ c. Der Farbpalette von TProgrammauswahl  (5  Eintr„ge)           ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Function TApp.GetPalette;

Const
  CNewColor = CColor      + NewCM  + NewCS;
  CNewBW    = CBlackWhite + NewBWM + NewBWS;
  CNewMono  = CMonochrome + NewMM  + NewMS;
  P : Array[apColor..apMonochrome] of String[Length(CNewColor)]
      = (CNewColor, CNewBW, CNewMono);
Begin
  GetPalette := @P[AppPalette];
End;                                                 {TApp.GetPalette}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Procedure TApp.InitStatusline;                                   ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Definiert eine Statuszeile                                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TApp.InitStatusline;
Var
  R : TRect;
Begin
  GetExtent(R);
  R.A.Y := R.B.Y -1;
  StatusLine := New(PStatusLine,Init(R,
                 NewStatusDef(0,$FFFF,
                  NewStatuskey('~F3~ Menueintr„ge',kbF3,cmMenuInit,
                  NewStatuskey('~F4~ Hotkeys',kbF4,cmHotKey,
                  NIL)),
                 NIL)
                ));
End;                                             {TApp.InitStatusLine}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TApp.InitMenuBar;                                       ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Definiert eine Menleiste                                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TApp.InitMenuBar;

Var
  R   : TRect;
Begin
  GetExtent(R);
  Inc(R.A.Y);
  R.B.Y := R.A.Y +1;
  MenuBar :=  New(PMenuBar,Init(R,NewMenu(
                 NewSubmenu('~'+#240+'~',hcNoContext,NewMenu(
                  NewItem('~š~ber...','',kbNoKey,cmAbout,hcNoContext,
                  NewItem('~H~otkeys...','F4',kbF4,cmHotKey,hcNoContext,
                  NIL))),

                 NewSubmenu('~E~intr„ge',hcNoContext,NewMenu(
                  NewItem('~M~enu initialisieren...','F3',kbF3,
                          cmMenuInit,hcNoContext,
                  NewItem('Menu ~L~”schen','F5',kbF5,
                          cmLoeschen,hcNoContext,
                  NewItem('P~r~ogrammeintr„ge einfgen...','Alt-Fx',
                          kbNoKey,cmProgBes,hcNoContext,
                  NewItem('~P~rogrammeintr„ge L”schen','F6',kbF6,
                          cmProgramm,hcNoContext,
                  NewLine(
                  NewItem('~D~os-Shell','',kbNoKey,cmDosShell,hcNoContext,
                  NewItem('~B~eenden','Alt-X',kbAltX,cmQuit,
                          hcNoContext,
                  NIL)))))))),

                 NewSubmenu('E~i~nstellungen',hcNoContext,NewMenu(
                   NewItem('~V~oreinstelungen...','F8',kbF8,cmVorein,
                           hcNoContext,
                   NewItem('~F~arbeinstellungen...','F7',kbF7,cmColor,
                           hcNoContext,
                   NewLine(
                   NewItem('Einstellungen ~s~peichern','F2',kbF2,
                           cmSaveOpt,hcNoContext,
                   NIL))))),
                 NIL)))
               )));
End;                                                {TApp.InitMenuBar}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TAPP.HandleEvent(Var Event:TEvent);                     ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Enth„lt Proceduren, die auf ein Ereignis reagieren,               ³
 ³bzw. wertet Ereignisse aus.                                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TAPP.HandleEvent(Var Event:TEvent);
Var
  R  : TRect;                            {Ausmaáe eines View-Objectes}
  C  : Word;                                        {Kontrollvariable}
  G  : PString;           {Eine Hilfsvariable um den InfoPtr zu lesen}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Procedure DOS;                                                   ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Aufruf der DOS-Shell                                             ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure DOS;
Begin
  DoneSysError;
  DoneEvents;
  DoneVideo;
  DoneMemory;
  SetMemTop(HeapPtr);
  PrintStr('Mit EXIT zurck zum Menuprogramm...');
  SwapVectors;
  Exec(GetEnv('COMSPEC'),'');
  SwapVectors;
  SetMemTop(HeapEnd);
  InitMemory;
  InitVideo;
  InitEvents;
  InitSysError;
  Redraw;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Function AboutBox: PDialog;                                       ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Information ber das Programm                                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

Function AboutBox: PDialog;
Var
  D : PDialog;
  R : TRect;
  B : PView;
Begin
  R.Assign(0,0,40,11);
  D := New(PDialog,Init(R,'šber...'));
  With D^ do Begin
    Options := Options or ofCentered;
    R.Assign(1,2,39,6);
    Insert(New(PStaticText,Init(R,
          ^C'MENUPROGRAMM Version 2.0'+#13+#13+
          ^C'(c) Copyright by Gabi Rosenbaum'+#13+
          ^C'und Data-Becker')));
    R.Assign(15,7,25,9);
    B := New(PButton,Init(R,'O~K~',cmOK,bfNormal));
    Insert(PButton(B));
  end;
  AboutBox := D;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure MenuEintragDlg;                                         ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Organisiert die Meneintragungen                                  ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure MenuEintragDlg;
Var
  PrgStr: String;
  I     : Word;
Begin
  For I := 1 to 9 do
  MenuEintrag[I] := Actmenu[I];
  ExecuteDialog(CreateMenuEintragDlg,@MenuEintrag);
  For I := 1 to 9 do
  ActMenu[I] := MenuEintrag[I];
  Message(MenuAuswahl,EvBroadCast,msMenuChanged,NIL);
  If (ActMenu[Ord(ActMenuSel)-64] = '+++') or
  (ActMenu[Ord(ActMenuSel)-64] = '') then
  PrgStr := Concat('ú',ActMenuSel) else
  PrgStr := ActMenu[Ord(ActMenuSel)-64];
  Programmauswahl^.Titel^.SetItem(PrgStr);
  SaveOptions(False);
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure MenuLoeschen;                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Organisiert das L”schen der Meneintr„ge                          ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure MenuLoeschen;
Var
  C      : Word;
  PrgStr : String;
Begin
  C := MessageBox('Alle Menueintr„ge (Linkes Fenster) '+
                  'werden gel”scht',
                 NIL, mfOkCancel+mfWarning);
  If C = cmOk then
  Begin
    InitActMenu;
    Message(MenuAuswahl,EvBroadCast,msMenuChanged,NIL);
    SaveOptions(False);
    If (ActMenu[Ord(ActMenuSel)-64] = '+++') or
       (ActMenu[Ord(ActMenuSel)-64] = '') then
    PrgStr := Concat('ú',ActMenuSel) else
    PrgStr := ActMenu[Ord(ActMenuSel)-64];
    Programmauswahl^.Titel^.SetItem(PrgStr);
  end;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure ProgrammLoeschen;                                       ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Organisiert das L”schen der Programmeintr„ge                      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure ProgrammLoeschen;
Var
  C: Word;
Begin
  C := MessageBox('Alle Programmpunkte (Rechtes Fenster) '+
                  'werden gel”scht',
                NIL,mfOkCancel+mfWarning);
  If C = cmOk then
  Begin
   InitActProgrammAuswahl;
   InitFiles;
   Message(ProgrammAuswahl,EvBroadCast,msTextChanged,NIL);
   SaveOptions(False);
   SpeicherProgrammausfuehrungen;
  end;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure ColorDlg;                                               ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Organisiert das Ver„ndern der Farben                              ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure ColorDlg;
Var
  D  : PDialog;
  Pal: String;
Begin
  D := CreateColorDlg;
  IF ValidView(D) <> NIL THEN
  BEGIN
   D^.SetData(Application^.GetPalette^);
   IF DeskTop^.ExecView(D) <> cmCancel THEN
   BEGIN
     Application^.GetPalette^ := PColorDialog(D)^.Pal;
     DoneMemory;
     Redraw;
   END;
   Dispose(D, Done);
  END
  Else MessageBox('Nicht genug Speicherplatz, '+
                  'um den Dialog zu er”ffnen',
                  NIL,mfError+mfOkButton);
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure MousePressed;                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Reagiert auf das Drcken der rechten Maustaste                    ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure MousePressed;
Var
  Err  : Integer;     {Fehlervariable beim Umwandeln String-->Integer}
  Num  : Word;         {Der Umgew. String --> Gedrckte Programmtaste}
  P2   : PScanDialog;                      {Zeiger auf ein Scandialog}
  Param: String;                         {evtl. bergebener Parameter}
  St   : String;             {Tempor„rer String zum Zwischenspeichern}
  D    : DirStr;                       {Zum Ausfiltern des Directorys}
  N    : NameStr;                     {Zum Ausfiltern des Dateinamens}
  E    : ExtStr;                        {Zum Ausfiltern des Dateiext.} 
  Str0,
  Str1 : String;         {Zwischenspeicherung von String0 und String1}
  FStr : PathStr;                {Zurckgegebener File vom ScanDialog}
Begin
  Param := '';
           {Im Event.InfoPtr wird der Programmpunkt bergeben, welcher
                                           angew„hlt worden ist (1-9)}
  G := PString(Event.InfoPtr);
  With ProgrammPunkt do
  Begin
                   {G wird in ein WORD umgewandelt, damit der richtige
                  Programmpunkt und Aufruffile vorbesetzt werden kann}
    Val(G^,Num,Err);
    String0 := ActProgramm[Ord(ActMenuSel)-64][Num];
    String1 := ActFiles[Ord(ActMenuSel)-64][Num];
    If String1 <> '' then
                   {Hier wird herausgefiltert, ob der Aufruffile einen
            Parameter vorbesetzt hat, dieser wird zuerst ausgefiltert.
              Danach wird der Dateiname ausgefiltert und der Parameter
                                                     wieder angeh„ngt}
    Begin
      If Pos(' ',String1) > 0 then
      Begin
       Param := System.Copy(String1,Pos(' ',String1)+1,
                Length(String1));
       System.Delete(String1,Pos(' ',String1),Length(String1));
       FSplit(String1,D,N,E);
       String1 := Concat(N,' ',Param);
       Param := '';
      end;
    end;
    Str0 := String0;
    Str1 := String1;
  end;
                 {Num hat String0 und String1 das richtige Format, der
            Programmpunktwechsel wird aufgerufen, die Voreinstellungen
              wurden gemerkt, damit bei CANCEL diese wieder eingesetzt
                                                        werden k”nnen}
  C := ExecuteDialog(New(PProgramChange,Init(ActMenuSel,
                  Num)),@ProgrammPunkt);
  If C = cmCancel then
  Begin
                   {Bei CANCEL werden Str0 und Str1 zurckgeschrieben}
   Programmpunkt.String0 := Str0;
   Programmpunkt.String1 := Str1;
  end;
  If C = cmYes then
  Begin
              {Bei Yes wird der Programmpunkt und der Aufruf gel”scht}
    ActProgramm[Ord(ActMenuSel)-64][Num] := '+++';
    ActFiles[Ord(ActMenuSel)-64][Num]    := '';
    Programmpunkt.String0 := '';
    Programmpunkt.String1 := '';
    Message(ProgrammAuswahl,EvBroadCast,msTextChanged,NIL);
    SpeicherProgrammausfuehrungen;
    SaveOptions(False);
  end;
  If (C <> cmCancel) and (C <> cmYes) then
                 {Ansonsten werden Programmpunkt und File neu besetzt}
  Begin
   ActProgramm[Ord(ActMenuSel)-64][Num] := ProgrammPunkt.String0;
   St := ProgrammPunkt.String1;
   If Pos(' ',St) > 0 then
   Begin
     Param := System.Copy(St,Pos(' ',St)+1,Length(St));
     System.Delete(St,Pos(' ',St),Length(ST));
   end;
   If Pos('.',St) > 0 then
   St := System.Copy(St,1,Pos('.',St)-1);
   P2 := New(PScanDialog,Init(St));
   If ValidView(P2) <> NIL then
   C := DeskTop^.ExecView(P2);
   If C <> cmCancel then
   Begin
    P2^.GetData(FStr);
    If (FStr <> '') then
    begin
     Message(Programmauswahl,evBroadCast,msTextChanged,NIL);
     ActFiles[Ord(ActMenuSel)-64][Num] := Concat(P2^.IMessage,' ',
              Param);
     SpeicherProgrammausfuehrungen;
     SaveOptions(False);
    end else
    MessageBox('Der Programmpunkt wurde nicht aufgenommen',NIL,
                mfInformation+mfOkButton);
   end;
   Dispose(P2,Done);
  end;
end;

Var
  Ps    : PString;                           {Zeiger auf einen String}
  Err   : Integer;                             {Errorvariable fr Val}
  Num   : Word;                  {Konvertiertes Word aus einem String}
  PrgStr: String;              {Titelbergabe fr das Programmfenster}
  PM1,PM2: String;                {Voreingestellte Pfade vor nderung}
  I,J    : Word;                                        {Laufvariable}
  Ev     : TEvent;                                       {Eventrecord}
Begin
  Ausstieg := 0;
  TApplication.HandleEvent(Event);
  If (Dunkel(Anf,MemL[$0:$46c]) AND Zaehlt) then
  Begin
    HideMouse;
    ClearScreen;
    Repeat
    GetEvent(EV);
    until EV.What <> evNothing;;
    anf := MemL[$0:$46c];
    ShowMouse;
    HideCursor;
    Redraw;
    Anf := MemL[$0:$46c];
    Zaehlt := False;
  end;
  If Event.What = evCommand then
  begin
    case Event.Command of
     cmDosShell    : Dos;                          {Ausstieg nach DOS}
     cmColor       : ColorDlg;              {Farbeinstellungen „ndern}
     cmMenuInit    : Begin
                       MenuEintragDlg;      {Menueintr„ge Vorbesetzen}
                     end;
     cmLoeschen    : MenuLoeschen;              {Menueintr„ge l”schen}
     cmProgramm    : ProgrammLoeschen;      {Programmeintr„ge l”schen}
     cmSaveOpt     : SaveOptions(True);      {Einstellungen speichern}
                                                         {Info zeigen}
     cmAbout       : ExecuteDialog(AboutBox,NIL);
                                                 {Anzeige der HotKeys}
     cmHotKey      : ExecuteDialog(CreateHotKeyDlg,NIL);
                                           {Programmpunkt vorbesetzen}
     cmProgBes     : Begin
                      Num := ExecuteDialog(New(PProgBesDlg,Init),NIL);
                      If Num <> cmCancel then
                      Begin
                       System.Str(Num-150,PM1);
                       PS := NewStr(PM1);
                       Message(@Self,evCommand,msMousePressed,PS);
                       DisposeStr(Ps);
                      end;
                     end;
                                             {Voreinstellungen „ndern}
     cmVorein      : Begin
                      C := ExecuteDialog(CreateVoreinDlg,@VoreinData);
                      If C = cmOK then
                      Begin
                        Case VoreinData.Cluster0 of
                          0: Eingest := 2;
                          1: Eingest := 5;
                          2: Eingest := 10;
                        end;
                        ActVorEin.ScreenSaveZeit := Eingest;
                     end;
                     SaveOptions(False);
                    end;
                                                {Programmpunkt „ndern}
     102..110      : Begin
                      ActMenuSel := Chr(Event.Command-37);
                      Message(Programmauswahl,evBroadCast,
                              msTextChanged,NIL);
                      If (ActMenu[Ord(ActMenuSel)-64] = '+++') or
                      (ActMenu[Ord(ActMenuSel)-64] = '') then
                      PrgStr := Concat('ú',ActMenuSel) else
                      PrgStr := ActMenu[Ord(ActMenuSel)-64];
                      Programmauswahl^.Titel^.SetItem(PrgStr);
                     end;
                                                 {Menupunkt ausfhren}
     111..119      : Begin
                      I := Ord(ActMenuSel)-64;
                      J := Event.Command-110;
                      If ActFiles[I][J] <> '' then
                      Begin
                       Ausstieg := ((Ord(ActMenuSel)-65)*9) +
                                   (Event.Command-110);
                       Done;
                      end;
                     end;
     msMousePressed: Begin
                       G := PString(Event.InfoPtr);
                       If Char(G^[1]) in ['1'..'9'] then
                       MousePressed else    
                       MenuEintragDlg;      
                    end;
    end;                                                        {Case}
  end;

  If Event.What = evKeyBoard then
  Begin
      If (UpCase(Event.Charcode) IN ['A'..'I']) then
       Begin
          ActMenuSel := UpCase(Event.CharCode);
          Message(Programmauswahl,evBroadCast,msTextChanged,NIL);
          If (ActMenu[Ord(ActMenuSel)-64] = '+++') or
             (ActMenu[Ord(ActMenuSel)-64] = '') then
          PrgStr := Concat('ú',ActMenuSel) else
          PrgStr := ActMenu[Ord(ActMenuSel)-64];
          Programmauswahl^.Titel^.SetItem(PrgStr);
       end;
      If Event.CharCode in ['1'..'9'] then
      Begin
       Val(Event.CharCode,Num,Err);
       Message(@Self,evCommand,110+Num,NIL);
      end;
       Case Event.KeyCode of
       kbAltF1:  Begin
                   PS := NewStr('1');
                   Message(@Self,evCommand,msMousePressed,PS);
                   DisposeStr(Ps);
                end;
       kbAltF2:  Begin
                   PS := NewStr('2');
                   Message(@Self,evCommand,msMousePressed,PS);
                   DisposeStr(Ps);
                end;
       kbAltF3:  Begin
                   PS := NewStr('3');
                   Message(@Self,evCommand,msMousePressed,PS);
                   DisposeStr(Ps);
                end;
       kbAltF4:  Begin
                   PS := NewStr('4');
                   Message(@Self,evCommand,msMousePressed,PS);
                   DisposeStr(Ps);
                end;
       kbAltF5:  Begin
                   PS := NewStr('5');
                   Message(@Self,evCommand,msMousePressed,PS);
                   DisposeStr(Ps);
                end;
       kbAltF6:  Begin
                   PS := NewStr('6');
                   Message(@Self,evCommand,msMousePressed,PS);
                   DisposeStr(Ps);
                end;
       kbAltF7:  Begin
                   PS := NewStr('7');
                   Message(@Self,evCommand,msMousePressed,PS);
                   DisposeStr(Ps);
                end;
       kbAltF8:  Begin
                   PS := NewStr('8');
                   Message(@Self,evCommand,msMousePressed,PS);
                   DisposeStr(Ps);
                end;
       kbAltF9:  Begin
                   PS := NewStr('9');
                   Message(@Self,evCommand,msMousePressed,PS);
                   DisposeStr(Ps);
                end;
       end;
    end;
    ClearEvent(Event);
end;                                                {TApp.HandleEvent}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Hauptprogramm                                                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Begin
  If ParamCount > 0 then
  Parameter   := ParamStr(1);
  New(MyO,Init);
  MyO^.SchreibeBatchEnd;
  MyO^.Run;
  Dispose(MyO,Done);
end.                                                        {Menumain}


