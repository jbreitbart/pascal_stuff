{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Schreibt zwei Zeilen in eine neue Textdatei.                     º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
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
  then begin {ÄÄÄÄÄÄÄWenn die Datei bereits existiert, dann beendenÄÄ}
         writeln('Datei existiert bereits!');
         writeln('REWRITE berschreibt die Datei');
         writeln;
         writeln('Programm wird daher beendet!');
       end {then (_FileExist)}
  else begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ ÄÄÄWenn die Datei noch nicht existiertÄÄ}
         Assign(f,Name);                           {Dateien verbinden}
         {$I-}                           {Fehlererkennung ausschalten}
         Rewrite(f);                                    {Datei ”ffnen}
         {$I+}                    {Fehlererkennung wieder einschalten}
         if IOResult = 0
         then begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄWenn kein Fehler beim ™ffnenÄÄ}
                writeln(f,'***** 1. neue Zeile *****');
                writeln(f,'***** 2. neue Zeile *****');
                Close(f);                     {Datei wieder schlieáen}
                write('Es wurde erfolgreich in ');
                writeln('die Datei geschrieben!');
              end {then (IOResult)}
         else begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄWenn Fehler beim ™ffnenÄÄ}
                writeln('Datei konnte nicht ge”ffnet werden!');
              end; {else (IOResult)}
       end; {else (_FileExist)}

  GotoXY(1,25);
  write('Bitte [Return]-Taste drcken...');
  readln;                                        {Auf [Return] warten}
end.