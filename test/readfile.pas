{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Listet eine (Text-)Datei auf dem Bildschirm. Um nicht ber das   บ
 บ Dateiende hinauszulesen, wird eine While-Schleife verwendet.     บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program DateiLesen;                              {Datei: ReadFile.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Dateiname = 'C:\Config.sys';

var
  Zeile: string;                                 {Eine gelesene Zeile}
  f: Text;                                                 {Textdatei}

begin
  ClrScr;
  writeln('Listing der Datei ',Dateiname);
  writeln;

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤDatei ”ffnenฤฤ}
  assign(f,Dateiname);
  {$I-}  Reset(f);  {$I+}
  if IOResult = 0
  then begin
         while not Eof(f) do
         begin
           readln(f,Zeile);                    {Zeile aus Datei lesen}
           writeln(Zeile);        {Zeile auf den Bildschirm schreiben}
         end; {while}
       end
  else writeln('Datei konnte nicht ge”ffnet werden!');

  readln;                                        {Auf [Return] warten}
end.