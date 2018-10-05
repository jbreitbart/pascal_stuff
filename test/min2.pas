{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 19.10.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Funktionen: Berechnet das Minimum zweier ganzer Zahlen.          บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program Minimum2;                                    {Datei: Min2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a,b,Minimum: Integer;

procedure Ueberschrift;
begin
  ClrScr;
  writeln('Minimum zweier Zahlen berechnen');
  writeln;
end;

procedure Eingabe;
begin
  write('Gib die erste Zahl ein:  ');
  readln(a);
  write('Gib die zweite Zahl ein: ');
  readln(b);
  writeln;
end;

function Min: integer;
begin
  if a <= b then Min:= a
            else Min:= b;
end;

procedure Ausgabe;
begin
  writeln('Die kleinere Zahl lautet: ',Minimum);
end;

begin {Hauptprogramm}
  Ueberschrift;
  Eingabe;
  Minimum:= Min;
  Ausgabe;     

  readln;                                        {Auf [Return] warten}
end.