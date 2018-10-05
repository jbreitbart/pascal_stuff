{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Aktualisiert eine typisierte Datei um weitere Elemente.          º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program TypisierteDateiAktualisieren;                {Datei: Typ3.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'TestStr.Dat';                               {Diskettendatei}

type
  Str20 = string[20];

var
  Element: Str20;
  f: file of Str20;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Warten                                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Wartet in der 25. Zeile auf das Drcken einer Taste.             ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure Warten;
var ch: char;
begin
  GotoXY(1,25);
  write('Bitte eine Taste drcken...');
  ch:= Readkey;
  GotoXY(1,25);
  ClrEol;
end; {Warten}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ ElementeLesen                                                    ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Liest die Elemente aus der Diskettendatei.                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure ElementeLesen;
var i: integer;                                         {Z„hlvariable}
begin
  ClrScr;
  Seek(f,0);                             {Dateizeiger auf Dateianfang}
  writeln('Datei enth„lt folgende Elemente:');
  writeln;
  writeln('Anzahl der Elemente: ',FileSize(f));
  writeln;
  i:= 0;                                                 {Anfangswert}

  while not Eof(f) do
  begin
    Inc(i);                                        {i um Eins erh”hen}
    read(f,Element);                                   {Element lesen}
    writeln(i:3,': ',Element);                     {Bildschirmausgabe}
  end; {while}
  Warten;
end; {ElementeLesen}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ DatensatzAktualisieren                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Aktualisiert einen Datensatz. Ende mit -1.                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure DatensatzAktualisieren;
var
  Anz,                                         {Anzahl der Datens„tze}
  Pos: integer;                                 {Zu „ndernde Position}

begin
  repeat
    ClrScr;
    writeln('Datens„tze aktualisieren');
    writeln('    E N D E mit -1      ');
    writeln;
    writeln;
    Anz:= FileSize(f);
    write('Zul„ssige Werte fr POS sind: ');
    writeln(' 0 <= POS <= ',Anz-1);

    repeat
      GotoXY(20,10);
      write('Welche Position „ndern? ');
      readln(Pos);
    until (Pos >= -1) and (Pos <= Anz-1);

    if Pos <> -1 then
      begin
        Seek(f,Pos);                         {Dateizeiger auf Element}
        read(f,Element);                               {Element lesen}

        GotoXY(20,12);
        write('Alter Inhalt: ',Element);

        GotoXY(20,14);
        write('Neuer Inhalt? ');
        readln(Element);

        Seek(f,Pos);                         {Dateizeiger auf Element}
        write(f,Element);                          {Element schreiben}
        ElementeLesen;
      end; {then}

  until Pos = -1;
end; {DatensatzAktualisieren}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ DatensatzAnhaengen                                               ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ H„ngt einen Datensatz an eine bereits existierende Datei an.     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure DatensatzAnhaengen;
var Nachname: Str20;                                 {Neuer Datensatz}

begin
  writeln('Datei: ',Name,' um 1 Element erg„nzen:');
  writeln;
  Seek(f,FileSize(f));                     {Hinter das letzte Element}

  write('Bitte gib einen Namen ein ');
  write('(max. 20 Zeichen): ');
  readln(Nachname);

  write(f,Nachname);                  {Element in die Datei schreiben}
  ElementeLesen;
end; {DatensatzAnhaengen}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

begin {Hauptprogramm}
  ClrScr;

  Assign(f,Name);                                  {Dateien verbinden}
  {$I-}                                  {Fehlererkennung ausschalten}
  Reset(f);                                       {Neue Datei anlegen}
  {$I+}
  if IOResult = 0
  then begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄWenn kein Fehler beim ™ffnenÄÄ}
         DatensatzAnhaengen;
         DatensatzAktualisieren;
         close(f);                            {Datei wieder schlieáen}
       end {then}
  else begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄWenn Fehler beim ™ffnenÄÄ}
         writeln('Fehler beim ™ffnen der Datei!!');
         writeln;
         writeln('Programm wird beendet.');         
       end; {else}

  ClrScr;
end.