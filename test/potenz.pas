{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Berechnet die zweite und dritte Potenz von a.                    บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program Potenzen;                                  {Datei: Potenz.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Grenze = 15;

var
  i,                                   {Zhlvariable fr Unterstriche}
  a,a2,a3: integer;                        {Zahl a und deren Potenzen}

begin
  ClrScr;
  writeln(' ':33,'Potenzen von a');
  writeln(' ':33,'==============');
  writeln;

  {--------------------------------------------Tabellen-berschrift--}
  writeln(' ':19,'a',' ':17,'a'+chr(24)+'2',' ':17,'a'+chr(24)+'3');
  write(' ':19);
  for i:= 0 to 40 do write('-');          {berschrift unterstreichen}
  writeln;

  for a:= 1 to Grenze do
  begin
    a2:= a * a;                        {Zweite Potenz von a berechnen}
    a3:= a * a * a;                    {Dritte Potenz von a berechnen}
    writeln(a:20,a2:20,a3:20);                     {Bildschirmausgabe}
  end; {for}
  readln;                                        {Auf [Return] warten}
end.