{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Prozeduren: Zeichen einlesen.                                    �
 ������������������������������������������������������������������ͼ}
Program ZeichenEinlesen;                           {Datei: LiesCh.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Zeichen: char;                                {Eingelesenes Zeichen}

{������������������������������������������������������������������Ŀ
 � LiesZeichen                                                      �
 ������������������������������������������������������������������Ĵ
 � Spalte und Zeile werden als Wertparameter, ch als Variablen-     �
 � parameter �bergeben.                                             �
 ��������������������������������������������������������������������}
procedure LiesZeichen(Spalte,Zeile: byte; var ch: char);
begin
  GotoXY(Spalte,Zeile);
  write('Bitte ein Zeichen eingeben: ');
  ch:= Readkey;
  GotoXY(Spalte,Zeile);
  ClrEol;                                              {Zeile l�schen}
end; {LiesZeichen}
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
    LiesZeichen(1,5,Zeichen);
    GotoXY(5,10);
    write('Eingegeben wurde folgendes Zeichen: ');
    write(Zeichen);
    Warten(1,25);
  until Zeichen in ['E','e'];
end.