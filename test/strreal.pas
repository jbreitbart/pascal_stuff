{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                    Demoprogramm (Unit _Tools)                    �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������ͼ}
Program StringReal; {StrReal.pas}
uses Crt,_Tools;
var
  Input: _Str;
  Zahl : real;

begin
  repeat
    ClrScr;
    write('Gib eine Zahl ein (0 = Ende): ');
    readln(Input); writeln;
    Zahl:= _StrToReal(Input);
    if _UOk
    then begin
           writeln('Eingabe als String: ',Input);
           writeln('Eingabe als Zahl  : ',Zahl:10:2);
         end
    else begin
           _SignalTon;
           writeln('Keine Dezimalzahl!');
         end;
    readln;
  until _UOk and (Zahl = 0);
end.