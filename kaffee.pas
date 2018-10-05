PROGRAM KAFFEETEMPERATUR;

USES Crt;

VAR Kaffee, Zimmer, Rechnung, Differenz, Zahl, a : Real;
    b                                            : Longint;
BEGIN
   ClrScr;
   Kaffee:=285;
   Zimmer:=21;
   Zahl := 0;
   REPEAT
      BEGIN
       Zahl := Zahl +1;
       Rechnung:=(Kaffee -Zimmer)/10;
       Kaffee:= Kaffee -Rechnung;
       Differenz:=Kaffee-Zimmer;
       WriteLn ('Die Kaffeetemperatur betr„gt nach ', Zahl:10:0,' Minuten', Kaffee:10:5);
       a := Zahl / 24;
       b := round (a);
       if a = b then readln;
       END;
   UNTIL (Differenz<1);
readln
END.
