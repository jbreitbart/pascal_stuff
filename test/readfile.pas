{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Listet eine (Text-)Datei auf dem Bildschirm. Um nicht �ber das   �
 � Dateiende hinauszulesen, wird eine While-Schleife verwendet.     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Datei �ffnen陳}
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
  else writeln('Datei konnte nicht ge�ffnet werden!');

  readln;                                        {Auf [Return] warten}
end.