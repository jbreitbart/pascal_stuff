{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Zeigt die Gleichheit zweier unterschiedlich formulierter Be-     �
 � dingungen.                                                       �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program GleicheBedingungen;                      {Datei: Negation.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var x: integer;

begin
  ClrScr;
  writeln(' ':25,'Gleichheit zweier Bedingungen');
  writeln;
  write('Gib einen Integer-Wert ein: ');
  readln(x);
  writeln;

  if not (x > -5) then writeln('Die Bedingung ist erf�llt!')
                  else writeln('Die Bedingung ist nicht erf�llt!');

  if (x <= -5) then writeln('Die Bedingung ist erf�llt!')
               else writeln('Die Bedingung ist nicht erf�llt!');

  readln;                                        {Auf [Return] warten}
end.