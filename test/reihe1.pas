{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Das Programm berechnet mit Hilfe einer FOR-Schleife die Summe    �
 � einer arithmetischen Reihe mit d = 1. Anfangsglied und die Anzahl�
 � der Glieder m�ssen eingegeben werden. Die Summe wird berechnet   �
 � und ausgegeben.                                                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program ArithReihe1;                               {Datei: Reihe1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

var
  i,a1,n: integer;             {Z�hlvariable,Anfangsglied,Anz.Glieder}
  Summe: real;

begin
  ClrScr;
  Summe:= 0;                                             {Anfangswert}
  writeln('Summe einer arithmetischen Reihe');
  writeln('================================');
  writeln;
  write('Anfangsglied:       '); readln(a1);
  write('Anzahl der Glieder: '); readln(n);
  writeln;

  for i:= a1 to (a1+n-1) do Summe:= Summe + i;            {Berechnung}

  writeln('Summe = ',Summe:7:0);
  readln;                                        {Auf [Return] warten}
end.