{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Prozeduren: Zeichnet eine Sinuskurve.                            �
 ������������������������������������������������������������������ͼ}
Program SinusKurve;                                   {Datei: Sin.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Zeichen = '*';                        {Zum Zeichnen des Bildpunktes}

var
  x,y: real;                                  {Bildschirm-Koordinaten}
  i: integer;                                           {Z�hlvariable}

{������������������������������������������������������������������Ŀ
 � XAchse                                                           �
 ������������������������������������������������������������������Ĵ
 � Zeichnet die X-Achse.                                            �
 ��������������������������������������������������������������������}
procedure XAchse;
var i: integer;                                         {Z�hlvariable}
begin
  GotoXY(1,13);
  for i:= 1 to 80 do
    write(chr(196));
end; {XAchse}
{������������������������������������������������������������������Ŀ
 � YAchse                                                           �
 ������������������������������������������������������������������Ĵ
 � Zeichnet die Y-Achse.                                            �
 ��������������������������������������������������������������������}
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
{������������������������������������������������������������������Ŀ
 � Kurve                                                            �
 ������������������������������������������������������������������Ĵ
 � Zeichnet die Sinuskurve auf den Bildschirm.                      �
 ��������������������������������������������������������������������}
procedure Kurve(x1,y1: real; Zeichen: char);
var b1,b: integer;
begin
  y1:= -y1;                                               {Skalierung}
  b1:= round(((x1+3.2) * 10)) + 2;                 {Spaltenberechnung}
  b:= round((y1 * 10)) + 13;                        {Zeilenberechnung}
  GotoXY(b1,b);                                        {Positionieren}
  write(Zeichen);
end; {Kurve}
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