{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 06.08.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Ausf�hrung einer Rechenoperation mit Hilfe der IF-Anweisung.     �
 � Keine �berzeugende L�sung des Problems! Besser zu l�sen mit der  �
 � CASE-Anweisung.                                                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program RechenoperationMitIf;                       {Datei: Case1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a,b,Erg: real;
  Operator: char;                                      {Rechenzeichen}

begin
  ClrScr;
  write(' ':5,'Addition, Subtraktion, Multiplikation ');
  writeln('oder Division zweier Zahlen');
  writeln;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Eingabeteil陳}
  write('Eingabe der Zahl a:              ');
  readln(a);
  write('Eingabe der Zahl b:              ');
  readln(b);
  write('Eingabe des Operators (+,-,*,/): ');
  readln(Operator);
  writeln;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Berechnung und Ausgabe陳}
  if not ( (Operator = '/') and (b = 0) )
    then begin {1}
           if Operator = '+'
             then Erg:= a + b
             else if Operator = '-'
                    then Erg:= a - b
                    else if Operator = '*'
                           then Erg:= a * b
                           else if Operator = '/'
                                  then Erg:= a / b;
           writeln('a ',Operator,' b = ',Erg:10:2);
         end {then 1}
    else writeln('Division durch Null nicht erlaubt!');

  readln;                                        {Auf [Return] warten}
end.