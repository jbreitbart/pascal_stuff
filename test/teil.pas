{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 05.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Demoprogramm zum Teilbereichstyp.                                �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Teilbereiche;                                {Datei: Teil.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

const
  Null = 0;
  Neun = 9;

type
  Ziffern = Null..Neun;

var
  Zahl: Ziffern;

begin
  ClrScr;
  writeln('Demoprogramm zu Teilbereichstypen');
  writeln;

  Zahl:= 5;
  writeln('Die Ausgangszahl lautet: ',Zahl);
  writeln;
  writeln('Ordnungsnummer:             ',Ord(Zahl));
  writeln('Vorg�nger:                  ',Pred(Zahl));
  writeln('Nachfolger:                 ',Succ(Zahl));

  readln;                                        {Auf [Return] warten}
end.