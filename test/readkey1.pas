{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 18.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demoprogramm zu Readkey: Liest von der Tastatur ein Zeichen ohne �
 � Echo.                                                            �
 ������������������������������������������������������������������ͼ}
Program ZeichenOhneEcho;                         {Datei: Readkey1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  ch: char;                                              {Ein Zeichen}

begin
  ClrScr;
  writeln('Zeichen ohne Echo lesen');
  writeln;

  write('Bitte dr�cken Sie ein beliebiges Zeichen auf ');
  write('der Tastatur: ');
  ch:= Readkey;
  writeln; writeln;

  writeln('Sie haben das Zeichen [',ch,'] gedr�ckt!');

  readln;                                        {Auf [Return] warten}
end.