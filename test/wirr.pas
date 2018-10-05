Program Kreis;uses Crt;var Radius,Flaeche: real; begin
ClrScr;write('Gib den Radius ein: ');readln(Radius);
Flaeche:= Pi * Sqr(Radius);ClrScr;writeln
('Fl„che des Kreises: ',Flaeche:10:2);readln;end.