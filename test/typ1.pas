{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Schreibt Daten in eine typisierte Datei.                         º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program InTypisierteDateiSchreiben;                  {Datei: Typ1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'TestStr.Dat';                               {Diskettendatei}
  n = 10;                                        {Anzahl der Elemente}

type
  Str20 = string[20];

var
  Element: array[1..n] of Str20;
  f: file of Str20;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ ElementeSchreiben                                                ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Schreibt die Elemente in die Diskettendatei.                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure ElementeSchreiben;
var i: integer;                                         {Z„hlvariable}
begin
  writeln('Folgende Elemente werden geschrieben:');
  writeln;
  for i:= 1 to n do
  begin
    write(f,Element[i]);
    writeln(i:3,': ',Element[i]);
  end; {for}
  writeln;
  writeln('Anzahl der Elemente: ',FileSize(f));
end; {ElementeSchreiben}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ FeldInit                                                         ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Initialisiert das Feld mit den Namen.                            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure FeldInit;
begin
  Element[1]:= 'Schmidtke';     Element[2]:= 'Flathmann';
  Element[3]:= 'Hansen';        Element[4]:= 'Rowohlt';
  Element[5]:= 'Emmerich';      Element[6]:= 'Becker';
  Element[7]:= 'Schulz';        Element[8]:= 'Tietze';
  Element[9]:= 'Behrens';       Element[10]:= 'Wunder';
end; {FeldInit}

begin {Hauptprogramm}
  ClrScr;
  writeln('In eine typisierte Datei schreiben');
  writeln;

  FeldInit;

  Assign(f,Name);                                  {Dateien verbinden}
  {$I-}                                  {Fehlererkennung ausschalten}
  Rewrite(f);                                     {Neue Datei anlegen}
  {$I+}
  if IOResult = 0
  then begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄWenn kein Fehler beim ™ffnenÄÄ}
         ElementeSchreiben;
         close(f);                            {Datei wieder schlieáen}
       end {then}
  else begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄWenn Fehler beim ™ffnenÄÄ}
         writeln('Fehler beim Erzeugen der Datei!!');
         writeln;
         writeln('Programm wird beendet.');         
       end; {else}

  GotoXY(1,25);
  write('Bitte [Return]-Taste drcken...');
  readln;                                        {Auf [Return] warten}
end.