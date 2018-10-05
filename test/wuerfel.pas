{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 01.08.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Berechnet die H„ufigkeitsverteilung eines Wrfelexperiments und  º
 º gibt sie 'grafisch' auf dem Bildschim aus.                       º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program WuerfelSimulation;                        {Datei: Wuerfel.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  i,j,Anzahl: word;                     {Laufvariablen/Anz. der Wrfe}
  A: array[1..6] of word;      {Absolute H„ufigkeiten der Augenzahlen}
  ZufallsZahl: 1..6;                            {Gewrfelte Augenzahl}

  q: real;                                       {Quotient 100/Anzahl}
  R: array[1..6] of real;      {Relative H„ufigkeiten der Augenzahlen}

begin
  ClrScr;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄInitialisierungÄÄ}
  Randomize;                         {Zufallsgenerator initialisieren}
  for i:= 1 to 6 do A[i]:= 0;

  writeln('Simulation eines Wrfelexperiments');
  writeln;
  write('Wie oft soll gewrfelt werden (1-65535)?: ');
  readln(Anzahl);

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄAuf Anzahl = 0 prfenÄÄ}
  if Anzahl = 0 then
  begin
    ClrScr;
    write(^G);                                               {Piepton}
    writeln('Anzahl der Wrfe muá gr”áer als Null sein!');
    writeln;
    writeln('Programm-Abbruch nach [Return]');
    readln;
    Halt;                                           {Programm-Abbruch}
  end;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'Wrfeln' und absolute H„ufigkeiten ermittelnÄÄ}
  for i:= 1 to Anzahl do
  begin
    ZufallsZahl:= Random(6) + 1;
    Inc(A[ZufallsZahl]);
  end; {for}

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄRelative (prozentuale) H„ufigkeiten ermittelnÄÄ}
  q:= 100/Anzahl;
  for i:= 1 to 6 do R[i]:= q * A[i];

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄErgebnisse ausgebenÄÄ}
  ClrScr;
  writeln('Relative H„ufigkeitsverteilung des Wrfelexperiments');
  writeln(' ':15,'Anzahl der Wrfe: ',Anzahl:6);
  writeln;

  for i:= 1 to 6 do
  begin
    write(i:3,': ');
    for j:= 1 to Trunc(R[i]) do write('*');
    writeln(' ',R[i]:6:2,' %');
    writeln;
  end;
  readln;                                        {Auf [Return] warten}
end.