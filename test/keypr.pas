{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 27.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Keypressed: Einfache Demonstration.                              �
 ������������������������������������������������������������������ͼ}
Program EinfachesKeypressed;                        {Datei: Keypr.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Zufall: word;                                          {Zufallszahl}
  ch: char;                                              {Tastendruck}

begin
  ClrScr;

  Randomize;                  {Zufallszahlen-Generator initialisieren}

  repeat {�������������������Wiederholung, bis Taste gedr�ckt wurde��}
    Zufall:= Random(101);
    write(Zufall:5);
  until keypressed;
  ch:= Readkey;
  writeln;

  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.