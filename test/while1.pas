{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Demonstriert eine While-Schleife (als Gegenst�ck zu Endlos2.pas).�
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program WhileSchleife;                             {Datei: While1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var x: real;

begin
  ClrScr;
  writeln('Demonstration: Endlosschleife (Abbruch mit [Strg] ',
          '+ [Untbr])');
  x:= 0.0;
  while x <= 100.0 do
  begin
    x:= x + 0.01;
    GotoXY(30,12);
    write('Wert: ',x:10:3);
  end;
  GotoXY(1,24);
  write('Abbruchbedingung erf�llt! [Return] dr�cken...');
  readln;
end.
