{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 12.09.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Demo zu ReadLn: Alter berechnen.                                 º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program AlterBerechnen;                             {Datei: Alter.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Name: string;                                    {Vor- und Nachname}
  Alter,                                             {Alter in Jahren}
  Tage,Stunden: LongInt;                                {Alter in ...}

begin
  ClrScr;
  writeln('Alter berechnen');
  writeln;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄEingabeÄÄ}
  write('Gib Deinen Vor- und Nachnamen ein: ');
  readln(Name);
  write('Wie alt bist Du (in Jahren)?       ');
  readln(Alter);
  writeln;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄBerechnungÄÄ}
  Tage:= Alter * 365;
  Stunden := Tage * 24;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄAusgabeÄÄ}
  writeln(Name,', Du bist ',Alter,' Jahre alt, ');
  writeln('bzw. ',Tage,' Tage bzw. ',Stunden,' Stunden.');

  readln;                                        {Auf [Return] warten}
end.