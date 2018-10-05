{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Liest die Textdatei Text1.txt.                                   �
 ������������������������������������������������������������������ͼ}
Program AusTextdateiLesen;                          {Datei: Text1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'Text1.txt';                                 {Diskettendatei}

var
  f: Text;                                 {Dateivariable im Programm}
  Zeile: string[70];                           {Eine zu lesende Zeile}

begin
  ClrScr;
  writeln('Folgende Datei wird gelesen: ',Name);
  writeln;

  Assign(f,Name);                                  {Dateien verbinden}
  {$I-}                                  {Fehlererkennung ausschalten}
  Reset(f);                                             {Datei �ffnen}
  {$I+}                           {Fehlererkennung wieder einschalten}

  if IOResult = 0 {��������������������������Fehlerfreie Ausf�hrung��}
  then begin
         while not Eof(f) do    {Solange Dateiende nicht erreicht ist}
         begin
           readln(f,Zeile);                              {Zeile lesen}
           writeln(Zeile);            {Zeile auf Bildschirm schreiben}
         end; {while}
         close(f);                            {Datei wieder schlie�en}
       end {then}
  else begin {�������������������������Fehler beim �ffnen der Datei��}
         writeln('Datei nicht gefunden.');
         writeln('Bitte Verzeichnis �berpr�fen!');
       end; {else}

  GotoXY(1,25);
  write('Bitte [Return]-Taste dr�cken...');
  readln;                                        {Auf [Return] warten}
end.