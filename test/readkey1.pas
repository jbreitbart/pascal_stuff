{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 18.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Demoprogramm zu Readkey: Liest von der Tastatur ein Zeichen ohne �
 � Echo.                                                            �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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