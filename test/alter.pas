{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 12.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demo zu ReadLn: Alter berechnen.                                 �
 ������������������������������������������������������������������ͼ}
Program AlterBerechnen;                             {Datei: Alter.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Name: string;                                    {Vor- und Nachname}
  Alter,                                             {Alter in Jahren}
  Tage,Stunden: LongInt;                                {Alter in ...}

begin
  ClrScr;
  writeln('Alter berechnen');
  writeln;

  {���������������������������������������������������������Eingabe��}
  write('Gib Deinen Vor- und Nachnamen ein: ');
  readln(Name);
  write('Wie alt bist Du (in Jahren)?       ');
  readln(Alter);
  writeln;

  {������������������������������������������������������Berechnung��}
  Tage:= Alter * 365;
  Stunden := Tage * 24;

  {���������������������������������������������������������Ausgabe��}
  writeln(Name,', Du bist ',Alter,' Jahre alt, ');
  writeln('bzw. ',Tage,' Tage bzw. ',Stunden,' Stunden.');

  readln;                                        {Auf [Return] warten}
end.