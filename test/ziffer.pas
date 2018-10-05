{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                    Demoprogramm (Unit _Tools)                    บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program Ziffer; {Ziffer.pas}
uses Crt,_Tools;
var ch: char;
begin
  repeat
    ClrScr;
    writeln('Ende: Zeichen = "E"');
    writeln;
    write('Gib ein Zeichen ein: ');
    readln(ch); writeln;
    write('Das Zeichen war ');
    if _Ziffer(ch)
     then writeln('eine Ziffer!')
     else writeln('keine Ziffer!');
    readln;
  until ch in ['e','E'];
  ClrScr;
end.