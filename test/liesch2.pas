{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Funktionen: Zeichen einlesen.                                    �
 ������������������������������������������������������������������ͼ}
Program ZeichenEinlesen2;                         {Datei: LiesCh2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Zeichen: char;                                {Eingelesenes Zeichen}

{������������������������������������������������������������������Ŀ
 � LiesZeichen2                                                     �
 ������������������������������������������������������������������Ĵ
 � Spalte und Zeile werden als Wertparameter �bergeben.             �
 ��������������������������������������������������������������������}
function LiesZeichen2(Spalte,Zeile: byte): char;
begin
  GotoXY(Spalte,Zeile);
  write('Bitte ein Zeichen eingeben: ');
  LiesZeichen2:= Readkey;
  GotoXY(Spalte,Zeile);
  ClrEol;                                              {Zeile l�schen}
end; {LiesZeichen2}
{������������������������������������������������������������������Ŀ
 � Warten                                                           �
 ������������������������������������������������������������������Ĵ
 � Wartet auf einen beliebigen Tastendruck.                         �
 ��������������������������������������������������������������������}
procedure Warten(Spalte,Zeile: byte);
var ch: char;
begin
  GotoXY(Spalte,Zeile);
  write('Bitte eine Taste dr�cken...');
  ch:= Readkey;
end; {Warten}
{��������������������������������������������������������������������}

begin
  repeat
    ClrScr;
    writeln('Zeicheneingabe (Ende = "e" oder "E")');
    Zeichen:= LiesZeichen2(1,5);
    GotoXY(5,10);
    write('Eingegeben wurde folgendes Zeichen: ',Zeichen);
    Warten(1,25);
  until Zeichen in ['E','e'];
end.