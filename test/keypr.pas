{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 27.09.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Keypressed: Einfache Demonstration.                              บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program EinfachesKeypressed;                        {Datei: Keypr.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Zufall: word;                                          {Zufallszahl}
  ch: char;                                              {Tastendruck}

begin
  ClrScr;

  Randomize;                  {Zufallszahlen-Generator initialisieren}

  repeat {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤWiederholung, bis Taste gedrckt wurdeฤฤ}
    Zufall:= Random(101);
    write(Zufall:5);
  until keypressed;
  ch:= Readkey;
  writeln;

  write('Bitte [Return] drcken...');
  readln;                                        {Auf [Return] warten}
end.