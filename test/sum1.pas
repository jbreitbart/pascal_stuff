{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 19.10.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Prozeduren: Berechnet die Summe zweier Zahlen.                   บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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