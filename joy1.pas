UNIT Joy;
INTERFACE
USES Dos;
VAR  F1,F2 : Byte;
     X1,Y1 : Integer;
     Reg   : Registers;
PROCEDURE JoyPos;
IMPLEMENTATION
PROCEDURE JoyPos;
BEGIN
  Reg.AH := $84;
  Reg.DX := $01;
  Intr ($15,Reg);
  X1 := Reg.AX;
  Y1 := Reg.BX;
  Reg.AH := $84;
  Reg.DX := $00;
  Intr ($15,Reg);
  IF ((Reg.AL) AND (16)) = 0 THEN F1 := 1 ELSE F1 := 0;
  IF ((Reg.AL) AND (32)) = 0 THEN F2 := 1 ELSE F2 := 0;
END;
END.
