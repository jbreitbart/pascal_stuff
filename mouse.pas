{
===========================================================
Datei    : MOUSE.PAS
Zweck    : UNIT fÅr Mausbenutzung
Datum    : 09.04.1990
Version  : 2.01
Autor    : Achim Kalwa
Compiler : TURBO-PASCAL V5.5
===========================================================
}
{$A+,B-,D-,E-,F-,I+,L-,N-,O-,R-,S-,V-}
UNIT Mouse;

INTERFACE

CONST
  MouseButtonLeft = $0001;         { linke Maustaste    }
  MouseButtonRight= $0002;         { rechte Maustaste   }
  MouseButtonMid  = $0004;         { mittlere Maustaste }
  MouseHardCursor = 1;
  MouseSoftCursor = 0;

TYPE
  SCMaskType = RECORD
    Smask : ARRAY[0..15] OF WORD;
    Cmask : ARRAY[0..15] OF WORD;
  END;

FUNCTION  MouseInstalled:BOOLEAN;
{ Testet ob Maus vorhanden ist }

PROCEDURE MouseInit;
{ Initialisiert den Maus-Treiber }

PROCEDURE MouseShow;
{ Mauscursor anzeigen }

PROCEDURE MouseHide;
{ Mauscursor abschalten }

FUNCTION MouseButton:BYTE;
{ Maustasten abfragen }

FUNCTION MouseXpos:WORD;
{ X-Position der Maus }

FUNCTION MouseYpos:WORD;
{ Y-Position der Maus }

PROCEDURE MouseGotoXY(x,y:WORD);
{ Maus positionieren }

PROCEDURE MouseWindow(x1,y1,x2,y2:WORD);
{ Legt Bereich fÅr Maus fest }

FUNCTION  MouseInWindow(x1,y1,x2,y2:WORD):BOOLEAN;
{ PrÅft, ob Mauszeiger innerhalb eines Bildausschnittes }

PROCEDURE MouseSetTextCursor(Typ:BYTE;Smask,Cmask:WORD);
{ Definiert den Mauscursor im Textmodus }

PROCEDURE MouseSetGraphCursor(HotX,HotY:WORD; VAR SCMask);
{ Definiert den Mauscursor im Grafikmodus }

IMPLEMENTATION

USES
  Dos;

VAR
  Reg   : Registers;

FUNCTION  MouseInstalled:BOOLEAN;
BEGIN
  Reg.AX:=0;
  Intr($33,Reg);
  MouseInstalled:=(Reg.AX<>0);
END;

PROCEDURE MouseInit;
BEGIN
  Reg.AX:=0;
  Intr($33,Reg);
  IF Reg.AX=0 THEN BEGIN
    Writeln;
    Writeln('Maustreiber nicht geladen! Programm abgebrochen',#7);
    Halt(1);
  END;
END;

PROCEDURE MouseShow;
BEGIN
  Reg.AX:=1;
  Intr($33,Reg);
END;

PROCEDURE MouseHide;
BEGIN
  Reg.AX:=2;
  Intr($33,Reg);
END;

FUNCTION MouseButton:BYTE;
BEGIN
  Reg.AX:=3;
  Intr($33,Reg);
  Mousebutton:=Reg.bl;
END;

FUNCTION MouseXpos:WORD;
BEGIN
  Reg.AX:=3;
  Intr($33,Reg);
  MouseXpos:=Reg.CX;
END;

FUNCTION MouseYpos:WORD;
BEGIN
  Reg.AX:=3;
  Intr($33,Reg);
  MouseYpos:=Reg.DX;
END;

PROCEDURE MouseGotoXY(x,y:WORD);
BEGIN
  Reg.AX:=4;
  Reg.CX:=x;
  Reg.DX:=y;
  Intr($33,Reg);
END;

PROCEDURE MouseWindow(x1,y1,x2,y2:WORD);
BEGIN
  Reg.AX:=7;
  Reg.CX:=x1;
  Reg.DX:=x2;
  Intr($33,Reg);
  Reg.AX:=8;
  Reg.CX:=y1;
  Reg.DX:=y2;
  Intr($33,Reg);
END;

FUNCTION  MouseInWindow(x1,y1,x2,y2:WORD):BOOLEAN;
BEGIN
  Reg.AX:=3;
  Intr($33,Reg);
  MouseInWindow:=(x1<=Reg.CX) AND (Reg.CX<=x2) AND
                 (y1<=Reg.DX) AND (Reg.DX<=y2);
END;

PROCEDURE MouseSetTextCursor(Typ:BYTE;Smask,Cmask:WORD);
BEGIN
  Reg.AX:=10;
  Reg.BX:=Typ;    { Software / Hardware }
  Reg.CX:=Smask;
  Reg.DX:=Cmask;
  Intr($33,Reg);
END;

PROCEDURE MouseSetGraphCursor(HotX,HotY:WORD; VAR SCMask);
BEGIN
  Reg.AX:=9;
  Reg.BX:=HotX;
  Reg.CX:=HotY;
  Reg.DX:=Ofs(SCMask);
  Reg.ES:=Seg(SCMask);
  Intr($33,Reg);
END;

END.

