{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                    Demoprogramm (Unit _Tools)                    �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������ͼ}
Program LeerEntfernen; {LeerEntf.pas}
uses Crt,_Tools;
var St: _Str;
begin
  ClrScr;
  St:= '1 2 3 4 5 6 7 8 9 0';
  writeln('String vorher : ',St);
  writeln('String nachher: ',_AlleLeerzEntf(St));
  readln;
end.