{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Prozeduren: Zeichen einlesen.                                    �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program ZeichenEinlesen;                           {Datei: LiesCh.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Zeichen: char;                                {Eingelesenes Zeichen}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � LiesZeichen                                                      �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Spalte und Zeile werden als Wertparameter, ch als Variablen-     �
 � parameter �bergeben.                                             �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure LiesZeichen(Spalte,Zeile: byte; var ch: char);
begin
  GotoXY(Spalte,Zeile);
  write('Bitte ein Zeichen eingeben: ');
  ch:= Readkey;
  GotoXY(Spalte,Zeile);
  ClrEol;                                              {Zeile l�schen}
end; {LiesZeichen}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Warten                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Wartet auf einen beliebigen Tastendruck.                         �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Warten(Spalte,Zeile: byte);
var ch: char;
begin
  GotoXY(Spalte,Zeile);
  write('Bitte eine Taste dr�cken...');
  ch:= Readkey;
end; {Warten}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

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