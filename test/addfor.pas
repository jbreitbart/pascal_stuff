{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Liest drei Zahlen mit Hilfe der For-Schleife �ber Tastatur ein,  �
 � addiert sie und gibt die Summe auf dem Bildschirm aus.           �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program AdditionMitSchleife;                       {Datei: AddFor.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

const
  Anzahl = 3;                        {Anzahl der einzulesenden Zahlen}

var
  i: integer;                                           {Laufvariable}
  Summe,x: real;                               {x = einzulesende Zahl}

begin
  ClrScr;
  Summe:= 0;                      {Initialisieren und auf Null setzen}
  writeln('Addition von drei Zahlen mit der For-Schleife');
  writeln;
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Zahlen einlesen und Summe berechnen陳}
  for i:= 1 to Anzahl do
  begin
    write(i,'. Zahl eingeben: ');
    readln(x);
    Summe:= Summe + x;
  end; {for}
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Summe ausgeben und Programm beenden陳}
  writeln;
  writeln('Die Summe der',i:3,' Zahlen betr�gt: ',Summe:6:2);
  readln;                                        {Auf [Return] warten}
end.