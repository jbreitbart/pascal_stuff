{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 05.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Datentyp Boolean.                                                �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Wahrheitswerte;                             {Datei: Boole.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Ok: boolean;
  x: integer;

begin
  ClrScr;
  writeln('Demoprogramm zum Datentyp Boolean.');
  writeln;

  write('Ausgabe des Dateninhalts der Variablen Ok: Ok = ');
  Ok:= true;
  writeln(Ok);
  writeln;

  write('Ausgabe des Ergebnisses der Funktion ODD, ');
  write('wenn X = 123 ist: Odd = ');
  X:= 123;
  writeln(Odd(x));

  readln;                                        {Auf [Return] warten}
end.