{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 27.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Keypressed: Einfache Demonstration.                              �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program EinfachesKeypressed;                        {Datei: Keypr.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Zufall: word;                                          {Zufallszahl}
  ch: char;                                              {Tastendruck}

begin
  ClrScr;

  Randomize;                  {Zufallszahlen-Generator initialisieren}

  repeat {陳陳陳陳陳陳陳陳陳�Wiederholung, bis Taste gedr�ckt wurde陳}
    Zufall:= Random(101);
    write(Zufall:5);
  until keypressed;
  ch:= Readkey;
  writeln;

  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.