PROGRAM Sortieren_mit_einem_zweiten_Array;
USES Crt;
CONST Anzahl = 100;
VAR z1, z2, Minimum, Nr : INTEGER;
    UFeld, SFeld        : ARRAY[1..Anzahl] OF INTEGER;

    { z1 u. z2 sind die Laufvariablen der beiden Schleifen,
      Nr ist die FeldelementNummer des Minimums,
      UFeld ist das unsortierte Feld, SFeld das sortierte }


BEGIN
 { Feld mit Zufallszahlen fÅllen und ausgeben }
 Randomize;
 ClrScr;
 FOR z1 := 1 TO Anzahl DO UFeld[z1] := Random(30000);
 WriteLn('Unsortiertes Feld: ');
 FOR z1 := 1 TO Anzahl DO Write(UFeld[z1]:8);
 WriteLn;

 { Sortieren
   Aus dem Feld Anzahl-mal das Minimum heraussuchen, im 2.Feld speichern und
   Minimum wieder auf einen gro·en Wert setzen }

 WriteLn('Einen Moment bitte, ich sortiere ... ');
 Minimum:=32000;
 FOR z1:=1 TO Anzahl DO
       BEGIN
        FOR z2:=1 TO Anzahl DO  IF UFeld[z2] < Minimum THEN
                                                       BEGIN
                                                         Minimum := UFeld[z2];
                                                         Nr := z2
                                                       END;
        UFeld[Nr] := 32000;
        SFeld[z1] := Minimum;
        Minimum := 32000
       END;

 { Ausgabe des sortierten Feldes }

 WriteLn('Sortiertes Feld: ');
 FOR z1 := 1 TO Anzahl DO Write(SFeld[z1] : 8);
 ReadLn

END.

