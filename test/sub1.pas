{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 05.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Eingangsbeispiel f�r Unterprogramme.                             �
 ������������������������������������������������������������������ͼ}
Program BspUnterprogramme;                           {Datei: Sub1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'Klaus Wunder';
  Strasse =  'Bahnhofstr. 123';
  Ort = '2800 Bremen 1';

begin
  ClrScr;
  writeln('Name:   ',Name);

  GotoXY(1,25);
  write('Zur Fortsetzung bitte [Return] dr�cken...');
  readln;
  ClrScr;

  writeln('Stra�e: ',Strasse);

  GotoXY(1,25);
  write('Zur Fortsetzung bitte [Return] dr�cken...');
  readln;
  ClrScr;

  writeln('Ort:    ',Ort);

  GotoXY(1,25);
  write('Zur Fortsetzung bitte [Return] dr�cken...');
  readln;
  ClrScr;
end.