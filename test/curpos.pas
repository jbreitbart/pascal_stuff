{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 17.09.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Demoprogramm zur Cursorpositionierung (ClrScr, GotoXY).          บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program CursorPositionierung;                      {Datei: CurPos.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

begin
  ClrScr;
  writeln('Wenn Sie [Return] drcken, wird der Bildschirm ');
  writeln('gel”scht. Anschlieแend werden einige Bildschirm-');
  writeln('punkte gesetzt!');
  readln;
  ClrScr;

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤBildschirmpunkte setzenฤฤ}
  GotoXY(38,1);  write('x '); write('(38,1,)');
  GotoXY(4,3);   write('x '); write('(4,3)');
  GotoXY(62,5);  write('x '); write('(62,5,)');
  GotoXY(7,7);   write('x '); write('(7,7)');
  GotoXY(51,9);  write('x '); write('(51,9)');
  GotoXY(10,12); write('x '); write('(10,12,)');
  GotoXY(1,15);  write('x '); write('(1,15)');
  GotoXY(45,15); write('x '); write('(45,15)');
  GotoXY(70,15); write('x '); write('(70,15)');
  GotoXY(19,22); write('x '); write('(19,22)');

  GotoXY(1,25); write('Bitte [Return] drcken...');
  readln;                                        {Auf [Return] warten}
end.