{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Ausdr�cke als Austrittsbedingung einer Repeat-Schleife.          �
 ������������������������������������������������������������������ͼ}
Program AustrittsBedingungRepeat;                  {Datei: RepAus.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var ch: char;

begin
  ClrScr;
  write('Wollen Sie drucken (J/N)? ');
  repeat
    write(^G);                                               {Piepton}
    ch:= Upcase(Readkey);
  until (ch = 'J') or (ch = 'N');
  GotoXY(10,20);
  if ch = 'J' then write('Jetzt w�rden Sie drucken...')
              else write('Es wird also nicht gedruckt...');
  readln;                                        {Auf [Return] warten}
end.