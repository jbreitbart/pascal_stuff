{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                     Turbo Vision-Demoprogramm                    �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demoprogramm zu Turbo Vision.                                    �
 ������������������������������������������������������������������ͼ}
Program TVDemo16;                                {Datei: TVDemo16.pas}
{$X+}                                 {Erweiterte Syntax (Funktionen)}
uses {�����������������������������������Einzubindende Bibliotheken��}
  App,Objects,Menus,Drivers,
  Views,Dialogs,MsgBox;                  {Bibliothek aus Turbo Pascal}

const {������������������������������������������Globale Konstanten��}
  cmAbout = 1001;                                 {Copyright anzeigen}
  cmList  = 1002;                                       {Datei listen}
  cmPara  = 1003;                                   {Parameter �ndern}

type {�������������������������������������������Globale Datentypen��}
  TBspApp = object (TApplication)
    procedure InitStatusLine; virtual;
    procedure InitMenuBar; virtual;
    procedure OutOfMemory; virtual;
    procedure About;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure NewParameter;
  end;

  PParaDialog = ^TParaDialog;
  TParaDialog = object (TDialog)
  end;

  ParaDataRec = record                    {DatenRecord f�r Dialogfeld} 
    DruckData: word;                                 {Markierungsfeld}
    SchriftData: word;                                    {Schaltfeld}
    HinweisData: string[50];                             {Eingabefeld}
  end;

var {���������������������������������������������Globale Variablen��}
  BspApp: TBspApp;
  ParaData: ParaDataRec;                           {F�r die Dialogbox}

{������������������������������������������������������������������Ŀ
 � TBspApp.IntiStatusLine                                           �
 ������������������������������������������������������������������Ĵ
 � Initialisiert eine neue Statuszeile und �berschreibt damit die   �
 � von TProgram.InitStatusLine.                                     �
 ��������������������������������������������������������������������}
procedure TBspApp.InitStatusLine;
var R: TRect;                               {Rechteck f�r Statuszeile}
begin
  GetExtent(R);                  {Liefert H�he und Breite des Objekts}
  R.A.Y:= R.B.Y - 1;              {Gr��e und Position der Statuszeile}
  StatusLine:= New(PStatusLine,Init(R,
    NewStatusDef(0,$FFFF,
      NewStatusKey('~Alt-X~ Programm beenden',kbAltX,cmQuit,
      NewStatusKey('',kbF10,cmMenu,
      NewStatusKey('~Alt-F3~ Close',kbAltF3,cmClose,
      nil))),
    nil)
  ));
end; {TBspApp.InitStatusLine}
{������������������������������������������������������������������Ŀ
 � TBspApp.IntitMenuBar                                             �
 ������������������������������������������������������������������Ĵ
 � Initialisiert eine neue Men�leiste und �berschreibt damit die    �
 � von TProgram.InitMenuBar.                                        �
 ��������������������������������������������������������������������}
procedure TBspApp.InitMenuBar;
var R: TRect;                               {Rechteck f�r Statuszeile}
begin
  GetExtent(R);                     {Liefert Gr��e der aktuellen View}
  R.B.Y:= R.A.Y + 1;               {Gr��e und Position der Men�leiste}
  MenuBar:= New(PMenuBar,Init(R,NewMenu(
    NewSubMenu('~S~ystem',hcNoContext,NewMenu(
      NewItem('~A~bout...','',kbNoKey,cmAbout,hcNoContext,
      NewItem('~C~lose','Alt-F3',kbAltF3,cmClose,hcNoContext,
      NewLine(
      NewItem('~B~eenden','Alt-X',kbAltX,cmQuit,hcNoContext,
      nil))))),
    NewSubMenu('~F~ile',hcNoContext,NewMenu(
      NewItem('~L~ist','F2',kbF2,cmList,hcNoContext,
      NewItem('~P~arameter','',kbNoKey,cmPara,hcNoContext,
      nil))),
    nil)))
  ));
end; {TBspApp.InitMenuBar}
{������������������������������������������������������������������Ŀ
 � TBspApp.OutOfMemory                                              �
 ������������������������������������������������������������������Ĵ
 � �berschreibt die gleichnamige Methode und implementiert eine ei- �
 � gene Fehlermeldung, die auf Grund von ValidView gleich True      �
 � liefert.                                                         �
 ��������������������������������������������������������������������}
procedure TBspApp.OutOfMemory;
begin
  MessageBox('Arbeitsspeicher reicht f�r durch' +
             'gef�hrte Operation nicht aus!',
             nil,mfError + mfOkButton);
end; {TBspApp.OutOfMemory}
{������������������������������������������������������������������Ŀ
 � TBspApp.About                                                    �
 ������������������������������������������������������������������Ĵ
 � Gibt in einem Dialogfenster �ber ein TDialog-Objekt eine Copy-   �
 � right-Meldung aus.                                               �
 ��������������������������������������������������������������������}
procedure TBspApp.About;
var
  D: PDialog;                                           {Dialogobjekt}
  R: TRect;                                     {Rechteckiger Bereich}

begin
  R.Assign(0,0,42,11);                             {Bereich festlegen}
  D:= New(PDialog,Init(R,'Copyright'));
  with D^ do
  begin
    Options:= Options or ofCentered;                   {Box zentriert}
    R.Grow(-1,-1);                               {Fenster verkleinern}
    Insert(New(PStaticText,Init(R,
      #13 +
      ^C'Das gro�e Buch zu Turbo Pascal 7.0'#13 +
      #13 +
      ^C'Copyright (C) 1992 by'#13 +
      #13 +
      ^C'DATA Becker - D�sseldorf'
    )));
    R.Assign(16,8,26,10);
    Insert(New(PButton,Init(R,'~O~K',cmOK,bfDefault)));
  end;
  if ValidView(D) <> nil then
  begin
    Desktop^.ExecView(D);              {Funktionsaufruf ohne Ergebnis}
    Dispose(D,Done);                         {Objekt wieder freigeben}
  end;
end; {TBspApp.About}
{������������������������������������������������������������������Ŀ
 � TBspApp.HandleEvent                                              �
 ������������������������������������������������������������������Ĵ
 � Stellt f�r den oben genannten Objekttyp einen Event-Handler zur  �
 � Verf�gung.                                                       �
 ��������������������������������������������������������������������}
procedure TBspApp.HandleEvent(var Event: TEvent);
begin
  TApplication.HandleEvent(Event);
  if Event.What = evCommand then
  begin
    case Event.Command of
      cmAbout: About;
      cmList : begin end;
      cmPara : NewParameter;
      else Exit;
    end; {case}
    ClearEvent(Event);
  end; {if}
end; {TBspApp.HandleEvent}
{������������������������������������������������������������������Ŀ
 � TBspApp.NewParameter                                             �
 ������������������������������������������������������������������Ĵ
 � �ffnet eine Dialogbox zur Eingabe neuer Parameter.               �
 ��������������������������������������������������������������������}
procedure TBspApp.NewParameter;
var
  Parameter: PParaDialog;
  Ptr: PView;                                  {Zeiger auf Auswahlbox}
  Dummy: word;                                 {Ergebnis von ExecView}
  R: TRect;

begin
  R.Assign(22,4,57,19);
  Parameter:= New(PParaDialog,Init(R,'Parameter'));
  with Parameter^ do
  begin
    {�����������������������������������������CheckBox installieren��}
    R.Assign(2,3,18,7);
    Ptr:= New(PCheckBoxes,Init(R,
      NewSItem('~D~ateiname',
      NewSItem('~Z~eilen-Nr.',
      NewSItem('D~a~tum',
      NewSItem('~U~hrzeit',
      nil))))
    ));
    Insert(Ptr);
    R.Assign(2,2,10,3);
    Insert(New(PLabel,Init(R,'Drucken',Ptr)));

    {�����������������������������������������RadioBox installieren��}
    R.Assign(21,4,33,6);
    Ptr:= New(PRadioButtons,Init(R,
      NewSItem('~N~ormal',
      NewSItem('~K~lein',
      nil))
    ));
    Insert(Ptr);
    R.Assign(20,3,31,4);
    Insert(New(PLabel,Init(R,'Schriftart',Ptr)));

    {�����������������������������Eingabefeld installieren��}
    R.Assign(3,10,32,11);
    Ptr:= New(PInputLine,Init(R,50));
    Insert(Ptr);
    R.Assign(2,9,10,10);
    Insert(New(PLabel,Init(R,'Hinweis',Ptr)));

    {�����������������������������������������Schalter installieren��}
    R.Assign(7,12,17,14);
    Insert(New(PButton,Init(R,'~O~K',cmOK,bfDefault)));
    R.Assign(19,12,32,14);
    Insert(New(PButton,Init(R,'Abbruch',cmCancel,bfNormal)));
  end; {with}

  {�����������Nur wenn gen�gend Heap vorhanden, in Gruppe einf�gen��}
  if ValidView(Parameter) <> nil then
  begin
    Parameter^.SetData(ParaData);                   {Voreinstellungen}
    Dummy:= DeskTop^.ExecView(Parameter);
    if Dummy <> cmCancel
      then Parameter^.GetData(ParaData);          {Ge�nderte Eintr�ge}
    Dispose(Parameter,Done);                 {Objekt wieder freigeben}
  end; {if}
end; {BspApp.NewParameter}
{������������������������������������������������������������������Ŀ
 � InitParaDataRec                                                  �
 ������������������������������������������������������������������Ĵ
 � Initialisiert den Daten-Record f�r die Dialogbox.                �
 ��������������������������������������������������������������������}
procedure InitParaDataRec;
begin
  with ParaData do
  begin
    DruckData:= 1;
    SchriftData:= 0;
    HinweisData:= 'Demo-Programm zu Turbo Vision';
  end; {with}
end; {InitParaDataRec}
{��������������������������������������������������������������������}

begin {�����������������������������������������������Hauptprogramm��}
  InitParaDataRec;                       {Daten-Rekord initialisieren}
  BspApp.Init;
  BspApp.Run;
  BspApp.Done;
end.
{����������������������������������������������������End of program��}