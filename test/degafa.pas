{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Degressive Abschreibung: Berechnet die degressive Abschreibung   �
 � und gibt sie als Tabelle auf dem Bildschirm aus. Einzugeben sind �
 � das Anschaffungsjahr, der Anschaffungswert und der Abschreibungs-�
 � satz (in %).                                                     �
 ������������������������������������������������������������������ͼ}
Program DegressiveAfA;                             {Datei: DegAfA.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Jahr: integer;
  AWert, Restwert, AfA, Satz: real;

begin
  ClrScr;
  writeln(' ':30,'Abschreibungstabelle');
  writeln;

  {�����������������������������������������������Eingabe der Werte��}
  writeln('Bitte geben Sie ein: ');
  writeln;
  write('Anschaffungsjahr:  '); readln(Jahr);
  write('Anschaffungswert:  '); readln(AWert);
  write('Abschreibungssatz: '); readln(Satz);
  writeln;

  writeln('  Jahr       Aw/Rw          AfA            Restwert');
  writeln('---------------------------------------------------');

  Restwert:= AWert;
  AfA:= (Restwert/100) * Satz;

  {�����������������������������������������������Tabelle ausf�llen��}
  while (Restwert - AfA) > 1 do
  begin
    Restwert:= Restwert - AfA;
    writeln(Jahr:6,AWert:13:2,AfA:14:2,Restwert:18:2);
    AWert:= Restwert;
    Inc(Jahr);
    AfA:= (Restwert/100) * Satz;
  end;

  {�������������������������������������������������Erinnerungswert��}
  AfA:= Restwert - 1;
  Restwert:= Restwert - AfA;
  writeln(Jahr:6,AWert:13:2,AfA:14:2,Restwert:18:2);

  readln;                                        {Auf [Return] warten}
end.