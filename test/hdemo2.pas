{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �        Demoprogramm zum Turbo Vision-Hilfesystem           �
 �                                                            �
 �            Autor: Reiner Sch�lles, 30.10.92                �
 �                                                            �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program HDemo2;
{$X+}                                        {Erweiterte Syntax}
{$M 16384,8192,655360}
uses {陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Einzubindende Bibliotheken陳}
  Dos,App,Objects,Menus,
  Drivers,Views,Dialogs,
  MsgBox,StdDlg,Memory,
  Gadgets,HelpFile,                     {Units aus Turbo Pascal}
  HText;                               {Unit von TVHC generiert}

const {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Globale Konstanten陳}
  cmAbout      = 1001;                      {Copyright anzeigen}
  cmComp       = 1002;                           {Compiler-Info}
  cmDosShell   = 1003;                               {Dos-Shell}

  PrgName   = ^C'Help-Demo-Programm'#13;          {Programmname}
  AutorName = ^C'Reiner Sch�lles';             {Name des Autors}

  PrgInfo = PrgName +                            {Programm-Info}
            ^C'Copyright (C) 1992 by' +  #13 +
             AutorName;

  CompInfo = ^C'Programm erstellt mit'#13 +      {Compiler-Info}
             ^C'Turbo Pascal 7.0'#13 +
             ^C'Borland International, Inc.';

type {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Globale Datentypen陳}
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳TDemo 陳}
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
  end;

var {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Globale Variablen陳}
  HDemoApp: TDemo;                           {Programm-Variable}

  {陳陳陳陳陳陳陳陳陳陳陳陳�Verzeichnis der globalen Routinen陳}

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Implementierung der Methoden von TDemo                     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TDemo.Init                                                 �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � �bernimmt die notwendigen Initialisierungen, z.B. Anzeige  �
 � der Uhrzeit und des freien Arbeitsspeiches.                �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
constructor TDemo.Init;
var
  R: TRect;                     {Rechteckiger Bildschirmbereich}

begin
  TApplication.Init;               {Init-Methode des Vorg�ngers}
  RegisterHelpFile;                   {Help-Stream registrieren}

  GetExtent(R); {陳陳陳陳陳�Initialisiert Anzeige der Uhrzeit陳}
  R.A.X:= R.B.X - 9;
  R.B.Y:= R.A.Y + 1;
  Uhrzeit:= New(PClockView,Init(R));
  Insert(Uhrzeit);

  GetExtent(R); {陳陳Initialisiert Anzeige d.freien Speichers陳}
  Dec(R.B.X);
  R.A.X:= R.B.X - 9;
  R.A.Y:= R.B.Y - 1;
  Heap := New(PHeapView,Init(R));
  Insert(Heap);

  MessageBox(PrgInfo,nil,               {Programm-Info anzeigen}
             mfInformation + mfOkButton);
end;
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TDemo.Idle                                                 �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Idle ist eine abstrakte Methode, die hier �berschrieben    �
 � wird. Sie wird immer dann aufgerufen, wenn keine Ereignisse�
 � zur Bearbeitung vorliegen.                                 �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure TDemo.Idle;
begin
  TApplication.Idle;                     {Aufruf des Vorg�ngers}
  Uhrzeit^.Update;                       {Uhrzeit aktualisieren}
  Heap^.Update;                  {Freien Speicher aktualisieren}
end;
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TDemo.InitStatusLine                                       �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Initialisiert eine neue Statuszeile und �berschreibt damit �
 � die von TProgram.InitStatusLine.                           �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TDemo.InitMenuBar                                          �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Initialisiert eine neue Men�leiste und �berschreibt  damit �
 � die von TProgram.InitMenuBar.                              �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TDemo.OutOfMemory                                          �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � �berschreibt die gleichnamige Methode und implementiert    �
 � eine eigene Fehlermeldung, die auf Grund von ValidView     �
 � gleich True ausgegeben wird.                               �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure TDemo.OutOfMemory;
begin
  MessageBox(#13 + 'Arbeitsspeicher reicht f�r durch' +
               'gef�hrte Operation nicht aus!',nil,
               mfError + mfOkButton);
end;
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TDemo.DosShell                                             �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Wechselt auf die DOS-Ebene.                                �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TDemo.HandleEvent                                          �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Stellt f�r den oben genannten Objekttyp einen Event-Handler�
 � zur Verf�gung.                                             �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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

{様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様}

begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Hauptprogramm陳}
  HDemoApp.Init;
  HDemoApp.Run;
  HDemoApp.Done;
end.
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � End of Program                                             �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}