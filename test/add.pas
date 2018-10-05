{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Addiert mehrere Zahlen mit Hilfe einer Repeat-Schleife. Abbruch  บ
 บ durch Eingabe von 0.                                             บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program ZahlenAddieren;                               {Datei: Add.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  i: integer;                                           {Zhlvariable}
  Summe,Zahl: real;

begin
  ClrScr;
  writeln('Addition mehrerer Zahlen');
  writeln;

  i:= 0; Summe:= 0;                                     {Anfangswerte}

  repeat
    Inc(i);                                      {Zhler um 1 erh”hen}
    write('Gib die ',i,'. Zahl ein (Ende: Zahl = 0): ');
    readln(Zahl);
    Summe:= Summe + Zahl;
  until Zahl = 0;

  writeln; writeln;
  writeln('Summe der ',(i-1),' Zahlen: ',Summe:6:2);
  readln;                                        {Auf [Return] warten}
end.