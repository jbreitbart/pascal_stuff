{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Prozeduren: Berechnet die Summe zweier Zahlen.                   �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program SummeBerechnen1;                             {Datei: Sum1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a,b,Summe: Integer;

begin
  ClrScr;
  writeln('Summe zweier Zahlen berechnen');
  writeln;

  write('Gib die erste Zahl ein:  ');
  readln(a);
  write('Gib die zweite Zahl ein: ');
  readln(b);
  writeln;

  Summe:= a + b;

  writeln('a + b = ',Summe);

  readln;                                        {Auf [Return] warten}
end.