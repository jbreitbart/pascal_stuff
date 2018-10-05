{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Funktionen: Zeichen einlesen, Ergebnis Boolean.                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program LiesBuchstabe;                             {Datei: FuncCh.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Ok: boolean;                                     {Funktionsergebnis}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Buchstabe                                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Liest ein Zeichen �ber die Tastatur ein und liefert als Ergebnis �
 � den Wert True, wenn es ein Buchstabe war, sonst das Ergebnis     �
 � False.                                                           �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
function Buchstabe: boolean;
var ch: char;                                   {Eingelesenes Zeichen}
begin
  GotoXY(1,5);
  write('Bitte ein Zeichen eingeben: ');
  ch:= Upcase(Readkey);
  if ch in ['A'..'Z']
    then Buchstabe:= true
    else Buchstabe:= false;
  GotoXY(1,5);
  ClrEol;                                              {Zeile l�schen}
end; {Buchstabe}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Warten                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Wartet auf einen beliebigen Tastendruck.                         �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Warten;
var ch: char;
begin
  GotoXY(1,25);
  write('Bitte eine Taste dr�cken...');
  ch:= Readkey;
end; {Warten}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

begin
  repeat
    ClrScr;
    writeln('Zeicheneingabe (Ende: K e i n  Buchstabe!)');
    Ok:= Buchstabe;
    GotoXY(5,10);
    if Ok
      then write('Es wurde ein Buchstabe eingegeben.')
      else write('Es wurde kein Buchstabe eingegeben.');
    Warten;
  until not Ok;
end.