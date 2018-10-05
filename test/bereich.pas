{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                    Demoprogramm (Unit _Tools)                    บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program Zahlenbereich; {Bereich.pas}
uses Crt,_Tools;
var
  Min,Max,Zahl: real;

begin
  Min:= 3.0; Max:= 9.0;
  repeat
    ClrScr;
    writeln('Ende: Zahl = 0');
    writeln;
    write('Gib eine Zahl ein: ');
    readln(Zahl); writeln;
    writeln('Min = ',Min:6:2);
    writeln('Max = ',Max:6:2);
    writeln;
    write('Zahl liegt ');
    if _RealRange(Min,Max,Zahl)
     then write('innerhalb ')
     else write('auแerhalb ');
    write('des gltigen Bereichs!');
    readln;
  until Zahl = 0;
  ClrScr;
end.