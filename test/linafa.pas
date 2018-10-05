{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Lineare Abschreibung: Berechnet die lineare Abschreibung und     �
 � gibt sie als Tabelle auf dem Bildschirm aus. Einzugeben sind das �
 � Anschaffungsjahr, der Anschaffungswert und die gesamte Nutzungs- �
 � dauer.                                                           �
 ������������������������������������������������������������������ͼ}
Program LineareAfA;                                {Datei: LinAfA.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Jahr, NDauer: integer;
  AWert, Restwert, AfA: real;

begin
  ClrScr;
  writeln(' ':30,'Abschreibungstabelle');
  writeln;

  {�����������������������������������������������Eingabe der Werte��}
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

  {�����������������������������������������������Tabelle ausf�llen��}
  while Restwert > AfA do
  begin
    Restwert:= Restwert - AfA;
    writeln(Jahr:6,AfA:13:2,Restwert:17:2);
    Inc(Jahr);
  end;

  {�������������������������������������������������Erinnerungswert��}
  AfA:= AfA - 1;
  Restwert:= Restwert - AfA;
  writeln(Jahr:6,AfA:13:2,Restwert:17:2);

  readln;                                        {Auf [Return] warten}
end.