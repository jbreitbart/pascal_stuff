{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                     Turbo Vision-Demoprogramm                    �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Demoprogramm zu Turbo Vision.                                    �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program TVDemo14;                                {Datei: TVDemo14.pas}
uses {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Einzubindende Bibliotheken陳}
  App,Objects,Menus,Drivers,
  Views,Dialogs;                         {Bibliothek aus Turbo Pascal}

const {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Globale Konstanten陳}
  cmAbout = 1001;                                 {Copyright anzeigen}
  cmList  = 1002;                                       {Datei listen}
  cmPara  = 1003;                                   {Parameter �ndern}

type {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Globale Datentypen陳}
  TBspApp = object (TApplication)
    procedure InitStatusLine; virtual;
    procedure InitMenuBar; virtual;
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

var {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Globale Variablen陳}
  BspApp: TBspApp;
  ParaData: ParaDataRec;                           {F�r die Dialogbox}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TBspApp.IntiStatusLine                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Initialisiert eine neue Statuszeile und �berschreibt damit die   �
 � von TProgram.InitStatusLine.                                     �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TBspApp.IntitMenuBar                                             �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Initialisiert eine neue Men�leiste und �berschreibt damit die    �
 � von TProgram.InitMenuBar.                                        �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TBspApp.HandleEvent                                              �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Stellt f�r den oben genannten Objekttyp einen Event-Handler zur  �
 � Verf�gung.                                                       �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure TBspApp.HandleEvent(var Event: TEvent);
begin
  TApplication.HandleEvent(Event);
  if Event.What = evCommand then
  begin
    case Event.Command of
      cmAbout: begin end;
      cmList : begin end;
      cmPara : NewParameter;
      else Exit;
    end; {case}
    ClearEvent(Event);
  end; {if}
end; {TBspApp.HandleEvent}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � TBspApp.NewParameter                                             �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � �ffnet eine Dialogbox zur Eingabe neuer Parameter.               �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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
    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�CheckBox installieren陳}
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

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�RadioBox installieren陳}
    R.Assign(21,4,33,6);
    Ptr:= New(PRadioButtons,Init(R,
      NewSItem('~N~ormal',
      NewSItem('~K~lein',
      nil))
    ));
    Insert(Ptr);
    R.Assign(20,3,31,4);
    Insert(New(PLabel,Init(R,'Schriftart',Ptr)));

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Eingabefeld installieren陳}
    R.Assign(3,10,32,11);
    Ptr:= New(PInputLine,Init(R,50));
    Insert(Ptr);
    R.Assign(2,9,10,10);
    Insert(New(PLabel,Init(R,'Hinweis',Ptr)));

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Schalter installieren陳}
    R.Assign(7,12,17,14);
    Insert(New(PButton,Init(R,'~O~K',cmOK,bfDefault)));
    R.Assign(19,12,32,14);
    Insert(New(PButton,Init(R,'Abbruch',cmCancel,bfNormal)));
  end; {with}

  Parameter^.SetData(ParaData);                     {Voreinstellungen}
  Dummy:= DeskTop^.ExecView(Parameter);
  if Dummy <> cmCancel
    then Parameter^.GetData(ParaData);            {Ge�nderte Eintr�ge}
  Dispose(Parameter,Done);                   {Objekt wieder freigeben}
end; {BspApp.NewParameter}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � InitParaDataRec                                                  �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Initialisiert den Daten-Record f�r die Dialogbox.                �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure InitParaDataRec;
begin
  with ParaData do
  begin
    DruckData:= 1;
    SchriftData:= 0;
    HinweisData:= 'Demo-Programm zu Turbo Vision';
  end; {with}
end; {InitParaDataRec}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Hauptprogramm陳}
  InitParaDataRec;                       {Daten-Rekord initialisieren}
  BspApp.Init;
  BspApp.Run;
  BspApp.Done;
end.
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳End of program陳}