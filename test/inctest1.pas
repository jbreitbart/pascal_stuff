{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Include-Dateien: Vollst�ndiges Beispielprogramm.                 �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Beispielprogramm;                        {Datei: IncTest1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Sternchen,LenLinie: integer;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Sterne                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Zeichnet eine bestimmte Anzahl von Sternen auf den Bildschirm.   �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Sterne(Anz: integer);
var i: integer;                                         {Z�hlvariable}

begin
  for i:= 1 to Anz do write('*');
end; {Sterne}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Linien                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Zeichnet eine Linie auf den Bildschirm.                          �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Linien(Laenge: integer);
const
  Zeichen = #196;                                      {ASCII-Zeichen}

var
  i: integer;                                           {Z�hlvariable}

begin
  for i:= 1 to Laenge do write(Zeichen);
end; {Linien}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Warten                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Wartet in der 25. Zeile auf einen beliebigen Tastendruck.        �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Warten;
var ch: char;
begin
  GotoXY(1,25);
  write('Bitte eine Taste dr�cken...');
  ch:= Readkey;
end; {Warten}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

begin {Hauptprogramm}
  ClrScr;
  writeln('Beispielprogramm f�r Include-Dateien');
  writeln;

  write('Anzahl der Sternchen: ');
  readln(Sternchen);
  write('L�nge der Linie     : ');
  readln(LenLinie);

  GotoXY(1,10); Sterne(Sternchen);
  GotoXY(1,15); Linien(LenLinie);

  Warten;
end.