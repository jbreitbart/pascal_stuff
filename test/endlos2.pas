{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demonstriert eine Endlosschleife (Abbruch mit [Strg]+[Untbr]).   �
 ������������������������������������������������������������������ͼ}
Program EndlosSchleifeWhile;                      {Datei: Endlos2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var x: real;

begin
  ClrScr;
  writeln('Demonstration: Endlosschleife (Abbruch mit [Strg] ',
          '+ [Untbr])');
  x:= 0.0;
  while x <= 0.0 do
  begin
    x:= x - 0.01;
    GotoXY(30,12);
    write('Wert: ',x:10:3);
    if x < -100.0 then x:= 0.0;
  end;
  GotoXY(1,24);
  write('Abbruchbedingung erf�llt! [Return] dr�cken...');
  readln;
end.
