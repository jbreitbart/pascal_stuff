{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 01.08.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Degressive Abschreibung: Berechnet die degressive Abschreibung   º
 º und gibt sie als Tabelle auf dem Bildschirm aus. Einzugeben sind º
 º das Anschaffungsjahr, der Anschaffungswert und der Abschreibungs-º
 º satz (in %).                                                     º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program DegressiveAfA;                             {Datei: DegAfA.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Jahr: integer;
  AWert, Restwert, AfA, Satz: real;

begin
  ClrScr;
  writeln(' ':30,'Abschreibungstabelle');
  writeln;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄEingabe der WerteÄÄ}
  writeln('Bitte geben Sie ein: ');
  writeln;
  write('Anschaffungsjahr:  '); readln(Jahr);
  write('Anschaffungswert:  '); readln(AWert);
  write('Abschreibungssatz: '); readln(Satz);
  writeln;

  writeln('  Jahr       Aw/Rw          AfA            Restwert');
  writeln('---------------------------------------------------');

  Restwert:= AWert;
  AfA:= (Restwert/100) * Satz;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄTabelle ausfllenÄÄ}
  while (Restwert - AfA) > 1 do
  begin
    Restwert:= Restwert - AfA;
    writeln(Jahr:6,AWert:13:2,AfA:14:2,Restwert:18:2);
    AWert:= Restwert;
    Inc(Jahr);
    AfA:= (Restwert/100) * Satz;
  end;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄErinnerungswertÄÄ}
  AfA:= Restwert - 1;
  Restwert:= Restwert - AfA;
  writeln(Jahr:6,AWert:13:2,AfA:14:2,Restwert:18:2);

  readln;                                        {Auf [Return] warten}
end.