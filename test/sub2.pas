{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 05.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Hauptprogramm mit einem Unterprogramm.                           �
 ������������������������������������������������������������������ͼ}
Program BspUnterprogramme;                           {Datei: Sub2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'Klaus Wunder';
  Strasse =  'Bahnhofstr. 123';
  Ort = '2800 Bremen 1';

procedure Meldung;
begin
  GotoXY(1,25);
  write('Zur Fortsetzung bitte [Return] dr�cken...');
  readln;
  ClrScr;
end; {Meldung}

begin
  ClrScr;
  writeln('Name:   ',Name);

  Meldung;

  writeln('Stra�e: ',Strasse);

  Meldung;

  writeln('Ort:    ',Ort);

  Meldung;
end.