{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 28.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Zeigt die Verwendung der Datentypen Single, Double und Extended  �
 � in Verbindung mit einem mathematischen Co-Prozessor bzw. der     �
 � Emulation eines solchen.                                         �
 ������������������������������������������������������������������ͼ}
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

  {������������������������������������������������������Berechnung��}
  r:= T * T;
  s:= T * T;
  d:= T * T;
  e:= T * T;

  {���������������������������������������������������������Ausgabe��}
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