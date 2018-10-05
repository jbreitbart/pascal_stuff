{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                     Turbo Vision-Demoprogramm                    �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demoprogramm zu Turbo Vision.                                    �
 ������������������������������������������������������������������ͼ}
Program TVDemo05;                                {Datei: TVDemo05.pas}
uses {�����������������������������������Einzubindende Bibliotheken��}
  App,Objects,Menus,Drivers,Views;       {Bibliothek aus Turbo Pascal}

const {������������������������������������������Globale Konstanten��}
  cmAbout = 1001;                                 {Copyright anzeigen}
  cmList  = 1002;                                       {Datei listen}

type {�������������������������������������������Globale Datentypen��}
  TBspApp = object (TApplication)
    procedure InitStatusLine; virtual;
    procedure InitMenuBar; virtual;
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
      NewStatusKey('~F10~ Men�',kbF10,cmMenu,
      nil)),
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
      NewLine(
      NewItem('~B~eenden','Alt-X',kbAltX,cmQuit,hcNoContext,
      nil)))),
    NewSubMenu('~F~ile',hcNoContext,NewMenu(
      NewItem('~L~ist','F2',kbF2,cmList,hcNoContext,
      nil)),
    nil)))
  ));
end; {TBspApp.InitMenuBar}
{��������������������������������������������������������������������}

var {���������������������������������������������Globale Variablen��}
  BspApp: TBspApp;
 
begin {�����������������������������������������������Hauptprogramm��}
  BspApp.Init;
  BspApp.Run;
  BspApp.Done;
end.
{����������������������������������������������������End of program��}