{������������������������������������������������������������ͻ
 �        Demoprogramm zum Turbo Vision-Hilfesystem           �
 �                                                            �
 �            Autor: Reiner Sch�lles, 30.10.92                �
 �                                                            �
 ������������������������������������������������������������ͼ}
Program HDemo4;
{$X+}                                        {Erweiterte Syntax}
{$M 16384,8192,655360}
uses {�����������������������������Einzubindende Bibliotheken��}
  Dos,App,Objects,Menus,
  Drivers,Views,Dialogs,
  MsgBox,StdDlg,Memory,
  Gadgets,HelpFile,                     {Units aus Turbo Pascal}
  HText;                               {Unit von TVHC generiert}

const {������������������������������������Globale Konstanten��}
  cmAbout      = 1001;                      {Copyright anzeigen}
  cmComp       = 1002;                           {Compiler-Info}
  cmDosShell   = 1003;                               {Dos-Shell}

  PrgName   = ^C'Help-Demo-Programm'#13;          {Programmname}
  AutorName = ^C'Reiner Sch�lles';             {Name des Autors}

  _EXEDatei = 'HDemo4.Exe';             {Name dieser .EXE-Datei}
  _HLPDatei = 'HText.Hlp';               {Datei mit Hilfetexten}



  PrgInfo = PrgName +                            {Programm-Info}
            ^C'Copyright (C) 1992 by' +  #13 +
             AutorName;

  CompInfo = ^C'Programm erstellt mit'#13 +      {Compiler-Info}
             ^C'Turbo Pascal 7.0'#13 +
             ^C'Borland International, Inc.';

type {�������������������������������������Globale Datentypen��}
  {����������������������������������������������������TDemo ��}
  TDemo = object (TApplication)
    Uhrzeit: PClockView;
    Heap: PHeapView;
    constructor Init;
    procedure Idle; virtual;
    procedure InitStatusLine; virtual;
    procedure InitMenuBar; virtual;
    procedure OutOfMemory; virtual;
    procedure DosShell;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure GetEvent(var Event: TEvent); virtual;
    function GetPalette: PPalette; virtual;
  end;

var {���������������������������������������Globale Variablen��}
  HDemoApp: TDemo;                           {Programm-Variable}

  {�������������������������Verzeichnis der globalen Routinen��}

{������������������������������������������������������������ͻ
 � Implementierung der Methoden von TDemo                     �
 ������������������������������������������������������������ͼ}

{������������������������������������������������������������Ŀ
 � TDemo.Init                                                 �
 ������������������������������������������������������������Ĵ
 � �bernimmt die notwendigen Initialisierungen, z.B. Anzeige  �
 � der Uhrzeit und des freien Arbeitsspeiches.                �
 ��������������������������������������������������������������}
constructor TDemo.Init;
var
  R: TRect;                     {Rechteckiger Bildschirmbereich}

begin
  TApplication.Init;               {Init-Methode des Vorg�ngers}
  RegisterHelpFile;                   {Help-Stream registrieren}

  GetExtent(R); {�����������Initialisiert Anzeige der Uhrzeit��}
  R.A.X:= R.B.X - 9;
  R.B.Y:= R.A.Y + 1;
  Uhrzeit:= New(PClockView,Init(R));
  Insert(Uhrzeit);

  GetExtent(R); {����Initialisiert Anzeige d.freien Speichers��}
  Dec(R.B.X);
  R.A.X:= R.B.X - 9;
  R.A.Y:= R.B.Y - 1;
  Heap := New(PHeapView,Init(R));
  Insert(Heap);

  MessageBox(PrgInfo,nil,               {Programm-Info anzeigen}
             mfInformation + mfOkButton);
end;
{������������������������������������������������������������Ŀ
 � TDemo.Idle                                                 �
 ������������������������������������������������������������Ĵ
 � Idle ist eine abstrakte Methode, die hier �berschrieben    �
 � wird. Sie wird immer dann aufgerufen, wenn keine Ereignisse�
 � zur Bearbeitung vorliegen.                                 �
 ��������������������������������������������������������������}
procedure TDemo.Idle;
begin
  TApplication.Idle;                     {Aufruf des Vorg�ngers}
  Uhrzeit^.Update;                       {Uhrzeit aktualisieren}
  Heap^.Update;                  {Freien Speicher aktualisieren}
end;
{������������������������������������������������������������Ŀ
 � TDemo.InitStatusLine                                       �
 ������������������������������������������������������������Ĵ
 � Initialisiert eine neue Statuszeile und �berschreibt damit �
 � die von TProgram.InitStatusLine.                           �
 ��������������������������������������������������������������}
procedure TDemo.InitStatusLine;
var
  R: TRect;                           {Rechteck f�r Statuszeile}

begin
  GetExtent(R);            {Liefert H�he und Breite des Objekts}
  R.A.Y:= R.B.Y - 1;        {Gr��e und Position der Statuszeile}
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
{������������������������������������������������������������Ŀ
 � TDemo.InitMenuBar                                          �
 ������������������������������������������������������������Ĵ
 � Initialisiert eine neue Men�leiste und �berschreibt  damit �
 � die von TProgram.InitMenuBar.                              �
 ��������������������������������������������������������������}
procedure TDemo.InitMenuBar;
var
  R: TRect;                            {Rechteck f�r Men�leiste}

begin
  GetExtent(R);               {Liefert Gr��e der aktuellen View}
  R.B.Y:= R.A.Y + 1;         {Gr��e und Position der Men�leiste}
  MenuBar:= New(PMenuBar,Init(R,NewMenu(
    NewSubMenu('~S~ystem',hcNoContext,NewMenu(
      NewItem('�ber das ~P~rogramm...','',kbNoKey,cmAbout,hcSAbout,
      NewItem('~C~ompiler-Info...','',kbNoKey,cmComp,hcSCompiler,
      NewItem('~D~OS shell','',kbNoKey,cmDosShell,hcSDosShell,
      NewLine(
      NewItem('~B~eenden','Alt-X',kbAltX,cmQuit,hcSBeenden,
      nil)))))),
    nil)
  )));
end;
{������������������������������������������������������������Ŀ
 � TDemo.OutOfMemory                                          �
 ������������������������������������������������������������Ĵ
 � �berschreibt die gleichnamige Methode und implementiert    �
 � eine eigene Fehlermeldung, die auf Grund von ValidView     �
 � gleich True ausgegeben wird.                               �
 ��������������������������������������������������������������}
procedure TDemo.OutOfMemory;
begin
  MessageBox(#13 + 'Arbeitsspeicher reicht f�r durch' +
               'gef�hrte Operation nicht aus!',nil,
               mfError + mfOkButton);
end;
{������������������������������������������������������������Ŀ
 � TDemo.DosShell                                             �
 ������������������������������������������������������������Ĵ
 � Wechselt auf die DOS-Ebene.                                �
 ��������������������������������������������������������������}
procedure TDemo.DosShell;
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
{������������������������������������������������������������Ŀ
 � TDemo.HandleEvent                                          �
 ������������������������������������������������������������Ĵ
 � Stellt f�r den oben genannten Objekttyp einen Event-Handler�
 � zur Verf�gung.                                             �
 ��������������������������������������������������������������}
procedure TDemo.HandleEvent(var Event: TEvent);
begin
  TApplication.HandleEvent(Event);
  if Event.What = evCommand then
  begin
    case Event.Command of
      cmAbout     : MessageBox(PrgInfo,nil,
                               mfInformation + mfOkButton);
      cmComp      : MessageBox(CompInfo,nil,
                               mfInformation + mfOkButton);
      cmDosShell  : DosShell;
      else Exit;
    end; {case}
    ClearEvent(Event);
  end; {if}
end;
{������������������������������������������������������������Ŀ
 � TDemo.GetEvent                                             �
 ������������������������������������������������������������Ĵ
 � F�ngt cmHelp ab und �ffnet den Help-Stream.                �
 ��������������������������������������������������������������}
procedure TDemo.GetEvent(var Event: TEvent);
const
  HelpInUse: boolean = false;

{��������������������������������������������ErmittleHelpName��}
function ErmittleHelpName: PathStr;
var
  EXEName: PathStr;                   {Dateiname der .EXE-Datei}
  D: DirStr;                                         {Directory}
  N: NameStr;                                   {Name der Datei}
  E: ExtStr;                                       {Erweiterung}

begin
  if Lo(DosVersion) >= 3
   then EXEName:= ParamStr(0)
   else EXEName:= FSearch(_EXEDatei,GetEnv('PATH'));
   FSplit(EXEName,D,N,E);
   if D[Length(D)] = '\' then Dec(D[0]);
   ErmittleHelpName:= FSearch(_HLPDatei,D);
end;
{������������������������������������������������CallHelpFile��}
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
{��������������������������������������������������������������}

begin
  TApplication.GetEvent(Event);       {Aufruf Vorg�nger-Methode}
  If (Event.What = evCommand) and
     (Event.Command = cmHelp) and not HelpInUse
  then CallHelpFile(HelpInUse);
end;
{������������������������������������������������������������Ŀ
 � TDemo.GetPalette                                           �
 ������������������������������������������������������������Ĵ
 � Pa�t die Farbpalette an. Siehe auch Demo-Programm (TVDemo) �
 � zu Turbo Vision von Borland.                               �
 ��������������������������������������������������������������}
function TDemo.GetPalette: PPalette;
const
  CNewColor = CAppColor + CHelpColor;
  CNewBW = CAppBlackWhite + CHelpBlackWhite;
  CNewMono = CAppMonochrome + CHelpMonochrome;
  P: array[apColor..apMonochrome]
      of string[Length(CNewColor)] = (CNewColor,CNewBW,CNewMono);

begin
  GetPalette:= @P[AppPalette];
end;

{��������������������������������������������������������������}

begin {�����������������������������������������Hauptprogramm��}
  HDemoApp.Init;
  HDemoApp.Run;
  HDemoApp.Done;
end.
{������������������������������������������������������������ͻ
 � End of Program                                             �
 ������������������������������������������������������������ͼ}