{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Lineare Abschreibung: Berechnet die lineare Abschreibung und     �
 � gibt sie als Tabelle auf dem Bildschirm aus. Einzugeben sind das �
 � Anschaffungsjahr, der Anschaffungswert und die gesamte Nutzungs- �
 � dauer.                                                           �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program LineareAfA;                                {Datei: LinAfA.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Jahr, NDauer: integer;
  AWert, Restwert, AfA: real;

begin
  ClrScr;
  writeln(' ':30,'Abschreibungstabelle');
  writeln;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Eingabe der Werte陳}
  writeln('Bitte geben Sie ein: ');
  writeln;
  write('Anschaffungsjahr: '); readln(Jahr);
  write('Anschaffungswert: '); readln(AWert);
  write('Nutzungsdauer   : '); readln(NDauer);
  writeln;

  writeln('  Jahr       AfA            Restwert');
  writeln('------------------------------------');

  Restwert:= AWert;
  AfA:= AWert / NDauer;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Tabelle ausf�llen陳}
  while Restwert > AfA do
  begin
    Restwert:= Restwert - AfA;
    writeln(Jahr:6,AfA:13:2,Restwert:17:2);
    Inc(Jahr);
  end;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Erinnerungswert陳}
  AfA:= AfA - 1;
  Restwert:= Restwert - AfA;
  writeln(Jahr:6,AfA:13:2,Restwert:17:2);

  readln;                                        {Auf [Return] warten}
end.