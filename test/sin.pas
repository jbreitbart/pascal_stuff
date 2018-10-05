{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Prozeduren: Zeichnet eine Sinuskurve.                            �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program SinusKurve;                                   {Datei: Sin.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Zeichen = '*';                        {Zum Zeichnen des Bildpunktes}

var
  x,y: real;                                  {Bildschirm-Koordinaten}
  i: integer;                                           {Z�hlvariable}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � XAchse                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Zeichnet die X-Achse.                                            �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure XAchse;
var i: integer;                                         {Z�hlvariable}
begin
  GotoXY(1,13);
  for i:= 1 to 80 do
    write(chr(196));
end; {XAchse}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � YAchse                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Zeichnet die Y-Achse.                                            �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure YAchse;
var i: integer;                                         {Z�hlvariable}
begin
  for i:= 1 to 25 do
  begin
    GotoXY(33,i);
    write(chr(179));
    GotoXY(33,13);
    write(chr(197));                        {Zeichen f�r den Ursprung}
  end; {for}
end; {YAchse}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Kurve                                                            �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Zeichnet die Sinuskurve auf den Bildschirm.                      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Kurve(x1,y1: real; Zeichen: char);
var b1,b: integer;
begin
  y1:= -y1;                                               {Skalierung}
  b1:= round(((x1+3.2) * 10)) + 2;                 {Spaltenberechnung}
  b:= round((y1 * 10)) + 13;                        {Zeilenberechnung}
  GotoXY(b1,b);                                        {Positionieren}
  write(Zeichen);
end; {Kurve}
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

begin {Hauptprogramm}
  ClrScr;
  GotoXY(35,1);
  write('S I N U S - Kurve');

  XAchse;                                           {X-Achse zeichnen}
  YAchse;                                           {Y-Achse zeichnen}
  x:= -3.3;                                                {Startwert}

  for i:= 1 to 660 do
  begin
    x:= x + 0.01;                                   {X-Wert berechnen}
    y:= Sin(x);                                     {Y-Wert berechnen}
    Kurve(x,y,Zeichen);
  end; {for}

  XAchse;                                           {X-Achse erneuern}
  YAchse;                                           {Y-Achse erneuern}
  Warten(1,25);
end.