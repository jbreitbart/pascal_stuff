{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                    Demoprogramm (Unit _Tools)                    �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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