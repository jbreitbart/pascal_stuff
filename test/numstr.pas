{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                    Demoprogramm (Unit _Tools)                    �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������ͼ}
Program NumToStr; {NumStr.pas}
uses Crt,_Tools;
var Zahl: real;
begin
  repeat
    ClrScr;
    write('Gib eine Zahl ein (0 = Ende): ');
    readln(Zahl); writeln;
    writeln('Als String: ',_NumToStr(Zahl,6,2));
    readln;
  until Zahl = 0;
end.