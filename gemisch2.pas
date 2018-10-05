Unit Gemisch2;

{Maustreiber / Abbruch durch Interrupt / Offenes Laufwerk / Kein Cursor}

Interface

Uses DOS,CRT;

Type T_Speicher = Array[1..8] of Byte;
     T_Titel    = String[8];

Var Zeichensatz : Array[0..255] of T_Speicher absolute $F000:$FA6E;

    OldPtrScr, OldExit : Pointer;
    Kein_Cursor,Cursor : Word;

{----------------------------------------------------------------------------}
Function Maus_Ok : Boolean; {Bekommt Wert TRUE, wenn Maustreiber installiert }
Function X_Maus : Word;
Function Y_Maus : Word;
Function Maustaste(Taste : Byte) : Boolean;
Procedure Zeige_Pfeil(Zeigen:Byte);
Function Innerhalb(X1,Y1,X2,Y2 : Word) : Boolean;
Function Selektiert(X1,Y1,X2,Y2 : Word) : Boolean;
Procedure Y_Bereich(Oben,Unten : Word);
Procedure X_Bereich(Links,Rechts : Word);
Procedure Empfindl(Horiz,Vert : Word);
Procedure Feld_Ausgrenzen(Links,Oben,Rechts,Unten : Word);
{----------------------------------------------------------------------------}
Procedure Abbruch;
Procedure NewPtrScr; Interrupt;
Procedure NewExit;
{----------------------------------------------------------------------------}
Function TestDrive(Drive:Byte) : Boolean;
{----------------------------------------------------------------------------}
Procedure Cursor_Unsichtbar(Neuer_Cursor:Word);
{----------------------------------------------------------------------------}
Procedure BigTitel(Titel:T_Titel; PosY:Byte);
{----------------------------------------------------------------------------}

Implementation

{************************** Maustreiber *************************************}
Function Maus_Ok : Boolean;
 Var Temp : POINTER;
     Regs : Registers;
 begin
   Regs.AX:=0;
   Regs.BX:=0;
    GetIntVec($33,Temp);
    If Temp<>NIL then Intr($33,Regs);
   Maus_Ok:=Regs.BX<>0
end;
{----------------------------------------------------------------------------}
Function X_Maus; {Abfrage der X-Position der Maus}
 Var Regs : Registers;
  begin
   Regs.AX := 3;
   Intr($33,Regs);
   X_Maus := Regs.CX;
  end;
{----------------------------------------------------------------------------}
Function Y_Maus; {Abfrage der Y-Position der Maus}
 Var Regs : Registers;
  begin
   Regs.AX := 3;
   Intr($33,Regs);
   Y_Maus := Regs.DX;
  end;
{----------------------------------------------------------------------------}
Function Maustaste; {Abfrage, ob Taste Nummer 'Taste' gedrÅckt wurde}
 Var Regs : Registers;
  begin
   Regs.AX := 3;
   Intr($33,Regs);
   Maustaste := ((1 Shl (Taste-1)) And Regs.BX)<>0;
  end;
{----------------------------------------------------------------------------}
Procedure Zeige_Pfeil(Zeigen:Byte); {Anzeige eines Pfeils an Maus-Position}
 Var Regs : Registers;
 begin
  Regs.AX := Zeigen;
  Intr($33,Regs);
 end;
{----------------------------------------------------------------------------}
Function Innerhalb; {Maustaste innerhalb Feld}
 Procedure Swap(Var W1,W2:Word);
 Var W : Word;
  begin
   W:=W1; W1:=W2; W2:=W;
  end;
 Var XM, YM : Word;
 begin
  If X1>X2 then Swap(X1,X2);
  If Y1>Y2 then Swap(Y1,Y2);
  XM:=X_Maus;
  YM:=Y_Maus;
  Innerhalb:=(XM>=X1) And (XM<=X2) And (YM>=Y1) And (YM<=Y2);
 end;
{----------------------------------------------------------------------------}
Function Selektiert;  {Maustaste innerhalb Feld und Taste 1 gedrÅckt}
 begin
  Selektiert:=Innerhalb(X1,Y1,X2,Y2) And Maustaste(1);
 end;
{----------------------------------------------------------------------------}
Procedure Y_Bereich(Oben,Unten : Word); {Vertikale Grenzen des Mausfeldes}
 Var Regs : Registers;
  begin
   Regs.CX := Oben;
   Regs.DX := Unten;
   Regs.AX := 8;
   Intr($33,Regs);
  end;
{----------------------------------------------------------------------------}
Procedure X_Bereich(Links,Rechts : Word); {Horizontale Grenzen des Mausfeldes}
 Var Regs : Registers;
  begin
   Regs.CX := Links;
   Regs.DX := Rechts;
   Regs.AX := 7;
   Intr($33,Regs);
  end;
{----------------------------------------------------------------------------}
Procedure Empfindl(Horiz,Vert : Word); {Empfindlichkeit der Mausbewegung}
 Var Regs : Registers;
  begin
   Regs.CX := Horiz;
   Regs.DX := Vert;
   Regs.AX := 15;
   Intr($33,Regs);
  end;
{----------------------------------------------------------------------------}
Procedure Feld_Ausgrenzen(Links,Oben,Rechts,Unten : Word);
 Var Regs : Registers;  {Im Feld Ist Cursor unsichtbar }
  begin                 {Cursor mu· dann neu initialisiert werden}
   Regs.CX := Links;
   Regs.DX := Oben;
   Regs.SI := Rechts;
   Regs.DI := Unten;
   Regs.AX := 16;
   Intr($33,Regs);
  end;
{**************************** Abbruch ***************************************}
Procedure NewPtrScr;
 begin
  halt(0);
 end;
{----------------------------------------------------------------------------}
{$F+}
Procedure NewExit;
 begin
  SetIntVec(5,OldPtrScr);
  ExitProc := OldExit;
 end;
{$F-}
{----------------------------------------------------------------------------}
Procedure Abbruch;
begin
 GetIntVec(5,OldPtrScr);
 SetIntVec(5,@NewPtrScr);
 OldExit := ExitProc;
 ExitProc := @NewExit;
end;
{***************************** Laufwerk offen *******************************}
Function TestDrive(Drive:Byte) : Boolean;
Var Regs       : Registers;
    Num_Drives : Integer;
begin
 Intr($11,Regs);
 Num_Drives := Regs.AX;
 If (Num_Drives And 1)=0 then Num_Drives := 0
  else Num_Drives := ((Num_Drives Shl 8) Shr 14) + 1;
 If Num_Drives < (Drive+1) then Testdrive := False
  else
   With Regs do
    begin
     DL := Drive;
     DH := 0;
     CX := 1;
     AX := $0401;
     Intr($13,Regs);
     TestDrive := AH<>$80;
     DL := Drive;
     AX := 0;
     Intr($13,Regs);
    end;
  end;
{************************** Kein Cursor *************************************}
Procedure Cursor_Unsichtbar(Neuer_Cursor : Word);
Var Reg : Registers;
begin
  Kein_Cursor := $2000;
  Cursor      := $0607;
  With Reg do
  begin
   AH := 1;
   BH := 0;
   CX := Neuer_Cursor;
   Intr($10, Reg);
  end;
end; {Procedure Cursor_Unsichtbar}
{************************* Gross-Schrift ************************************}
Procedure LeseEintrag(Eintrag:T_Speicher);
Var Pixel_PosY, Pixel_PosX : 1..8;
    Pixel                  : Byte;
begin
 For Pixel_PosY := 1 to 7 do
  begin
   Pixel := Eintrag[Pixel_PosY];
   For Pixel_PosX := 8 DownTo 1 do
    begin
     GotoXY(Pixel_PosX,Pixel_PosY);
      If Odd (Pixel) then Write ('€') else Write(' '); Delay(3);
     Pixel := Pixel Div 2;
    end
  end;
end;
{----------------------------------------------------------------------------}
Procedure BigTitel(Titel:T_Titel; PosY:Byte);
Var N, Laenge,PosX, X : Byte;
begin
 Laenge := Length(Titel);
 PosX := ((80-8*Laenge) Div 2) And $00FF;
 For N := 1 to Laenge do
  begin
   X := PosX + 8*(N-1);
   Window(X-2,PosY,X+7,PosY+8);
   LeseEintrag(Zeichensatz[Ord(Titel[N])]);
  end;
  Window(1,1,80,25);
end;
{----------------------------------------------------------------------------}

END.