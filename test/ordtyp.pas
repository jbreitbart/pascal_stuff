{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Zeigt die Verwendung selbstdefinierter Datentypen f�r die Lauf-  �
 � variable in einer For-Schleife.                                  �
 ������������������������������������������������������������������ͼ}
Program OrdTyp;                                    {Datei: OrdTyp.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
type
  Farbe = (Rot,Gelb,Gruen);
  KleinInt = 0..10;

var
  Lauf1: Farbe;
  Lauf2: KleinInt;

begin
  ClrScr;

  for Lauf1:= Rot to Gruen do
   writeln('Hier ist Turbo Pascal!');

  writeln;

  for Lauf2:= 0 to 10 do
   writeln('Hier nochmals Turbo Pascal!');
  readln;                                        {Auf [Return] warten}
end.