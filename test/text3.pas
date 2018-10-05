{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Schreibt zwei Zeilen in eine neue Textdatei.                     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program NeueTextdatei;                              {Datei: Text3.pas}
uses
  Crt,                                   {Bibliothek aus Turbo Pascal}
  _Tools;                                       {Unit aus diesem Buch}

const
  Name = 'Text2.txt';                                 {Diskettendatei}

var
  f: Text;                                 {Dateivariable im Programm}

begin
  ClrScr;
  writeln('In folgende Datei wird geschrieben: ',Name);
  writeln;

  if _FileExist(Name)
  then begin {陳陳陳�Wenn die Datei bereits existiert, dann beenden陳}
         writeln('Datei existiert bereits!');
         writeln('REWRITE �berschreibt die Datei');
         writeln;
         writeln('Programm wird daher beendet!');
       end {then (_FileExist)}
  else begin {陳陳陳陳陳陳陳 陳�Wenn die Datei noch nicht existiert陳}
         Assign(f,Name);                           {Dateien verbinden}
         {$I-}                           {Fehlererkennung ausschalten}
         Rewrite(f);                                    {Datei �ffnen}
         {$I+}                    {Fehlererkennung wieder einschalten}
         if IOResult = 0
         then begin {陳陳陳陳陳陳陳陳陳Wenn kein Fehler beim �ffnen陳}
                writeln(f,'***** 1. neue Zeile *****');
                writeln(f,'***** 2. neue Zeile *****');
                Close(f);                     {Datei wieder schlie�en}
                write('Es wurde erfolgreich in ');
                writeln('die Datei geschrieben!');
              end {then (IOResult)}
         else begin {陳陳陳陳陳陳陳陳陳陳陳�Wenn Fehler beim �ffnen陳}
                writeln('Datei konnte nicht ge�ffnet werden!');
              end; {else (IOResult)}
       end; {else (_FileExist)}

  GotoXY(1,25);
  write('Bitte [Return]-Taste dr�cken...');
  readln;                                        {Auf [Return] warten}
end.