{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 12.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Demo zu ReadLn: Alter berechnen.                                 �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Eingabe陳}
  write('Gib Deinen Vor- und Nachnamen ein: ');
  readln(Name);
  write('Wie alt bist Du (in Jahren)?       ');
  readln(Alter);
  writeln;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Berechnung陳}
  Tage:= Alter * 365;
  Stunden := Tage * 24;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Ausgabe陳}
  writeln(Name,', Du bist ',Alter,' Jahre alt, ');
  writeln('bzw. ',Tage,' Tage bzw. ',Stunden,' Stunden.');

  readln;                                        {Auf [Return] warten}
end.