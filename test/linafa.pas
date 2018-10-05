{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 01.08.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Lineare Abschreibung: Berechnet die lineare Abschreibung und     º
 º gibt sie als Tabelle auf dem Bildschirm aus. Einzugeben sind das º
 º Anschaffungsjahr, der Anschaffungswert und die gesamte Nutzungs- º
 º dauer.                                                           º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program LineareAfA;                                {Datei: LinAfA.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Jahr, NDauer: integer;
  AWert, Restwert, AfA: real;

begin
  ClrScr;
  writeln(' ':30,'Abschreibungstabelle');
  writeln;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄEingabe der WerteÄÄ}
  writeln('Bitte geben Sie ein: ');
  writeln;
  write('Anschaffungsjahr: '); readln(Jahr);
  write('Anschaffungswert: '); readln(AWert);
  write('Nutzungsdauer   : '); readln(NDauer);
  writeln;

  writeln('  Jahr       AfA            Restwert');
  writeln('------------------------------------');

  Restwert:= AWert;
  AfA:= AWert / NDauer;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄTabelle ausfllenÄÄ}
  while Restwert > AfA do
  begin
    Restwert:= Restwert - AfA;
    writeln(Jahr:6,AfA:13:2,Restwert:17:2);
    Inc(Jahr);
  end;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄErinnerungswertÄÄ}
  AfA:= AfA - 1;
  Restwert:= Restwert - AfA;
  writeln(Jahr:6,AfA:13:2,Restwert:17:2);

  readln;                                        {Auf [Return] warten}
end.