{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � 'H�ngt' Text an eine Textdatei an.                               �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program TextAnhaengen;                              {Datei: Text2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'Text1.txt';                                 {Diskettendatei}
  NeueZeile = '***** Neue Zeile *****';

var
  f: Text;                                 {Dateivariable im Programm}

begin
  ClrScr;
  writeln('Folgende Datei wird erg�nzt: ',Name);
  writeln;

  Assign(f,Name);                                  {Dateien verbinden}
  {$I-}                                  {Fehlererkennung ausschalten}
  Append(f);                                            {Datei �ffnen}
  {$I+}                           {Fehlererkennung wieder einschalten}

  if IOResult = 0 {陳陳陳陳陳陳陳陳陳陳陳陳陳Fehlerfreie Ausf�hrung陳}
  then begin
         writeln(f);                                       {Leerzeile}
         writeln(f,NeueZeile);
         close(f);                            {Datei wieder schlie�en}
         writeln('Es wurde erfolgreich in die Datei geschrieben!');
         writeln;
         write('Starten Sie das Programm Text1.pas ');
         writeln('zur �berpr�fung!');
       end {then}
  else begin {陳陳陳陳陳陳陳陳陳陳陳陳�Fehler beim �ffnen der Datei陳}
         writeln('Datei nicht gefunden.');
         writeln('Bitte Verzeichnis �berpr�fen!');
       end; {else}

  GotoXY(1,25);
  write('Bitte [Return]-Taste dr�cken...');
  readln;                                        {Auf [Return] warten}
end.