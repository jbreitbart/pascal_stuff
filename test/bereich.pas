{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                    Demoprogramm (Unit _Tools)                    �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������ͼ}
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
     else write('au�erhalb ');
    write('des g�ltigen Bereichs!');
    readln;
  until Zahl = 0;
  ClrScr;
end.