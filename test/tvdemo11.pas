{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                     Turbo Vision-Demoprogramm                    �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demoprogramm zu Turbo Vision.                                    �
 ������������������������������������������������������������������ͼ}
Program TVDemo11;                                {Datei: TVDemo11.pas}
uses {�����������������������������������Einzubindende Bibliotheken��}
  App,Objects,Menus,Drivers,
  Views,Dialogs;                         {Bibliothek aus Turbo Pascal}

const {������������������������������������������Globale Konstanten��}
  cmAbout = 1001;                                 {Copyright anzeigen}
  cmList  = 1002;                                       {Datei listen}
  cmPara  = 1003;                                   {Parameter �ndern}

type {�������������������������������������������Globale Datentypen��}
  TBspApp = object (TApplication)
    procedure InitStatusLine; virtual;
    procedure InitMenuBar; virtual;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure NewParameter;
  end;

  PParaDialog = ^TParaDialog;
  TParaDialog = object (TDialog)
  end;

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
      cmAbout: begin end;
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

    {�����������������������������������������Schalter installieren��}
    R.Assign(7,12,17,14);
    Insert(New(PButton,Init(R,'~O~K',cmOK,bfDefault)));
    R.Assign(19,12,32,14);
    Insert(New(PButton,Init(R,'Abbruch',cmCancel,bfNormal)));
  end; {with}

  Dummy:= DeskTop^.ExecView(Parameter);
  Dispose(Parameter,Done);                   {Objekt wieder freigeben}
end; {BspApp.NewParameter}
{��������������������������������������������������������������������}

var {���������������������������������������������Globale Variablen��}
  BspApp: TBspApp;

begin {�����������������������������������������������Hauptprogramm��}
  BspApp.Init;
  BspApp.Run;
  BspApp.Done;
end.
{����������������������������������������������������End of program��}