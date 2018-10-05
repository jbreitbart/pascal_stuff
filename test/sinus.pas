{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Berechnet und druckt eine Tabelle der Sinuswerte im Bereich von  º
 º 0 bis 360 Grad. Der Drucker muá eingeschaltet sein!              º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program SinusTabelle;                               {Datei: Sinus.pas}
uses Crt,Printer;                      {Bibliotheken aus Turbo Pascal}
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
 ³ Gibt die Tabelle auf dem Drucker aus.                            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure Ausgabe;
const
  Ueberschrift = 'Tabelle der Sinuswerte';
  Unterstrich  = '======================';

var
  i,j: integer;

begin
  write(Lst,#15);                     {Kleinschrift fr EPSON-Drucker}
  writeln(Lst);                            {Leerzeile fr den Drucker}
  writeln;                                  {Leerzeile fr Bildschirm}
  writeln('Es wird gedruckt...');

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄTabellen-šberschriftÄÄ}
  writeln(Lst,' ':40,Ueberschrift);
  writeln(Lst,' ':40,Unterstrich);
  writeln(Lst);
  write(Lst,'SIN':4,' !');

  for i:= 0 to 10 do write(Lst,i:9,' ');
  writeln(Lst);

  for i:= 1 to 115 do write(Lst,'-');
  writeln(Lst); writeln(Lst);

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄTabelle erstellenÄÄ}
  for i:= 0 to 35 do
  begin
    write(Lst,(i*10):4,' ','!');

    for j:= 0 to 10 do
    begin
      write(Lst,Tabelle[i,j]:9:4,' ');
    end; {for j}

    writeln(lst);
  end; {for i}
  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

  write(Lst,#18);                               {Kleinschrift beenden}
  writeln(Lst);
end; {Ausgabe}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ DruckerOk                                                        ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Prft, ob der Drucker betriebsbereit ist.                        ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
function DruckerOk: boolean;
const
  Frage = 'Drucker betriebsbereit (J/N)? ';

var
  ch: char;

begin
  GotoXY(10,5);
  write(Frage);

  repeat
    GotoXY(10+Length(Frage),5);
    ch:= Upcase(Readkey);
  until (ch = 'J') or (ch = 'N');

  if ch = 'J'
    then DruckerOk:= true
    else DruckerOk:= false;

end; {DruckerOk}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

begin {Hauptprogramm}
  ClrScr;
  writeln('Sinuswerte berechnen und auf dem Drucker ausgeben');
  writeln;
  SinusBerechnen;

  if DruckerOk
    then Ausgabe
    else begin
           writeln(' N E I N!');
           writeln;
           writeln('Daher keine Ausgabe m”glich.');
         end; {else}

  GotoXY(1,25);
  write('Bitte [Return] drcken...');
  readln;                                        {Auf [Return] warten}
end.