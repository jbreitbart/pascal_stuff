{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                     Turbo Vision-Demoprogramm                    �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demoprogramm zu Turbo Vision.                                    �
 ������������������������������������������������������������������ͼ}
Program TVDemo01;                                {Datei: TVDemo01.pas}
uses {�����������������������������������Einzubindende Bibliotheken��}
  App;                                   {Bibliothek aus Turbo Pascal}

type {�������������������������������������������Globale Datentypen��}
  TBspApp = object (TApplication)
    {Noch keine neuen Datenfelder und Methoden}
  end;

var {���������������������������������������������Globale Variablen��}
  BspApp: TBspApp;
 
begin {�����������������������������������������������Hauptprogramm��}
  BspApp.Init;
  BspApp.Run;
  BspApp.Done;
end.
{����������������������������������������������������End of program��}