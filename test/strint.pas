{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                    Demoprogramm (Unit _Tools)                    �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������ͼ}
Program StringInteger; {StrInt.pas}
uses Crt,_Tools;
var
  Input: _Str;
  Zahl : integer;

begin
  repeat
    ClrScr;
    write('Gib eine Zahl ein (0 = Ende): ');
    readln(Input); writeln;
    Zahl:= _StrToInteger(Input);
    if _UOk
    then begin
           writeln('Eingabe als String: ',Input);
           writeln('Eingabe als Zahl  : ',Zahl:6);
         end
    else begin
           _SignalTon;
           writeln('Keine Integerzahl!');
         end;
    readln;
  until _UOk and (Zahl = 0);
end.