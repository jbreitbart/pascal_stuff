{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 01.08.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Liest drei Zahlen ber Tastatur ein, addiert sie und gibt die    º
 º Summe auf dem Bildschirm aus.                                    º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program Addition;                                {Datei: Addition.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Summe,x: real;                               {x = einzulesende Zahl}

begin
  ClrScr;
  Summe:= 0;                      {Initialisieren und auf Null setzen}
  writeln('Addition von drei Zahlen');
  writeln;
  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ1. Zahl einlesen und Summe berechnenÄÄ}
  write('1. Zahl eingeben: ');
  readln(x);
  Summe:= Summe + x;
  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ2. Zahl einlesen und Summe berechnenÄÄ}
  write('2. Zahl eingeben: ');
  readln(x);
  Summe:= Summe + x;
  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ3. Zahl einlesen und Summe berechnenÄÄ}
  write('3. Zahl eingeben: ');
  readln(x);
  Summe:= Summe + x;
  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄSumme ausgeben und Programm beendenÄÄ}
  writeln;
  writeln('Die Summe der drei Zahlen betr„gt: ',Summe:6:2);
  readln;                                        {Auf [Return] warten}
end.