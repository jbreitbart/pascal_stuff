{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Liest drei Zahlen �ber Tastatur ein, addiert sie und gibt die    �
 � Summe auf dem Bildschirm aus.                                    �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Addition;                                {Datei: Addition.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Summe,x: real;                               {x = einzulesende Zahl}

begin
  ClrScr;
  Summe:= 0;                      {Initialisieren und auf Null setzen}
  writeln('Addition von drei Zahlen');
  writeln;
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳1. Zahl einlesen und Summe berechnen陳}
  write('1. Zahl eingeben: ');
  readln(x);
  Summe:= Summe + x;
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳2. Zahl einlesen und Summe berechnen陳}
  write('2. Zahl eingeben: ');
  readln(x);
  Summe:= Summe + x;
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳3. Zahl einlesen und Summe berechnen陳}
  write('3. Zahl eingeben: ');
  readln(x);
  Summe:= Summe + x;
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Summe ausgeben und Programm beenden陳}
  writeln;
  writeln('Die Summe der drei Zahlen betr�gt: ',Summe:6:2);
  readln;                                        {Auf [Return] warten}
end.