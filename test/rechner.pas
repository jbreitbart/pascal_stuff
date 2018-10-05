{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Beispielprogramm zum Einsatz einer Unit.                         º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program Rechner;                                  {Datei: Rechner.pas}
uses
  Crt,                                   {Bibliothek aus Turbo Pascal}
  Rechnen;                                 {Die gerade erstellte Unit}

var
  x1,x2: real;                                {Zwei globale Variablen}

begin {Hauptprogramm}
  repeat

    {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄx1 und x2 einlesenÄÄ}
    write('Gib x1 ein: ');
    readln(x1);
    write('Gib x2 ein: ');
    readln(x2);

    {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄErgebnisse berechnenÄÄ}
    writeln;
    writeln('Ergebnis der Addition:    ',Plus(x1,x2):10:2);
    writeln;
    writeln('Ergebnis der Subtraktion: ',Minus(x1,x2):10:2);
    writeln;

    {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄAbschluáÄÄ}
    write('Zum Abschluá [Return] drcken...');
    readln;
    ClrScr;

  until (x1 = 0) and (x2 = 0);
end.
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄProgrammendeÄÄ}

