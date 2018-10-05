{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                     Turbo Vision-Demoprogramm                    �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demoprogramm zu Turbo Vision.                                    �
 ������������������������������������������������������������������ͼ}
Program TVDemo21;                                {Datei: TVDemo21.pas}
{$X+}                                 {Erweiterte Syntax (Funktionen)}
uses {�����������������������������������Einzubindende Bibliotheken��}
  Dos,App,Objects,Menus,Drivers,
  Views,Dialogs,MsgBox,StdDlg;           {Bibliothek aus Turbo Pascal}

const {������������������������������������������Globale Konstanten��}
  cmAbout      = 1001;                            {Copyright anzeigen}
  cmList       = 1002;                                  {Datei listen}
  cmPara       = 1003;                              {Parameter �ndern}
  cmErrorBox   = 1004;                            {Error-Box anzeigen}
  cmWarningBox = 1005;                          {Warning-Box anzeigen}
  cmInputBox   = 1006;                             {Info-Box anzeigen}

  ListName: PathStr = '';                        {Name der List-Datei}

type {�������������������������������������������Globale Datentypen��}
  TBspApp = object (TApplication)
    procedure InitStatusLine; virtual;
    procedure InitMenuBar; virtual;
    procedure OutOfMemory; virtual;
    procedure About;
    procedure ErrorBox;
    procedure WarningBox;
    procedure EingabeBox;
    procedure ListFile;
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
      NewItem('~E~rror-Box','',kbNoKey,cmErrorBox,hcNoContext,
      NewItem('~W~arning-Box','',kbNoKey,cmWarningBox,hcNoContext,
      NewItem('~I~nput-Box','',kbNoKey,cmInputBox,hcNoContext,
      NewLine(
      NewItem('~B~eenden','Alt-X',kbAltX,cmQuit,hcNoContext,
      nil))))))))),
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
 � Gibt in einem Dialogfenster �ber die Routine MessageBox aus der  �
 � Unit MsgBox eine Copyright-Meldung aus.                          �
 ��������������������������������������������������������������������}
procedure TBspApp.About;
const
  Msg = ^C'Das gro�e Buch zu Turbo Pascal 7.0'#13 +
        ^C'Copyright (C) 1992 by'#13 +
        ^C'DATA Becker - D�sseldorf';

begin
  MessageBox(Msg,nil,mfInformation + mfOkButton);
end; {TBspApp.About}
{������������������������������������������������������������������Ŀ
 � TBspApp.ErrorBox                                                 �
 ������������������������������������������������������������������Ĵ
 � Gibt eine Error-Box auf dem Bildschirm aus.                      �
 ��������������������������������������������������������������������}
procedure TBspApp.ErrorBox;
begin
  MessageBox('Operation kann nicht ausgef�hrt werden!',nil,
             mfError + mfOKButton);
end; {TBspApp.ErrorBox}
{������������������������������������������������������������������Ŀ
 � TBspApp.WarningBox                                               �
 ������������������������������������������������������������������Ĵ
 � Gibt eine Warning-Box auf dem Bildschirm aus.                    �
 ��������������������������������������������������������������������}
procedure TBspApp.WarningBox;
var
  Erg: word;                                   {Ergebnis der Funktion}
  s: string;                                            {Neue Meldung}

begin
  Erg:= MessageBox('Datei geht beim L�schen verloren',nil,
             mfWarning + mfYesNoCancel);
  case Erg of
    cmYes   : s:= ^C'Sie haben mit [Yes] geantwortet.';
    cmNo    : s:= ^C'Sie haben mit [No] geantwortet.';
    cmCancel: s:= ^C'Sie haben den Dialog abgebrochen.';
  end; {case}
  MessageBox(s,nil,mfInformation + mfOKButton);
end; {TBspApp.WarningBox}
{������������������������������������������������������������������Ŀ
 � TBspApp.EingabeBox                                               �
 ������������������������������������������������������������������Ĵ
 � Gibt eine Eingabe-Box auf dem Bildschirm aus.                    �
 ��������������������������������������������������������������������}
procedure TBspApp.EingabeBox;
var
  Erg: word;                                   {Ergebnis der Funktion}
  s  : string;                                  {Der eingegebene Text}

begin
  s:= '';                                             {Initialisieren}
  Erg:= InputBox('Input','Name',s,15);
  if Erg <> cmCancel
   then MessageBox('Der Name lautet: ' + s,nil,
               mfInformation + mfOKButton);
end; {TBspApp.EingabeBox}
{������������������������������������������������������������������Ŀ
 � TBspApp.ListFile                                                 �
 ������������������������������������������������������������������Ĵ
 � Ermittelt den Dateinamen der zu listenden Datei �ber eine File-  �
 � Box aus der Unit StdDlg.                                         �
 ��������������������������������������������������������������������}
procedure TBspApp.ListFile;
var
  D: PFileDialog;                                {Zeiger f�r File-Box}
  s: PathStr;                                              {Dateiname}

begin
  D:= New(PFileDialog,Init('*.pas','List-Datei ausw�hlen',
          '~D~ateiname',fdOkButton,1));
  if ValidView(D) <> nil then
  begin
    if Desktop^.ExecView(D) <> cmCancel then
    begin
      D^.GetFileName(s);
      ListName:= s;
    end;
    Dispose(D,Done);
  end;
end; {TBspApp.FileList}
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
      cmList : ListFile;
      cmPara : NewParameter;
      cmErrorBox: ErrorBox;
      cmWarningBox: WarningBox;
      cmInputBox: EingabeBox;
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