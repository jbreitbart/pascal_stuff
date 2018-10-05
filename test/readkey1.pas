{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 18.09.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Demoprogramm zu Readkey: Liest von der Tastatur ein Zeichen ohne บ
 บ Echo.                                                            บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program ZeichenOhneEcho;                         {Datei: Readkey1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  ch: char;                                              {Ein Zeichen}

begin
  ClrScr;
  writeln('Zeichen ohne Echo lesen');
  writeln;

  write('Bitte drcken Sie ein beliebiges Zeichen auf ');
  write('der Tastatur: ');
  ch:= Readkey;
  writeln; writeln;

  writeln('Sie haben das Zeichen [',ch,'] gedrckt!');

  readln;                                        {Auf [Return] warten}
end.