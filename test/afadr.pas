{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Degressive Abschreibung: Berechnet die degressive Abschreibung   �
 � und gibt sie als Tabelle auf dem Bildschirm aus. Einzugeben sind �
 � das Anschaffungsjahr, der Anschaffungswert und der Abschreibungs-�
 � satz (in %).                                                     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program DegressiveAfaDrucker;                       {Datei: AfaDr.pas}
uses Crt, Printer;                       {Bibliothek aus Turbo Pascal}
var
  Jahr: integer;
  AWert, Restwert, AfA, Satz: real;

begin
  ClrScr;
  writeln(lst,' ':30,'Abschreibungstabelle');
  writeln(lst);

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Eingabe der Werte陳}
  writeln('Bitte geben Sie ein: ');
  writeln;
  write('Anschaffungsjahr:  '); readln(Jahr);
  write('Anschaffungswert:  '); readln(AWert);
  write('Abschreibungssatz: '); readln(Satz);
  writeln;

  writeln(lst,'  Jahr       Aw/Rw          AfA            Restwert');
  writeln(lst,'---------------------------------------------------');

  Restwert:= AWert;
  AfA:= (Restwert/100) * Satz;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Tabelle ausf�llen陳}
  while (Restwert - AfA) > 1 do
  begin
    Restwert:= Restwert - AfA;
    writeln(lst,Jahr:6,AWert:13:2,AfA:14:2,Restwert:18:2);
    AWert:= Restwert;
    Inc(Jahr);
    AfA:= (Restwert/100) * Satz;
  end;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Erinnerungswert陳}
  AfA:= Restwert - 1;
  Restwert:= Restwert - AfA;
  writeln(lst,Jahr:6,AWert:13:2,AfA:14:2,Restwert:18:2);

  readln;                                        {Auf [Return] warten}
end.