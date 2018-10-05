{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                     Turbo Vision-Demoprogramm                    �
 �                 Autor: Reiner Sch�lles, 25.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Programmlister.                                                  �
 ������������������������������������������������������������������ͼ}
{                     Inhalt und Hinweise

   Das Programm Lister.pas basiert auf TVDemo24.pas und erg�nzt
   dieses um solche Routinen, die nicht zum Verst�ndnis von Turbo
   Vision beitragen, aber zum Ausdrucken von Pascal-Dateien not-
   wendig sind.

   Das Programm stellt einen einfachen Programmlister dar. Die Aus-
   stattung ist nicht so komfortabel, wie man sich das von einem
   LISTER w�nschen w�rde. Es sollten aber auch nur die prinzipiellen
   M�glichkeiten von Turbo Vision gezeigt werden. Das Programm be-
   n�tigt die Unit ListTpu.pas. Lesen Sie auch die Hinweise in
   dieser Datei.
 ��������������������������������������������������������������������}

Program ProgrammLister;                            {Datei: Lister.pas}
{$X+}                                 {Erweiterte Syntax (Funktionen)}
{$M 16384,8192,655360}
uses {�����������������������������������Einzubindende Bibliotheken��}
  Dos,App,Objects,Menus,Drivers,
  Views,Dialogs,MsgBox,StdDlg,Memory,    {Bibliothek aus Turbo Pascal}
  ListTpu;                                            {Unit zu Lister}

type {�������������������������������������������Globale Datentypen��}
  TBspApp = object (TApplication)
    procedure InitStatusLine; virtual;
    procedure InitMenuBar; virtual;
    procedure OutOfMemory; virtual;
    procedure About;
    procedure ListFile;
    procedure ChangeDir;
    procedure DosShell;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure NewParameter;
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
      NewItem('~D~OS shell','',kbNoKey,cmDosShell,hcNoContext,
      NewLine(
      NewItem('~B~eenden','Alt-X',kbAltX,cmQuit,hcNoContext,
      nil))))),
    NewSubMenu('~F~ile',hcNoContext,NewMenu(
      NewItem('~L~ist','F2',kbF2,cmList,hcNoContext,
      NewItem('~P~arameter','',kbNoKey,cmPara,hcNoContext,
      NewItem('~C~hange Directory','',kbNoKey,cmChDir,hcNoContext,
      nil)))),
    NewSubMenu('~W~indow',hcNoContext,NewMenu(
      NewItem('~C~lose','Alt-F3',kbAltF3,cmClose,hcNoContext,
      NewItem('~Z~oom','F5',kbF5,cmZoom,hcNoContext,
      NewItem('~R~esize','Ctrl-F5',kbCtrlF5,cmResize,hcNoContext,
      NewItem('N~e~xt','F6',kbF6,cmNext,hcNoContext,
      NewItem('~P~revious','Shift-F6',kbShiftF6,cmPrev,hcNoContext,
      nil)))))),
    nil))))
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
      DruckVorgangVorbereiten;
    end;
    Dispose(D,Done);
  end;
end; {TBspApp.FileList}
{������������������������������������������������������������������Ŀ
 � TBspApp.ChangeDir                                                �
 ������������������������������������������������������������������Ĵ
 � Wechselt das Laufwerk �ber eine ChangeDir-Box.                   �
 ��������������������������������������������������������������������}
procedure TBspApp.ChangeDir;
var
  D: PChDirDialog;                                      {Dialogobjekt}

begin
  D:= New(PChDirDialog,Init(cdNormal,2));
  if ValidView(D) <> nil then
  begin
    DeskTop^.ExecView(D);
    Dispose(D,done);
  end;
end; {TBspApp.ChangeDir}
{������������������������������������������������������������������Ŀ
 � TBspApp.DosShell                                                 �
 ������������������������������������������������������������������Ĵ
 � Wechselt auf die DOS-Ebene.                                      �
 ��������������������������������������������������������������������}
procedure TBspApp.DosShell;
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
end; {TBspApp.DosShell}
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
      cmChDir: ChangeDir;
      cmDosShell: DosShell;
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
    DruckData:= 15;                           {Alle Optionen markiert}
    SchriftData:= 0;                                   {Normalschrift}
    HinweisData:= HinweisStr;
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