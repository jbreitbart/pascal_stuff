{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 05.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Addiert (verkn�pft) zwei Zeichenketten mit dem [+]-Zeichen.      �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program AddString;                                 {Datei: AddStr.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Name,Vorname,Nachname: string;

begin
  ClrScr;
  writeln('Addition (Verkettung zweier Zeichenketten.');
  writeln;

  write('Geben Sie Ihren Vornamen ein : ');
  readln(Vorname);
  write('Geben Sie Ihren Nachnamen ein: ');
  readln(Nachname);
  writeln;

  Name:= Vorname + ' ' + Nachname;

  write('Sie hei�en ',Name);

  readln;                                        {Auf [Return] warten}
end.