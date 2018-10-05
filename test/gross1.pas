{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Wandelt alle Zeichen eines Satzes in Groแbuchstaben um.          บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program  Grossbuchstaben;                          {Datei: Gross1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Satz: string[60];                               {Einzugebender Satz}
  i: integer;                                           {Laufvariable}

begin
  ClrScr;
  writeln('Gib einen Satz (max. 60 Zeichen) ein:');
  writeln;
  readln(Satz);                                        {Satz einlesen}
  writeln;

  for i:= 1 to Length(Satz) do     {Kleinbuchstaben in Groแbuchstaben}
   Satz[i]:= Upcase(Satz[i]);

  writeln(Satz);                         {Konvertierten Satz ausgeben}
  writeln;
  writeln('Das (',#24,') ist der Satz in Groแbuchstaben!');
  readln;                                        {Auf [Return] warten}
end.