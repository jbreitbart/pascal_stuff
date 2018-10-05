{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 28.09.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Demonstriert die Ausgabeanweisung WriteLn.                       บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program AusgabeDemo;                              {Datei: Ausgabe.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  T: string;                                            {Textvariable}
  i: integer;                                       {Integer-Variable}
  r: real;                                             {Real-Variable}

begin
  ClrScr;
  T:= 'Demoprogramm zur Ausgabeanweisung';
  i:= 100;                                             {Wertzuweisung}
  r:= 100;                                             {Wertzuweisung}

  writeln(T);                   {Gibt Dateninhalt der Variablen T aus}
  writeln;                                                 {Leerzeile}

  writeln(i);                   {Gibt Dateninhalt der Variablen i aus}
  writeln(r);                   {Gibt Dateninhalt der Variablen r aus}
  writeln;

  writeln('Jetzt wird r formatiert ausgegeben: ',r:7:2);

  writeln;
  write('Bitte [Return] drcken...');
  readln;                                        {Auf [Return] warten}
end.