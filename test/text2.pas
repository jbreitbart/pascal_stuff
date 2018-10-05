{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º 'H„ngt' Text an eine Textdatei an.                               º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program TextAnhaengen;                              {Datei: Text2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'Text1.txt';                                 {Diskettendatei}
  NeueZeile = '***** Neue Zeile *****';

var
  f: Text;                                 {Dateivariable im Programm}

begin
  ClrScr;
  writeln('Folgende Datei wird erg„nzt: ',Name);
  writeln;

  Assign(f,Name);                                  {Dateien verbinden}
  {$I-}                                  {Fehlererkennung ausschalten}
  Append(f);                                            {Datei ”ffnen}
  {$I+}                           {Fehlererkennung wieder einschalten}

  if IOResult = 0 {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄFehlerfreie AusfhrungÄÄ}
  then begin
         writeln(f);                                       {Leerzeile}
         writeln(f,NeueZeile);
         close(f);                            {Datei wieder schlieáen}
         writeln('Es wurde erfolgreich in die Datei geschrieben!');
         writeln;
         write('Starten Sie das Programm Text1.pas ');
         writeln('zur šberprfung!');
       end {then}
  else begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄFehler beim ™ffnen der DateiÄÄ}
         writeln('Datei nicht gefunden.');
         writeln('Bitte Verzeichnis berprfen!');
       end; {else}

  GotoXY(1,25);
  write('Bitte [Return]-Taste drcken...');
  readln;                                        {Auf [Return] warten}
end.