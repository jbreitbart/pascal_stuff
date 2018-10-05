{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                     Turbo Vision-Rahmenprogramm                  º
 º                 Autor: Reiner Sch”lles, 05.11.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Rahmenprogramm fr Turbo Vision-Applikationen.                   º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
{                     Inhalt und Hinweise

   Das Programm _Quelle.pas soll Ihnen als Rahmen fr eigene Turbo
   Vision-Applikationen dienen. Es ist bereits mit einer Vielzahl
   von Funktionen ausgestattet. Fr einige von ihnen finden Sie
   die Anregungen in dem Demoprogramm von Borland (TVDemo.PAS).

 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Program _Quelle;
{$X+}                                              {Erweiterte Syntax}
{$M 16384,8192,655360}
uses {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄEinzubindende BibliothekenÄÄ}
  Dos,App,Objects,Menus,
  Drivers,Views,Dialogs,
  MsgBox,StdDlg,Memory,
  Helpfile,Gadgets,                           {Units aus Turbo Pascal}
  _Hilfe,                                   {Unit aus diesem Programm}
  _TVTools;                             {Eigene Unit fr Turbo Vision}

const {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄGlobale KonstantenÄÄ}
  _cmAbout      = 1001;                           {Copyright anzeigen}
  _cmComp       = 1002;                                {Compiler-Info}
  _cmListDir    = 1003;                               {Dateien listen}
  _cmDelFile    = 1004;                                {Datei l”schen}
  _cmChDir      = 1005;                           {Directory wechseln}
  _cmDosShell   = 1006;                                    {Dos-Shell}

  _EXEDatei = '_Quelle.Exe';                  {Name dieser .EXE-Datei}
  _HLPDatei = '_Hilfe.Hlp';                    {Datei mit Hilfetexten}

  _PrgName   = ^C'Testversion 1.0';                     {Programmname}
  _AutorName = ^C'Reiner Sch”lles';                  {Name des Autors}

  _ShowTitel: boolean = true;            {True  = Titelzeile anzeigen}
                                              {False = nicht anzeigen}

  _TitelZ = _PrgName;                                     {Titelzeile}

  _PrgInfo = #13 +                                     {Programm-Info}
             _PrgName + #13 +
             #13 +
             ^C'Copyright (C) 1992 by'#13 +
             #13 +
             _AutorName;

  _CompInfo = #13 +                                    {Compiler-Info}
              ^C'Programm erstellt mit'#13 +
              #13 +
              ^C'Turbo Pascal 7.0'#13 +
              #13 +
              ^C'Borland International, Inc.';

type {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄGlobale DatentypenÄÄ}
  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄTXApp ÄÄ}
  TXApp = object (TApplication)
    Uhrzeit: PClockView;
    Heap: PHeapView;
    constructor Init;
    procedure Idle; virtual;
    procedure InitStatusLine; virtual;
    procedure InitMenuBar; virtual;
    procedure OutOfMemory; virtual;
    procedure ListDirectory(SearchStr,Bez: string;
                            var FindName: string);
    procedure DeleteFile;
    procedure ChangeDirectory;
    procedure DosShell;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure GetEvent(var Event: TEvent); virtual;
    function GetPalette: PPalette; virtual;
  end;


var {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄGlobale VariablenÄÄ}
  MyApp: TXApp;                                    {Programm-Variable}

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄVerzeichnis der globalen RoutinenÄÄ}

{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º Implementierung der Methoden von TXApp                           º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.Init                                                       ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ šbernimmt die notwendigen Initialisierungen, z.B. Anzeige der    ³
 ³ Uhrzeit und des freien Arbeitsspeiches.                          ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
constructor TXApp.Init;
var
  R: TRect;                           {Rechteckiger Bildschirmbereich}
  Titel: _PXStaticText;                        {Zeiger auf Titelzeile}

begin
  TApplication.Init;                     {Init-Methode des Vorg„ngers}
  RegisterHelpFile;

  if _ShowTitel then
  begin
    GetExtent(R); {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄInitialisiert die TitelzeileÄÄ}
    R.B.Y:= R.A.Y + 1;
    Titel:= New(_PXStaticText,Init(R,_TitelZ));
    Insert(Titel);
  end;

  GetExtent(R); {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄInitialisiert Anzeige der UhrzeitÄÄ}
  if _ShowTitel
   then Inc(R.A.Y);                   {Wird wegen Titelzeile ben”tigt}
  R.A.X:= R.B.X - 9;
  R.B.Y:= R.A.Y + 1;
  Uhrzeit:= New(PClockView,Init(R));
  Insert(Uhrzeit);

  GetExtent(R); {ÄÄÄÄÄÄÄÄÄÄInitialisiert Anzeige d.freien SpeichersÄÄ}
  Dec(R.B.X);
  R.A.X:= R.B.X - 9;
  R.A.Y:= R.B.Y - 1;
  Heap := New(PHeapView,Init(R));
  Insert(Heap);

  _TVInfoBox(_PrgInfo);                       {Programm-Info anzeigen}
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.Idle                                                       ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Idle ist eine abstrakte Methode, die hier berschrieben wird. Sie³
 ³ wird immer dann aufgerufen, wenn keine Ereignisse zur Bearbeitung³
 ³ vorliegen.                                                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TXApp.Idle;
begin
  TApplication.Idle;                           {Aufruf des Vorg„ngers}
  Uhrzeit^.Update;                             {Uhrzeit aktualisieren}
  Heap^.Update;                        {Freien Speicher aktualisieren}
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.InitStatusLine                                             ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Initialisiert eine neue Statuszeile und berschreibt damit die   ³
 ³ von TProgram.InitStatusLine.                                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TXApp.InitStatusLine;
var
  R: TRect;                                 {Rechteck fr Statuszeile}

begin
  GetExtent(R);                  {Liefert H”he und Breite des Objekts}
  R.A.Y:= R.B.Y - 1;              {Gr”áe und Position der Statuszeile}
  StatusLine:= New(PStatusLine,Init(R,
    NewStatusDef(0,$FFFF,
      NewStatusKey('~F1~ Hilfe',kbF1,cmHelp,
      NewStatusKey('~Alt-F3~ Schlieáen',kbAltF3,cmClose,
      NewStatusKey('~F10~ Men',kbF10,cmMenu,
      NewStatusKey('~Alt-X~ Programm beenden',kbAltX,cmQuit,
      nil)))),
    nil)
  ));
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.InitMenuBar                                                ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Initialisiert eine neue Menleiste und berschreibt  damit die   ³
 ³ von TProgram.InitMenuBar.                                        ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TXApp.InitMenuBar;
var
  R: TRect;                                  {Rechteck fr Menleiste}

begin
  GetExtent(R);                     {Liefert Gr”áe der aktuellen View}
  if _ShowTitel
   then Inc(R.A.Y);                   {Wird wegen Titelzeile ben”tigt}
  R.B.Y:= R.A.Y + 1;               {Gr”áe und Position der Menleiste}
  MenuBar:= New(PMenuBar,Init(R,NewMenu(
    NewSubMenu('~S~ystem',hcSystem,NewMenu(
      NewItem('šber das ~P~rogramm...','',kbNoKey,_cmAbout,hcSAbout,
      NewItem('~C~ompiler-Info...','',kbNoKey,_cmComp,hcSCompiler,
      NewItem('~D~OS shell','',kbNoKey,_cmDosShell,hcSDOSshell,
      NewLine(
      NewItem('~B~eenden','Alt-X',kbAltX,cmQuit,hcSBeenden,
      nil)))))),
    NewSubMenu('~D~atei',hcDatei,NewMenu(
      NewItem('L~i~ste...','',kbNokey,_cmListDir,hcDListe,
      NewItem('~L~”schen...','',kbNoKey,_cmDelFile,hcDLoeschen,
      NewItem('Directory ~w~echseln...','',kbNoKey,_cmChDir,hcDChangeDir,
      nil)))),
    NewSubMenu('~F~enster',hcFenster,NewMenu(
      NewItem('~V~orheriges','Shift-F6',kbShiftF6,cmPrev,hcFVorheriges,
      NewItem('~N~„chstes','F6',kbF6,cmNext,hcFNaechstes,
      NewItem('Verschie~b~en','Ctrl-F5',kbCtrlF5,cmResize,hcFVerschieben,
      NewItem('~Z~oomen','F5',kbF5,cmZoom,hcFZoomen,
      NewItem('~S~chlieáen','Alt-F3',kbAltF3,cmClose,hcFSchliessen,
      nil)))))),
    nil)))
  )));
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.OutOfMemory                                                ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ šberschreibt die gleichnamige Methode und implementiert eine     ³
 ³ eigene Fehlermeldung, die auf Grund von ValidView gleich True    ³
 ³ ausgegeben wird.                                                 ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TXApp.OutOfMemory;
begin
  _TVFehlerBox(#13 + 'Arbeitsspeicher reicht fr durch' +
               'gefhrte Operation nicht aus!');
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.ListDirectory                                              ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Ermittelt aus einer File-Box einen Dateinamen. SearchStr bezeich-³
 ³ net den Suchstring (z.B. '*.pas'), Bez ist eine Bezeichnung der  ³
 ³ File-Box. Der Variablenparameter FindName liefert den ausgew„hl- ³
 ³ ten Dateinamen an das aufrufende Programm zurck.                ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TXApp.ListDirectory(SearchStr,Bez: string;
                                var FindName: string);
var
  D: PFileDialog;                                {Zeiger fr File-Box}
  s: PathStr;                                              {Dateiname}

begin
  FindName:= '';                                      {Initialisieren}
  D:= New(PFileDialog,Init(SearchStr,Bez,'~D~ateiname',
                           fdOkButton,1));
  D^.HelpCtx:= hcDODialogfenster;
  if ValidView(D) <> nil then
  begin
    if Desktop^.ExecView(D) <> cmCancel then
    begin
      D^.GetFileName(s);
      FindName:= s;
    end;
    Dispose(D,Done);
  end;
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.DeleteFile                                                 ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Ermittelt aus einer File-Box eine zu l”schende Datei.            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TXApp.DeleteFile;
var
  Name,                                           {Zu l”schende Datei}
  Frage: string;
  f: file;                                            {Diskettendatei}

begin
  ListDirectory('*.*','Datei l”schen',Name);
  if Name <> '' then
  begin
    Frage:= #13 + ^C'Datei'#13 +
            #13 + ^C'' + Name + ''#13 +
            #13 + ^C'wirklich l”schen?';
    if _TVFrageBox(Frage) then
    begin
      Assign(f,Name);
      {$I-} Reset(f); {$I+}
      if IOResult = 0 then
      begin
        Close(f);
        Erase(f);
      end; {if}
    end; {if}
  end;
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.ChangeDirectory                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Wechselt das Laufwerk ber eine ChangeDir-Box.                   ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TXApp.ChangeDirectory;
var
  D: PChDirDialog;                                      {Dialogobjekt}

begin
  D:= New(PChDirDialog,Init(cdNormal,2));
  D^.HelpCtx:= hcDOChDirDialog;
  if ValidView(D) <> nil then
  begin
    DeskTop^.ExecView(D);
    Dispose(D,done);
  end;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.DosShell                                                   ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Wechselt auf die DOS-Ebene.                                      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TXApp.DosShell;
begin
  DoneSysError;
  DoneEvents;
  DoneVideo;
  DoneMemory;
  SetMemTop(HeapPtr);
  PrintStr('Mit EXIT zurck zum Programm...');
  SwapVectors;
  Exec(GetEnv('COMSPEC'), '');
  SwapVectors;
  SetMemTop(HeapEnd);
  InitMemory;
  InitVideo;
  InitEvents;
  InitSysError;
  Redraw;
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.HandleEvent                                                ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Stellt fr den oben genannten Objekttyp einen Event-Handler zur  ³
 ³ Verfgung.                                                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TXApp.HandleEvent(var Event: TEvent);
var
  FindName: string;                  {Ausgew. Datei von ListDirectory}

begin
  TApplication.HandleEvent(Event);
  if Event.What = evCommand then
  begin
    case Event.Command of
      _cmAbout     : _TVInfoRect(40,11,'Programm-Info',
                                 _PrgInfo);
      _cmComp      : _TVInfoRect(40,11,'Compiler-Info',
                                 _CompInfo);
      _cmListDir   : ListDirectory('*.*','Dateiliste',
                                  FindName);
      _cmDelFile   : DeleteFile;
      _cmChDir     : ChangeDirectory;
      _cmDosShell  : DosShell;
      else Exit;
    end; {case}
    ClearEvent(Event);
  end; {if}
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.GetEvent                                                   ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ F„ngt cmHelp ab und ”ffnet den Help-Stream.                      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TXApp.GetEvent(var Event: TEvent);
const
  HelpInUse: boolean = false;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄErmittleHelpNameÄÄ}
function ErmittleHelpName: PathStr;
var
  EXEName: PathStr;                         {Dateiname der .EXE-Datei}
  D: DirStr;                                               {Directory}
  N: NameStr;                                         {Name der Datei}
  E: ExtStr;                                             {Erweiterung}

begin
  if Lo(DosVersion) >= 3
   then EXEName:= ParamStr(0)
   else EXEName:= FSearch(_EXEDatei,GetEnv('PATH'));
   FSplit(EXEName,D,N,E);
   if D[Length(D)] = '\' then Dec(D[0]);
   ErmittleHelpName:= FSearch(_HLPDatei,D);
end;
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄCallHelpFileÄÄ}
procedure CallHelpFile(var HelpFree: boolean);
var
  W: PWindow;
  HelpFile: PHelpFile;
  HelpStrm: PDosStream;

begin
  HelpStrm:= New(PDosStream,Init(ErmittleHelpName,stOpenRead));
  HelpFile:= New(PHelpFile,Init(HelpStrm));
  if HelpStrm^.Status <> stOk
  then begin
         MessageBox('Hilfedatei ' + _HLPDatei + ' konnte nicht ' +
                    'ge”ffnet werden!',nil,mfError + mfOkButton);
         Dispose(HelpFile,Done);
       end
  else begin
         HelpFree:= true;
         W:= New(PHelpWindow,Init(Helpfile,GetHelpCtx));
         if ValidView(W) <> nil then
         begin
           ExecView(W);
           Dispose(W,Done);
         end;
         HelpFree:= false;
         ClearEvent(Event);
       end;
end;
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

begin
  TApplication.GetEvent(Event);             {Aufruf Vorg„nger-Methode}
  If (Event.What = evCommand) and
     (Event.Command = cmHelp) and not HelpInUse
  then CallHelpFile(HelpInUse);
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TXApp.GetPalette                                                 ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Paát die Farbpalette an. Siehe auch Demo-Programm (TVDemo) zu    ³
 ³ Turbo Vision von Borland.                                        ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
function TXApp.GetPalette: PPalette;
const
  CNewColor = CAppColor + CHelpColor;
  CNewBW = CAppBlackWhite + CHelpBlackWhite;
  CNewMono = CAppMonochrome + CHelpMonochrome;
  P: array[apColor..apMonochrome]
      of string[Length(CNewColor)] = (CNewColor,CNewBW,CNewMono);

begin
  GetPalette:= @P[AppPalette];
end;
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}

begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄHauptprogrammÄÄ}
  MyApp.Init;
  MyApp.Run;
  MyApp.Done;
{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º End of program                                                   º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
end.