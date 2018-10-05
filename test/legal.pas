{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 05.10.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Zulssige Zeichen in Zeichenketten.                              บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program ZulaessigeZeichen;                          {Datei: Legal.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

begin
  ClrScr;
  writeln('Steuerzeichen in Zeichenketten');
  writeln;

  writeln('Zeichenkette als Zeichenkette: ','ABC');
  writeln('Jetzt als numerische Werte   : ',#65#66#67);
  writeln;

  write('[Return] drcken, um zweimal den Signalton zu h”ren!');
  readln;
  write(#7#7);
  writeln;

  write('[Return] drcken, um zwei grafische Zeichen zu sehen!');
  readln;
  writeln(#199#197);
  writeln;

  write('Bitte [Return] drcken...');
  readln;
  writeln(#7#7'Es hat geklingelt. Und noch einmal...'^G^G);
  writeln;

  write('Bitte [Return] drcken...');
  readln;
  writeln;

  write('Text in dieser Zeile.'#13#10);
  write('Und jetzt nach einem Wagenrcklauf mit Zeilenvorschub.');
  writeln; writeln;

  write('Bitte [Return] drcken...');
  readln;
  write('Ausgabe eines Apostrophs: ');
  writeln('So geht''s!');
  writeln;

  write('Programm-Ende mit [Return]...');
  readln;                                        {Auf [Return] warten}
end.