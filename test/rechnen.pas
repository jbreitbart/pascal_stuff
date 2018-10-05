{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Beispielunit zum Aufbau einer Unit.                              º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Unit Rechnen;                                     {Datei: Rechnen.pas}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄInterface (”ffentlicher Teil)ÄÄ}
Interface
uses Crt;                                {Bibliothek aus Turbo Pascal}

  function Plus(x1,x2: real): real;
  function Minus(x1,x2: real): real;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄImplementation (nicht-”ffentlicher Teil)ÄÄ}
Implementation
var Erg: real;                                       {Lokale Variable}

function Plus(x1,x2: real): real;
begin
  Erg:= x1 + x2;
  writeln('Ausgabe der Funktion PLUS:');
  writeln(x1:10:2,' + ',x2:10:2,' = ',Erg:10:2);
  writeln;
  Plus:= Erg;
end; {Plus}

function Minus(x1,x2: real): real;
begin
  Erg:= x1 - x2;
  writeln('Ausgabe der Funktion MINUS:');
  writeln(x1:10:2,' - ',x2:10:2,' = ',Erg:10:2);
  writeln;
  Minus:= Erg;
end; {Minus}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄInitialisierungsteilÄÄ}
begin
  ClrScr;
  write('Jetzt im Initialisierungsteil ');
  writeln('der Unit RECHNEN!');
  writeln('-----------------------------------------------');
  writeln;
end.
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄEnde der Unit RechnenÄÄ}
