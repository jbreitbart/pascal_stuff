{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 06.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Ausf�hrung einer Rechenoperation mit Hilfe der CASE-Anweisung.   �
 ������������������������������������������������������������������ͼ}
Program Rechenoperation;                            {Datei: Case2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a,b,Erg: real;
  Operator: char;                                      {Rechenzeichen}

begin
  ClrScr;
  write(' ':5,'Addition, Subtraktion, Multiplikation ');
  writeln('oder Division zweier Zahlen');
  writeln;

  {�����������������������������������������������������Eingabeteil��}
  write('Eingabe der Zahl a:              ');
  readln(a);
  write('Eingabe der Zahl b:              ');
  readln(b);
  write('Eingabe des Operators (+,-,*,/): ');
  readln(Operator);
  writeln;

  {������������������������������������������Berechnung und Ausgabe��}
  if not ( (Operator = '/') and (b = 0) )
    then begin
           case Operator of
             '+': Erg:= a + b;
             '-': Erg:= a - b;
             '*': Erg:= a * b;
             '/': Erg:= a / b;
           end; {case}
           writeln('a ',Operator,' b = ',Erg:10:2);
         end {then}
    else writeln('Division durch Null nicht erlaubt!');

  readln;                                        {Auf [Return] warten}
end.