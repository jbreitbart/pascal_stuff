{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 01.09.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Das Programm berechnet die Oberfl„che krummlinig begrenzter      º
 º K”rper (Kreizylinder, gerader Kreiskegel und Kugel). Die Auswahl º
 º des zu berechnenden K”rpers erfolgt mit Hilfe der Case-Anweisung.º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program KoerperBerechnung;                        {Datei: Koerper.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Wahl: char;
  r,h,O: real;                              {Radius, H”he, Oberfl„che}
  Form: string;                                     {Form des K”rpers}

begin
  ClrScr;
  writeln(' ':9,'Oberfl„che krummlinig begrenzter K”rper');
  writeln(' ':9,'=======================================');

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄAuswahlpunkte auf den BildschirmÄÄ}
  GotoXY(10,4);  writeln('Welcher K”rper soll berechnet werden?');

  GotoXY(12,6);  writeln('(1) Kreiszylinder');
  GotoXY(12,7);  writeln('(2) Gerader Kreiskegel');
  GotoXY(12,8);  writeln('(3) Kugel');
  GotoXY(12,9);  writeln('(4) Keine Berechnung --> ENDE');

  GotoXY(10,11);
  write('Bitte w„hlen Sie: ');
  readln(Wahl);

  if Wahl in ['1'..'3']
    then begin
           {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄDie Form des K”rpers bestimmenÄÄ}
           case Wahl of
             '1': Form:= 'des Kreiszylinders';
             '2': Form:= 'des Kreiskegels';
             '3': Form:= 'der Kugel';
           end; {case}

           {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄRadius wird fr alle K”rper ben”tigtÄÄ}
           GotoXY(10,15);
           write('Bitte den Radius ',Form,' eingeben: ');
           readln(r);
           GotoXY(10,16);

           case Wahl of
             '1': begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄKreiszylinderÄÄ}
                    write('Bitte die H”he ',Form,' eingeben  : ');
                    readln(h);
                    O:= 2 * Pi * r * (r + h);
                  end;
             '2': begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄGerader KreiskegelÄÄ}
                    write('Bitte die H”he ',Form,' eingeben  : ');
                    readln(h);
                    O:= Pi * r * (r + (Sqrt (Sqr(r) + Sqr(h))));
                  end;
             '3': O:= 4 * Pi * Sqr(r); {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄKugelÄÄ}
           end; {case}

           {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄAusgabe der Oberfl„cheÄÄ}
           GotoXY(10,20);
           writeln('Die Oberfl„che ',Form,' betr„gt: ',O:10:2);

           GotoXY(1,25);
           write('Bitte [Return] drcken...');
           readln;
         end {if}
    else begin
           if Wahl <> '4' then
             begin
               GotoXY(1,25);
               write('Keine gltiger Auswahlpunkt! ');
               write('Bitte [Return] drcken...');
               readln;
             end; {if}
         end; {else}
end.