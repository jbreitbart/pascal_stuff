{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Records: Kleine Adressverwaltung als Demo.                       º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program AdressVerwaltung;                          {Datei: Person.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Anlegen = 'Arbeitnehmer anlegen';
  Ausgeben = 'Arbeitnehmer ausgeben';
  MaxAN = 10;                           {Maximale Anzahl Arbeitnehmer}

type
  Person = record
    PersNr: integer;
    Name,Vorname: string[30];
    GebDat: string[8];
    Strasse: string[30];
    Plz: 1000..9999;
    Ort: string[20];
  end;

  Belegschaft = array[1..MaxAN] of Person;
  Str25 = string[25];

var
  AN: Belegschaft;
  Wahl: char;
  Anzahl: 0..MaxAN;                                  {Angelegte S„tze}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Maske                                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Schreibt die Eingabemaske auf den Bildschirm.                    ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure Maske(Ueberschr: Str25);
const
  TextAry: array[1..7] of string[20] =
    ('Personal-Nummer: ',
     'Name AN .......: ',
     'Vorname AN ....: ',
     'Geb.-Datum ....: ',
     'Strasse .......: ',
     'PLZ ...........: ',
     'Ort ...........: ');

  Spalte = 10;                                        {Fr Textbeginn}

var
  Zeile,i: integer;                      {Fr Textbeginn/Z„hlvariable}

begin
  ClrScr;
  GotoXY(30,2);
  write(Ueberschr);
  Zeile:= 3;

  for i:= 1 to 7 do
  begin
    Inc(Zeile,2);
    GotoXY(Spalte,Zeile);
    write(TextAry[i]);
  end; {for}

  GotoXY(55,24);
  write('Freie Datens„tze: ',MaxAN-Anzahl);  
end; {Maske}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ SatzSpeichern                                                    ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Speichert einen Datensatz.                                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure SatzSpeichern(Satz: Person);
begin
  if Anzahl < MaxAN
  then begin
         Inc(Anzahl);
         AN[Anzahl]:= Satz;
       end {then}
  else begin
         GotoXY(1,25);
         write(^G);
         write('Alle S„tze belegt! ');
         write('Bitte [Return] drcken...');
         readln;
       end; {else}
end; {SatzSpeichern}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ ANanlegen                                                        ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Legt einen neuen Arbeitnehmer als Datensatz an.                  ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure ANanlegen;
const
  Spalte = 27;                                         {Eingabebeginn}
  Zeile: integer = 5;

var
  SatzEin: Person;
  ch: char;
   
begin
  GotoXY(55,5);   write('(0 = Eingabe beenden!)');
  GotoXY(55,15);  write('(Bereich: 1000..9999)');

  with SatzEin do
  begin
    GotoXY(Spalte,Zeile);
    readln(PersNr);

    if PersNr = 0 then Exit;                      {Prozedur verlassen}

    GotoXY(Spalte,Zeile+2);    readln(Name);
    GotoXY(Spalte,Zeile+4);    readln(Vorname);
    GotoXY(Spalte,Zeile+6);    readln(GebDat);
    GotoXY(Spalte,Zeile+8);    readln(Strasse);
    GotoXY(Spalte,Zeile+10);   readln(Plz);
    GotoXY(Spalte,Zeile+12);   readln(Ort);
  end; {with}
  GotoXY(1,25);
  write('Satz speichern (J//N)? ');

  repeat
    ch:= Upcase(Readkey);
  until (ch = 'J') or (ch = 'N');
  if ch = 'J' then SatzSpeichern(SatzEin);
end; {ANanlegen}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ ANausgeben                                                       ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Gibt einen Arbeitnehmer auf dem Bildschirm aus.                  ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure ANausgeben;
const
  Spalte = 27;
  Zeile: integer = 5;

var
  Nr: 0..MaxAN;

begin
  ClrScr;
  GotoXY(5,10);
  write('Welchen Datensatz ausgeben ');
  write('(0 bis ',Anzahl,'): ');

  repeat
    readln(Nr);
  until (nr >= 0) and (Nr <= Anzahl);

  if Nr <> 0 then
    begin
      Maske(Ausgeben);

      with AN[Nr] do
      begin
        GotoXY(Spalte,Zeile);      write(PersNr);
        GotoXY(Spalte,Zeile+2);    write(Name);
        GotoXY(Spalte,Zeile+4);    write(Vorname);
        GotoXY(Spalte,Zeile+6);    write(GebDat);
        GotoXY(Spalte,Zeile+8);    write(Strasse);
        GotoXY(Spalte,Zeile+10);   write(Plz);
        GotoXY(Spalte,Zeile+12);   write(Ort);
      end; {with}

      GotoXY(1,25);
      write('Bitte [Return] drcken...');
      readln;
    end; {if}
end; {ANausgeben}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Menue                                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Schreibt das Men auf den Bildschirm.                            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure Menue;
const
  Spalte = 28;

begin
  GotoXY(28,10);       write('Arbeitnehmer-Verwaltung');
  GotoXY(28,11);       write('=======================');
  GotoXY(Spalte,15);   write('(1) Arbeitnemer anlegen');
  GotoXY(Spalte,17);   write('(2) Arbeitnemer ausgeben');
  GotoXY(Spalte,20);   write('(3) E N D E');
  GotoXY(Spalte,24);
  write('Bitte w„hlen Sie: ');

  repeat
    Wahl:= Readkey;
  until Wahl in ['1'..'3'];

  case Wahl of
    '1': begin
           Maske(Anlegen);
           ANanlegen;
         end;
    '2': begin
           ANausgeben;
         end;
  end; {case}
end; {Menue}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

begin {Hauptprogramm}
  Anzahl:= 0;                           {Noch kein Datensatz angelegt}

  repeat
    ClrScr;
    Menue;
  until Wahl = '3';

end.