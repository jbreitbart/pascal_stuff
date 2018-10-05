{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Berechnet und gibt eine Tabelle der Sinuswerte von 0 bis 360 Gradº
 º in die Datei Sinus.dat aus.                                      º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program SinusTabelleDatei;                         {Datei: Sinus2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Tabelle: array[0..35,0..10] of real;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ SinusBerechnen                                                   ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Berechnet den Sinuswert von 0 bis 360 Grad und legt ihn in einem ³
 ³ 2-dimensionalen Feld ab. Die BEGIN der FOR-Schleife wurden nur   ³
 ³ wegen der besseren Lesbarkeit verwendet, sie sind nicht notwendig³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure SinusBerechnen;
const
  UmFak = 0.017453;             {Umrechnungsfaktor Altgrad  Bogenmaá}

var
  i,j: integer;                                        {Z„hlvariablen}

begin
  for i:= 0 to 35 do
  begin

    for j:= 0 to 10 do
    begin
      Tabelle[i,j]:= Sin(((i*10)+j) * UmFak);
    end; {for j}

  end; {for i}
end; {SinusBerechnen}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Ausgabe                                                          ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Gibt die Tabelle in die Datei Sinus.dat aus.                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure Ausgabe;
const
  Ueberschrift = 'Tabelle der Sinuswerte';
  Unterstrich  = '======================';
  DatName = 'Sinus.dat';

var
  i,j: integer;
  f: Text;                                             {Dateivariable}

begin
  Assign(f,DatName);
  {$I-}
  Rewrite(f);                          {Neue Datei anlegen und ”ffnen}
  {$I+}

  if IOResult = 0 then
  begin
    writeln(f);                               {Leerzeile in der Datei}
    writeln;                                {Leerzeile fr Bildschirm}

    {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄTabellen-šberschriftÄÄ}
    writeln(f,' ':40,Ueberschrift);
    writeln(f,' ':40,Unterstrich);
    writeln(f);
    write(f,'SIN':4,' !');

    for i:= 0 to 10 do write(f,i:9,' ');
    writeln(f);

    for i:= 1 to 115 do write(f,'-');
    writeln(f); writeln(f);

    {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄTabelle erstellenÄÄ}
    for i:= 0 to 35 do
    begin
      write(f,(i*10):4,' ','!');

      for j:= 0 to 10 do
      begin
        write(f,Tabelle[i,j]:9:4,' ');
      end; {for j}

      writeln(f);
    end; {for i}
    {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

    writeln(f);
    close(f);
  end {if}
  else write('Fehler beim ™ffnen der Datei!');
end; {Ausgabe}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

begin {Hauptprogramm}
  ClrScr;
  writeln('Sinuswerte berechnen und in SINUS.DAT speichern');
  writeln;

  SinusBerechnen;
  Ausgabe;

  GotoXY(1,25);
  write('Bitte [Return] drcken...');
  readln;                                        {Auf [Return] warten}
end.