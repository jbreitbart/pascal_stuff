{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 28.09.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Zeigt die Verwendung der Datentypen Single, Double und Extended  º
 º in Verbindung mit einem mathematischen Co-Prozessor bzw. der     º
 º Emulation eines solchen.                                         º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program MathCoProzessor;                           {Datei: Co8087.pas}
{$N+}                 {Compiler-Schalter: Erweiterte Flieákomma-Typen}
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
  writeln('Flieákommaoperationen mit dem Co-Prozessor');
  writeln;
  writeln('Testzahl: T = ',T);
  writeln;
  writeln('Berechnet wird T * T');
  writeln;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄBerechnungÄÄ}
  r:= T * T;
  s:= T * T;
  d:= T * T;
  e:= T * T;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄAusgabeÄÄ}
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