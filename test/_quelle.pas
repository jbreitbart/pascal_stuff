{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                     Turbo Vision-Rahmenprogramm                  �
 �                 Autor: Reiner Sch�lles, 05.11.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Rahmenprogramm f�r Turbo Vision-Applikationen.                   �
 ������������������������������������������������������������������ͼ}
{                     Inhalt und Hinweise

   Das Programm _Quelle.pas soll Ihnen als Rahmen f�r eigene Turbo
   Vision-Applikationen dienen. Es ist bereits mit einer Vielzahl
   von Funktionen ausgestattet. F�r einige von ihnen finden Sie
   die Anregungen in dem Demoprogramm von Borland (TVDemo.PAS).

 ��������������������������������������������������������������������}

Program _Quelle;
{$X+}                                              {Erweiterte Syntax}
{$M 16384,8192,655360}
uses {�����������������������������������Einzubindende Bibliotheken��}
  Dos,App,Objects,Menus,
  Drivers,Views,Dialogs,
  MsgBox,StdDlg,Memory,
  Helpfile,Gadgets,                           {Units aus Turbo Pascal}
  _Hilfe,                                   {Unit aus diesem Programm}
  _TVTools;                             {Eigene Unit f�r Turbo Vision}

const {������������������������������������������Globale Konstanten��}
  _cmAbout      = 1001;                           {Copyright anzeigen}
  _cmComp       = 1002;                                {Compiler-Info}
  _cmListDir    = 1003;                               {Dateien listen}
  _cmDelFile    = 1004;                                {Datei l�schen}
  _cmChDir      = 1005;                           {Directory wechseln}
  _cmDosShell   = 1006;                                    {Dos-Shell}

  _EXEDatei = '_Quelle.Exe';                  {Name dieser .EXE-Datei}
  _HLPDatei = '_Hilfe.Hlp';                    {Datei mit Hilfetexten}

  _PrgName   = ^C'Testversion 1.0';                     {Programmname}
  _AutorName = ^C'Reiner Sch�lles';                  {Name des Autors}

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

type {�������������������������������������������Globale Datentypen��}
  {����������������������������������������������������������TXApp ��}
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


var {���������������������������������������������Globale Variablen��}
  MyApp: TXApp;                                    {Programm-Variable}

  {�������������������������������Verzeichnis der globalen Routinen��}

{������������������������������������������������������������������ͻ
 � Implementierung der Methoden von TXApp                           �
 ������������������������������������������������������������������ͼ}

{������������������������������������������������������������������Ŀ
 � TXApp.Init                                                       �
 ������������������������������������������������������������������Ĵ
 � �bernimmt die notwendigen Initialisierungen, z.B. Anzeige der    �
 � Uhrzeit und des freien Arbeitsspeiches.                          �
 ��������������������������������������������������������������������}
constructor TXApp.Init;
var
  R: TRect;                           {Rechteckiger Bildschirmbereich}
  Titel: _PXStaticText;                        {Zeiger auf Titelzeile}

begin
  TApplication.Init;                     {Init-Methode des Vorg�ngers}
  RegisterHelpFile;

  if _ShowTitel then
  begin
    GetExtent(R); {��������������������Initialisiert die Titelzeile��}
    R.B.Y:= R.A.Y + 1;
    Titel:= New(_PXStaticText,Init(R,_TitelZ));
    Insert(Titel);
  end;

  GetExtent(R); {�����������������Initialisiert Anzeige der Uhrzeit��}
  if _ShowTitel
   then Inc(R.A.Y);                   {Wird wegen Titelzeile ben�tigt}
  R.A.X:= R.B.X - 9;
  R.B.Y:= R.A.Y + 1;
  Uhrzeit:= New(PClockView,Init(R));
  Insert(Uhrzeit);

  GetExtent(R); {����������Initialisiert Anzeige d.freien Speichers��}
  Dec(R.B.X);
  R.A.X:= R.B.X - 9;
  R.A.Y:= R.B.Y - 1;
  Heap := New(PHeapView,Init(R));
  Insert(Heap);

  _TVInfoBox(_PrgInfo);                       {Programm-Info anzeigen}
end;
{������������������������������������������������������������������Ŀ
 � TXApp.Idle                                                       �
 ������������������������������������������������������������������Ĵ
 � Idle ist eine abstrakte Methode, die hier �berschrieben wird. Sie�
 � wird immer dann aufgerufen, wenn keine Ereignisse zur Bearbeitung�
 � vorliegen.                                                       �
 ��������������������������������������������������������������������}
procedure TXApp.Idle;
begin
  TApplication.Idle;                           {Aufruf des Vorg�ngers}
  Uhrzeit^.Update;                             {Uhrzeit aktualisieren}
  Heap^.Update;                        {Freien Speicher aktualisieren}
end;
{������������������������������������������������������������������Ŀ
 � TXApp.InitStatusLine                                             �
 ������������������������������������������������������������������Ĵ
 � Initialisiert eine neue Statuszeile und �berschreibt damit die   �
 � von TProgram.InitStatusLine.                                     �
 ��������������������������������������������������������������������}
procedure TXApp.InitStatusLine;
var
  R: TRect;                                 {Rechteck f�r Statuszeile}

begin
  GetExtent(R);                  {Liefert H�he und Breite des Objekts}
  R.A.Y:= R.B.Y - 1;              {Gr��e und Position der Statuszeile}
  StatusLine:= New(PStatusLine,Init(R,
    NewStatusDef(0,$FFFF,
      NewStatusKey('~F1~ Hilfe',kbF1,cmHelp,
      NewStatusKey('~Alt-F3~ Schlie�en',kbAltF3,cmClose,
      NewStatusKey('~F10~ Men�',kbF10,cmMenu,
      NewStatusKey('~Alt-X~ Programm beenden',kbAltX,cmQuit,
      nil)))),
    nil)
  ));
end;
{������������������������������������������������������������������Ŀ
 � TXApp.InitMenuBar                                                �
 ������������������������������������������������������������������Ĵ
 � Initialisiert eine neue Men�leiste und �berschreibt  damit die   �
 � von TProgram.InitMenuBar.                                        �
 ��������������������������������������������������������������������}
procedure TXApp.InitMenuBar;
var
  R: TRect;                                  {Rechteck f�r Men�leiste}

begin
  GetExtent(R);                     {Liefert Gr��e der aktuellen View}
  if _ShowTitel
   then Inc(R.A.Y);                   {Wird wegen Titelzeile ben�tigt}
  R.B.Y:= R.A.Y + 1;               {Gr��e und Position der Men�leiste}
  MenuBar:= New(PMenuBar,Init(R,NewMenu(
    NewSubMenu('~S~ystem',hcSystem,NewMenu(
      NewItem('�ber das ~P~rogramm...','',kbNoKey,_cmAbout,hcSAbout,
      NewItem('~C~ompiler-Info...','',kbNoKey,_cmComp,hcSCompiler,
      NewItem('~D~OS shell','',kbNoKey,_cmDosShell,hcSDOSshell,
      NewLine(
      NewItem('~B~eenden','Alt-X',kbAltX,cmQuit,hcSBeenden,
      nil)))))),
    NewSubMenu('~D~atei',hcDatei,NewMenu(
      NewItem('L~i~ste...','',kbNokey,_cmListDir,hcDListe,
      NewItem('~L~�schen...','',kbNoKey,_cmDelFile,hcDLoeschen,
      NewItem('Directory ~w~echseln...','',kbNoKey,_cmChDir,hcDChangeDir,
      nil)))),
    NewSubMenu('~F~enster',hcFenster,NewMenu(
      NewItem('~V~orheriges','Shift-F6',kbShiftF6,cmPrev,hcFVorheriges,
      NewItem('~N~�chstes','F6',kbF6,cmNext,hcFNaechstes,
      NewItem('Verschie~b~en','Ctrl-F5',kbCtrlF5,cmResize,hcFVerschieben,
      NewItem('~Z~oomen','F5',kbF5,cmZoom,hcFZoomen,
      NewItem('~S~chlie�en','Alt-F3',kbAltF3,cmClose,hcFSchliessen,
      nil)))))),
    nil)))
  )));
end;
{������������������������������������������������������������������Ŀ
 � TXApp.OutOfMemory                                                �
 ������������������������������������������������������������������Ĵ
 � �berschreibt die gleichnamige Methode und implementiert eine     �
 � eigene Fehlermeldung, die auf Grund von ValidView gleich True    �
 � ausgegeben wird.                                                 �
 ��������������������������������������������������������������������}
procedure TXApp.OutOfMemory;
begin
  _TVFehlerBox(#13 + 'Arbeitsspeicher reicht f�r durch' +
               'gef�hrte Operation nicht aus!');
end;
{������������������������������������������������������������������Ŀ
 � TXApp.ListDirectory                                              �
 ������������������������������������������������������������������Ĵ
 � Ermittelt aus einer File-Box einen Dateinamen. SearchStr bezeich-�
 � net den Suchstring (z.B. '*.pas'), Bez ist eine Bezeichnung der  �
 � File-Box. Der Variablenparameter FindName liefert den ausgew�hl- �
 � ten Dateinamen an das aufrufende Programm zur�ck.                �
 ��������������������������������������������������������������������}
procedure TXApp.ListDirectory(SearchStr,Bez: string;
                                var FindName: string);
var
  D: PFileDialog;                                {Zeiger f�r File-Box}
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
{������������������������������������������������������������������Ŀ
 � TXApp.DeleteFile                                                 �
 ������������������������������������������������������������������Ĵ
 � Ermittelt aus einer File-Box eine zu l�schende Datei.            �
 ��������������������������������������������������������������������}
procedure TXApp.DeleteFile;
var
  Name,                                           {Zu l�schende Datei}
  Frage: string;
  f: file;                                            {Diskettendatei}

begin
  ListDirectory('*.*','Datei l�schen',Name);
  if Name <> '' then
  begin
    Frage:= #13 + ^C'Datei'#13 +
            #13 + ^C'' + Name + ''#13 +
            #13 + ^C'wirklich l�schen?';
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
{������������������������������������������������������������������Ŀ
 � TXApp.ChangeDirectory                                            �
 ������������������������������������������������������������������Ĵ
 � Wechselt das Laufwerk �ber eine ChangeDir-Box.                   �
 ��������������������������������������������������������������������}
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

{������������������������������������������������������������������Ŀ
 � TXApp.DosShell                                                   �
 ������������������������������������������������������������������Ĵ
 � Wechselt auf die DOS-Ebene.                                      �
 ��������������������������������������������������������������������}
procedure TXApp.DosShell;
begin
  DoneSysError;
  DoneEvents;
  DoneVideo;
  DoneMemory;
  SetMemTop(HeapPtr);
  PrintStr('Mit EXIT zur�ck zum Programm...');
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
{������������������������������������������������������������������Ŀ
 � TXApp.HandleEvent                                                �
 ������������������������������������������������������������������Ĵ
 � Stellt f�r den oben genannten Objekttyp einen Event-Handler zur  �
 � Verf�gung.                                                       �
 ��������������������������������������������������������������������}
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
{������������������������������������������������������������������Ŀ
 � TXApp.GetEvent                                                   �
 ������������������������������������������������������������������Ĵ
 � F�ngt cmHelp ab und �ffnet den Help-Stream.                      �
 ��������������������������������������������������������������������}
procedure TXApp.GetEvent(var Event: TEvent);
const
  HelpInUse: boolean = false;

{��������������������������������������������������ErmittleHelpName��}
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
{������������������������������������������������������CallHelpFile��}
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
                    'ge�ffnet werden!',nil,mfError + mfOkButton);
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
{��������������������������������������������������������������������}

begin
  TApplication.GetEvent(Event);             {Aufruf Vorg�nger-Methode}
  If (Event.What = evCommand) and
     (Event.Command = cmHelp) and not HelpInUse
  then CallHelpFile(HelpInUse);
end;
{������������������������������������������������������������������Ŀ
 � TXApp.GetPalette                                                 �
 ������������������������������������������������������������������Ĵ
 � Pa�t die Farbpalette an. Siehe auch Demo-Programm (TVDemo) zu    �
 � Turbo Vision von Borland.                                        �
 ��������������������������������������������������������������������}
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
{��������������������������������������������������������������������}

begin {�����������������������������������������������Hauptprogramm��}
  MyApp.Init;
  MyApp.Run;
  MyApp.Done;
{������������������������������������������������������������������ͻ
 � End of program                                                   �
 ������������������������������������������������������������������ͼ}
end.