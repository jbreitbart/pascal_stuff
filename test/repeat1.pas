{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demonstriert eine Repeat-Schleife (als Gegenst�ck zu Endlos1.pas)�
 ������������������������������������������������������������������ͼ}
Program RepeatSchleife;                           {Datei: Repeat1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var x: real;

begin
  ClrScr;
  writeln('Demonstration: Repeatschleife');
  x:= 0.0;
  repeat
    x:= x + 0.01;
    GotoXY(30,12);
    write('Wert: ',x:10:2);
  until x > 100.0;
  GotoXY(1,24);
  write('Abbruchbedingung erf�llt! [Return] dr�cken...');
  readln;
end.
