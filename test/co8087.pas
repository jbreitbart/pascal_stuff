{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 28.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Zeigt die Verwendung der Datentypen Single, Double und Extended  �
 � in Verbindung mit einem mathematischen Co-Prozessor bzw. der     �
 � Emulation eines solchen.                                         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program MathCoProzessor;                           {Datei: Co8087.pas}
{$N+}                 {Compiler-Schalter: Erweiterte Flie�komma-Typen}
{$E+}                               {Routinen des Emulators einbinden}

uses Crt;                                {Bibliothek aus Turbo Pascal}

const
  T = 2.5E-20;                                              {Testzahl}

var
  r: real;                                             {Datentyp Real}
  s: single;                                         {Datentyp Single}
  d: double;                                         {Datentyp Double}
  e: extended;                                     {Datentyp Extended}

begin
  ClrScr;
  writeln('Flie�kommaoperationen mit dem Co-Prozessor');
  writeln;
  writeln('Testzahl: T = ',T);
  writeln;
  writeln('Berechnet wird T * T');
  writeln;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Berechnung陳}
  r:= T * T;
  s:= T * T;
  d:= T * T;
  e:= T * T;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Ausgabe陳}
  writeln('Ergebnis vom Typ Real    : ',r);
  writeln('Ergebnis vom Typ Single  : ',s);
  writeln('Ergebnis vom Typ Double  : ',d);
  writeln('Ergebnis vom Typ Extended: ',e);
  writeln;

  write('Double und Extended sind intern ');
  if d = e
    then writeln('gleich.')
    else writeln('ungleich.');

  readln;                                        {Auf [Return] warten}
end.