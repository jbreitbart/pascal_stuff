{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 05.10.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Datentyp Boolean.                                                บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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