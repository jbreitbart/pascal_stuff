{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 19.10.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Include-Dateien: Vollstndiges Beispielprogramm.                 บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program Beispielprogramm;                        {Datei: IncTest1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Sternchen,LenLinie: integer;

{$I Diverse.Inc}           { <-- Neu eingefgte Zeile (Include-Datei)}

begin {Hauptprogramm}
  ClrScr;
  writeln('Beispielprogramm fr Include-Dateien');
  writeln;

  write('Anzahl der Sternchen: ');
  readln(Sternchen);
  write('Lnge der Linie     : ');
  readln(LenLinie);

  GotoXY(1,10); Sterne(Sternchen);
  GotoXY(1,15); Linien(LenLinie);

  Warten;
end.