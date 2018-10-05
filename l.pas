PROGRAM Game_of_Live;
USES Crt;

VAR Nachbar,a,b: BYTE;
    Leben      : ARRAY [1..15,1..11] of BOOLEAN;

PROCEDURE Spielfeld;

  VAR x : INTEGER;

  BEGIN
   ClrScr;
   Writeln ('  ษออออหออออหออออหออออหออออหออออหออออหออออหออออหออออหออออหออออหออออหออออหออออป');
   FOR x := 1 TO 10 DO
    BEGIN
     Writeln ('  บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ');
     writeln ('  ฬออออฮออออฮออออฮออออฮออออฮออออฮออออฮออออฮออออฮออออฮออออฮออออฮออออฮออออฮออออน');
    END;
   writeln ('  บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ    บ');
   writeln ('  ศออออสออออสออออสออออสออออสออออสออออสออออสออออสออออสออออสออออสออออสออออสออออผ');
   writeln ('                                          (C) 1997 by Tripp-Productions');
END;

PROCEDURE Lebensform;

  VAR  c, d : BYTE;

  BEGIN
   For A:= 1 TO 15 DO
   For B:= 1 TO 11 DO Leben [a,b] := False;
   Leben [1,5] := True;
   Leben [3,6] := True;
   Leben [6,8] := True;
   Leben [2,9] := True;
   Leben [2,1] := True;
   Leben [3,9] := True;
   Leben [4,10] := True;
   Leben [1,9] := True;
   Leben [2,1] := True;
   Leben [15,6] := True;
   Leben [9,6] := True;
   Leben [9,7] := True;
   Leben [10,7] := True;
   Leben [13,11] := True;
   Leben [12,3] := True;
   Leben [10,6] := True;
   Leben [7,9] := True;
   Leben [4,7] := True;
   Leben [3,7] := True;
   Leben [11,6] := True;
   Leben [7,7] := True;
   Leben [15,1] := True;
   Leben [13,2] := True;
   Leben [14,2] := True;
   a := 5;
   b := 2;
   d := 1;
   c := 1;
   Repeat
    if leben [d,c] = True Then
     Begin
      gotoxy (a,b);
      Write ('X');
     End;
    if leben [d,c] = False Then
     Begin
      gotoxy (a,b);
      Write (' ');
     End;
    d := d + 1;
    a := a + 5;
    If d = 16 Then
     Begin
      d := 1;
      c := c + 1;
      a := 5;
      b := b + 2;
     End;
   Until c = 12;
  END;

PROCEDURE Nachbaren;

 VAR x, reihe, spalte, a, b : BYTE;

 BEGIN
  a := 5;
  b := 2;
  reihe := 1;
  spalte := 1;
 Repeat
  nachbar:=0;
   if (reihe = 1) and (spalte=1) then begin
    if leben[spalte,reihe+1]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe+1]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe]=true then nachbar:=nachbar+1;
   end;
   if (reihe=1) and (spalte<>1) and (spalte<>15) then begin
    if leben[spalte,reihe+1] = true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe+1] = true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe+1] = true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe] = true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe] = true then nachbar:=nachbar+1;
   end;
   if (spalte=1) and (reihe<>1) and (reihe<>11) then begin
    if leben[spalte,reihe+1]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe+1]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte,reihe-1]=true then nachbar:=nachbar+1;
   end;
   if (spalte=1) and (reihe=11) then begin
    if leben[spalte+1,reihe]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte,reihe-1]=true then nachbar:=nachbar+1;
   end;
   if (spalte<>1) and (spalte<>15) and (reihe=11) then begin
    if leben[spalte-1,reihe]=true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe]=true then nachbar:=nachbar+1;
   end;
   if (spalte=15) and (reihe=11) then begin
    if leben[spalte-1,reihe]=true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte,reihe-1]=true then nachbar:=nachbar+1;
   end;
   if (spalte=15) and (reihe<>1) and (reihe<>11) then begin
    if leben[spalte,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe]=true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe+1]=true then nachbar:=nachbar+1;
    if leben[spalte,reihe+1]=true then nachbar:=nachbar+1;
   end;
   if (spalte=15) and (reihe=1) then begin
    if leben[spalte,reihe+1]=true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe+1]=true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe]=true then nachbar:=nachbar+1;
   end;
   if (reihe<>1) and (reihe<>11) and (spalte<>1) and (spalte<>15) then begin
    if leben[spalte,reihe+1]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe+1]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe]=true then nachbar:=nachbar+1;
    if leben[spalte+1,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe-1]=true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe]=true then nachbar:=nachbar+1;
    if leben[spalte-1,reihe+1]=true then nachbar:=nachbar+1;
   end;
  GotoXY (a,b);
  IF Nachbar <2 THEN
   Begin
    Write (' ');
    leben[spalte,reihe]:=false;
   END;
  IF Nachbar >4 THEN
   BEGIN
    Write (' ');
    Leben [spalte,reihe]:=false;
   END;
  IF Nachbar = 3 THEN
   BEGIN
    Write ('X');
    Leben [Spalte,reihe]:=true;
   END;
   spalte := spalte + 1;
   delay(100);
   a := a + 5;
   IF spalte = 16 THEN begin
    spalte:=1;
    reihe := reihe + 1;
    a := 5;
    b := b + 2;
   end;
  Until (reihe = 12);
 END;

BEGIN
 Spielfeld;
 Lebensform;
 repeat
  Nachbaren;
 until port [$60] = 1;
END.