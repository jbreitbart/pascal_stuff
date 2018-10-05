{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 01.08.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Der Rechner 'denkt' sich eine Zahl zwischen 0 und 100 aus, die   º
 º vom Anwender geraten werden muá.                                 º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program ZahlenRaten;                                {Datei: Raten.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Versuche,
  Ratezahl,Geheimzahl: integer;

begin
  ClrScr;
  writeln('Zahlenraten mit dem Computer (zwischen 0 und 100)');
  writeln;

  Randomize;                         {Zufallsgenerator initialisieren}
  Geheimzahl:= Random(101);           {Zufallszahl zwischen 0 und 100}
  Versuche:= 0;

  repeat
    Inc(Versuche);
    GotoXY(10,12);
    ClrEol;                                            {Zeile l”schen}
    write('Geben Sie Ihren ',Versuche,'. Versuch ein: ');
    readln(Ratezahl);

    GotoXY(10,14);
    ClrEol;                                            {Zeile l”schen}
    if Ratezahl > Geheimzahl
      then write('Die Zahl ist kleiner als ',Ratezahl)
      else if Ratezahl < Geheimzahl
        then write('Die Zahl ist gr”áer als ',Ratezahl)
        else write('Herzlichen Glckwunsch! Sie haben die ',
                   'Zahl mit ',Versuche,' Versuchen erraten.');
  until Ratezahl = Geheimzahl;
  readln;                                        {Auf [Return] warten}
end.