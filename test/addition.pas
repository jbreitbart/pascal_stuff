{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Liest drei Zahlen �ber Tastatur ein, addiert sie und gibt die    �
 � Summe auf dem Bildschirm aus.                                    �
 ������������������������������������������������������������������ͼ}
Program Addition;                                {Datei: Addition.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Summe,x: real;                               {x = einzulesende Zahl}

begin
  ClrScr;
  Summe:= 0;                      {Initialisieren und auf Null setzen}
  writeln('Addition von drei Zahlen');
  writeln;
  {����������������������������1. Zahl einlesen und Summe berechnen��}
  write('1. Zahl eingeben: ');
  readln(x);
  Summe:= Summe + x;
  {����������������������������2. Zahl einlesen und Summe berechnen��}
  write('2. Zahl eingeben: ');
  readln(x);
  Summe:= Summe + x;
  {����������������������������3. Zahl einlesen und Summe berechnen��}
  write('3. Zahl eingeben: ');
  readln(x);
  Summe:= Summe + x;
  {�����������������������������Summe ausgeben und Programm beenden��}
  writeln;
  writeln('Die Summe der drei Zahlen betr�gt: ',Summe:6:2);
  readln;                                        {Auf [Return] warten}
end.