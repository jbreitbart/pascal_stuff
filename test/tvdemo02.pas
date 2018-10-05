{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                     Turbo Vision-Demoprogramm                    �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demoprogramm zu Turbo Vision.                                    �
 ������������������������������������������������������������������ͼ}
Program TVDemo02;                                {Datei: TVDemo02.pas}
uses {�����������������������������������Einzubindende Bibliotheken��}
  App,Objects,Menus,Drivers,Views;       {Bibliothek aus Turbo Pascal}

type {�������������������������������������������Globale Datentypen��}
  TBspApp = object (TApplication)
    procedure InitStatusLine; virtual;
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
      nil),
    nil)
  ));
end; {TBspApp.InitStatusLine}


var {���������������������������������������������Globale Variablen��}
  BspApp: TBspApp;
 
begin {�����������������������������������������������Hauptprogramm��}
  BspApp.Init;
  BspApp.Run;
  BspApp.Done;
end.
{����������������������������������������������������End of program��}