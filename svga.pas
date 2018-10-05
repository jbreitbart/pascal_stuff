
UNIT SVGA;
{$F+}

INTERFACE


USES DOS;


TYPE  COLORVALUE    = RECORD R,G,B : BYTE END;
      VGAPALETTETYP = ARRAY[0..255] OF COLORVALUE;

CONST MINX    : WORD = 0;
      MAXX    : WORD = 319;
      XWID    : WORD = 320;

      MINY    : WORD = 0;
      MAXY    : WORD = 199;
      YWID    : WORD = 200;

      SEGP    : WORD = $3CD; { PORTADRESSE F�R VIDEO- RAM- SEGMENT }

  CRTC = $3D4;
  SEQ  = $3C4;
  GDC  = $3CE;
  ISTA = $3DA;
  DMC  = $3D8;

CONST USEET4000      : BOOLEAN = FALSE;
      FASTSETPALETTE : BOOLEAN = TRUE;


VAR   VMOD    : BYTE;
      CHRHIG  : BYTE;


FUNCTION  CHECKVGA(MODE:BYTE):INTEGER;
FUNCTION  GETATC(IDX:BYTE):BYTE;
PROCEDURE SETATC(IDX,DATA:BYTE);
PROCEDURE VGASETPALETTE(VAR P : VGAPALETTETYP; START,STOP : BYTE);
PROCEDURE VGAGETPALETTE(VAR P : VGAPALETTETYP);
PROCEDURE VERLAUF(VAR P:VGAPALETTETYP;F1,R1,G1,B1,F2,R2,G2,B2:BYTE);
PROCEDURE SETSEG(NR:BYTE);
PROCEDURE SETSEGS(RD,WR:BYTE);
PROCEDURE MOVSEG(VON,NACH:BYTE);
PROCEDURE HIFILL(VON:LONGINT;WID:WORD;FILL:CHAR);
PROCEDURE HIMOVE(VON,BIS:LONGINT;WID:WORD);
PROCEDURE RAMTOVGA(VON:POINTER;BIS:LONGINT;WID:WORD);
PROCEDURE VGATORAM(VON:POINTER;BIS:LONGINT;WID:WORD);
FUNCTION  GETPIXEL(X,Y:WORD):BYTE;
PROCEDURE PLOT(X,Y:WORD;FARBE:BYTE);
PROCEDURE XPLOT(X,Y:WORD;FARBE:BYTE);
PROCEDURE OVERSCAN(FARBE:BYTE);
PROCEDURE ROTIERE(VAR PAL:VGAPALETTETYP;VON,BIS:BYTE;RUECKWAERTS:BOOLEAN);
PROCEDURE ABBLENDEN(VAR PAL:VGAPALETTETYP;STUFEN:WORD;AB:BOOLEAN);

PROCEDURE SET320X200;
PROCEDURE SET640X350;
PROCEDURE SET640X400;
PROCEDURE SET640X480;
PROCEDURE SET800X600;
PROCEDURE SET1024X768;

PROCEDURE SETFONT(HIG:BYTE);
PROCEDURE WRITECHAR(CHR:CHAR;X,Y:WORD;FARBE:BYTE);
PROCEDURE WRITEFGBG(CHR:CHAR;X,Y:WORD;FG,BG:BYTE);
PROCEDURE XORWRITE(CHR:CHAR;X,Y:WORD;FG,BG:BYTE);
PROCEDURE XORTEXT(X,Y:WORD;FG,BG:BYTE;TXT:STRING);
PROCEDURE FGBGTEXT(X,Y:WORD;FG,BG:BYTE;TXT:STRING);
PROCEDURE GRAPHTEXT(X,Y:WORD;FARBE:BYTE;TXT:STRING);
PROCEDURE DOPPTEXT(X,Y:WORD;FARBE:BYTE;TXT:STRING);

PROCEDURE STI;   INLINE($FB);
PROCEDURE CLI;   INLINE($FA);

{
  VSYNCH UND HSYNCH SIND NICHT F�R MDA / HERCULES GEEIGNET !
  DAF�R MU� PORTADRESSE 3BAH VERWANDT WERDEN
}
PROCEDURE HSYNCH;
INLINE($BA/$3DA/  {        MOV  DX,3DAH }
       $EC/       { LOOP1: IN   AL,DX   }
       $A8/1/     {        TEST AL,1    }
       $75/$FB/   {        JNZ  LOOP1   }
       $EC/       { LOOP2: IN   AL,DX   }
       $A8/1/     {        TEST AL,1    }
       $74/$FB    {        JZ   LOOP2   }
      );


PROCEDURE VSYNCH;
INLINE($BA/$3DA/  {        MOV  DX,3DAH }
       $EC/       { LOOP1: IN   AL,DX   }
       $A8/8/     {        TEST AL,8    }
       $75/$FB/   {        JNZ  LOOP1   }
       $EC/       { LOOP2: IN   AL,DX   }
       $A8/8/     {        TEST AL,8    }
       $74/$FB    {        JZ   LOOP2   }
      );


IMPLEMENTATION


TYPE  VADDR = RECORD
        A    : WORD;
        S    : BYTE;
        DUM  : BYTE;
      END;

      BYTEARRAY = ARRAY[0..1] OF BYTE;
      BYTEARRP  = ^BYTEARRAY;


CONST BITMSK  : ARRAY[0..7] OF BYTE = ($80,$40,$20,$10,8,4,2,1);
      BITMSK1 : ARRAY[0..7] OF BYTE = (1,2,4,8,$10,$20,$40,$80);


VAR   AS    : BYTE;
      VA    : LONGINT;           { VIDEO- ADRESSE }
      V     : VADDR ABSOLUTE VA; { V.S = SEGMENT- ADRESSE }

      CHSP  : BYTEARRP;


{ SEGMENT DER VGA- KARTE F�R LESEN UND SCHREIBEN SETZEN }
PROCEDURE SETSEG(NR:BYTE);
BEGIN
  AS := NR;
  IF USEET4000 THEN BEGIN
    PORT[SEGP] := (NR SHL 4) + NR;
  END ELSE BEGIN
    PORT[SEGP] := (NR * 9) OR $40;
  END;
(*
  IF USEET4000 THEN BEGIN
    PORT[SEGP] := (NR AND $0F) SHL 4 + (NR AND $0F);
  END ELSE BEGIN
    PORT[SEGP] := ((NR AND $07) SHL 3 + (NR AND $07)) OR $40;
  END;
*)
END; { SETSEG }


{ UNTERSCHIEDLICHE SEGMENTE DER VGA- KARTE F�R LESEN UND SCHREIBEN SETZEN }
PROCEDURE SETSEGS(RD,WR:BYTE);
BEGIN
  IF USEET4000 THEN BEGIN
    PORT[SEGP] := (RD AND $0F) SHL 4 + (WR AND $0F);
  END ELSE BEGIN
    PORT[SEGP] := ((RD AND $07) SHL 3 + (WR AND $07)) OR $40;
  END;
END; { SETSEGS }


{ EINEN BILDSCHIRMINHALT VON VIDEORAM SEGMENT VON
  NACH SEGMENT NACH KOPIEREN - HIGHSPEED }
PROCEDURE MOVSEG(VON,NACH:BYTE);
VAR   I  : WORD;
BEGIN
  IF USEET4000 THEN BEGIN
    PORT[SEGP] := (VON AND $0F) SHL 4 + (NACH AND $0F);
  END ELSE BEGIN
    PORT[SEGP] := ((VON AND $07) SHL 3 + (NACH AND $07)) OR $40;
  END;
  MOVE(MEM[$A000:0],MEM[$A000:0],65535);
  MEM[$A000:$FFFF] := MEM[$A000:$FFFF];
  SETSEG(0);
END; { MOVSEG }


PROCEDURE HIFILL(VON:LONGINT;WID:WORD;FILL:CHAR);
VAR   BIS  : LONGINT;
      J,K  : WORD;
BEGIN
  SETSEG(VADDR(VON).S);
  BIS := VON + LONGINT(WID);
  IF VADDR(VON).S = VADDR(BIS).S THEN BEGIN
    FILLCHAR(MEM[$A000:VON],WID,FILL);
  END ELSE BEGIN
    J := VADDR(BIS).A;
    K := WID - J;
    FILLCHAR(MEM[$A000:VON],K,FILL);
    SETSEG(VADDR(BIS).S);
    FILLCHAR(MEM[$A000:0],J,FILL);
  END;
END; { HIFILL }


PROCEDURE HIMOVE(VON,BIS:LONGINT;WID:WORD);
VAR   BUF    : ARRAY[0..1023] OF BYTE;
      J,K    : WORD;
      V2,B2  : LONGINT;
BEGIN
  V2 := VON + LONGINT(WID);
  B2 := BIS + LONGINT(WID);

  SETSEG(VADDR(VON).S);
  IF VADDR(VON).S <> VADDR(V2).S THEN BEGIN
    J := VADDR(V2).A;
    K := WID - J;
    MOVE(MEM[$A000:VON],BUF,K);
    SETSEG(VADDR(V2).S);
    MOVE(MEM[$A000:0],BUF[K],J);
  END ELSE BEGIN
    IF (AS = VADDR(BIS).S) AND (AS = VADDR(B2).S) THEN BEGIN
      MOVE(MEM[$A000:VON],MEM[$A000:BIS],WID);
      EXIT;
    END;
    MOVE(MEM[$A000:VON],BUF,WID);
  END;

  SETSEG(VADDR(BIS).S);
  IF VADDR(BIS).S = VADDR(B2).S THEN BEGIN
    MOVE(BUF,MEM[$A000:BIS],WID);
  END ELSE BEGIN
    J := VADDR(B2).A;
    K := WID - J;
    MOVE(BUF,MEM[$A000:BIS],K);
    SETSEG(VADDR(B2).S);
    MOVE(BUF[K],MEM[$A000:0],J);
  END;
END; { HIMOVE }


PROCEDURE RAMTOVGA(VON:POINTER;BIS:LONGINT;WID:WORD);
TYPE  SOF    = RECORD O,S : WORD; END;
VAR   J,K    : WORD;
      B2     : LONGINT;
      V2     : POINTER;
BEGIN
  B2 := BIS + LONGINT(WID);

  SETSEG(VADDR(BIS).S);
  IF VADDR(BIS).S = VADDR(B2).S THEN BEGIN
    MOVE(VON^,MEM[$A000:BIS],WID);
  END ELSE BEGIN
    J := VADDR(B2).A;
    K := WID - J;
    MOVE(VON^,MEM[$A000:BIS],K);
    SETSEG(VADDR(B2).S);
    V2 := VON; INC(SOF(V2).O,K);
    MOVE(V2^,MEM[$A000:0],J);
  END;
END; { RAMTOVGA }


PROCEDURE VGATORAM(VON:POINTER;BIS:LONGINT;WID:WORD);
TYPE  SOF    = RECORD O,S : WORD; END;
VAR   J,K    : WORD;
      B2     : LONGINT;
      V2     : POINTER;
BEGIN
  B2 := BIS + LONGINT(WID);

  SETSEG(VADDR(BIS).S);
  IF VADDR(BIS).S = VADDR(B2).S THEN BEGIN
    MOVE(MEM[$A000:BIS],VON^,WID);
  END ELSE BEGIN
    J := VADDR(B2).A;
    K := WID - J;
    MOVE(MEM[$A000:BIS],VON^,K);
    SETSEG(VADDR(B2).S);
    V2 := VON; INC(SOF(V2).O,K);
    MOVE(MEM[$A000:0],V2^,J);
  END;
END; { VGATORAM }


FUNCTION GETPIXEL(X,Y:WORD):BYTE;
BEGIN
  INLINE($A1/XWID/     {     MOV AX,[XWID] }
         $8B/$9E/Y/    {     MOV BX,[BP+Y] }
         $F7/$E3/      {     MUL BX        }
         $03/$86/X/    {     ADD AX,[BP+X] }
         $73/$01/      {     JNC L1        }
         $42/          { L1: INC DX        }
         $A3/VA/       {     MOV [VA],AX   }
         $89/$16/VA+2  {     MOV [VA+2],DX }
        );
  IF V.S <> AS THEN SETSEG(V.S);
  INLINE($B8/$A000/    { MOV AX,A000       }
         $8E/$C0/      { MOV ES,AX         }
         $8B/$3E/VA/   { MOV DI,[VA]       }
         $26/$8A/$05/  { MOV AL,ES:[DI]    }
         $88/$46/$FF   { MOV [BP-1],AL     }
        );
END; { GETPIXEL }


PROCEDURE PLOT(X,Y:WORD;FARBE:BYTE);
BEGIN
  INLINE($A1/XWID/     {     MOV AX,[XWID] }
         $8B/$9E/Y/    {     MOV BX,[BP+Y] }
         $F7/$E3/      {     MUL BX        }
         $03/$86/X/    {     ADD AX,[BP+X] }
         $73/$01/      {     JNC L1        }
         $42/          { L1: INC DX        }
         $A3/VA/       {     MOV [VA],AX   }
         $89/$16/VA+2  {     MOV [VA+2],DX }
        );
  IF V.S <> AS THEN SETSEG(V.S);
  INLINE($B8/$A000/    { MOV AX,A000       }
         $8E/$C0/      { MOV ES,AX         }
         $8B/$3E/VA/   { MOV DI,[VA]       }
         $8A/$86/FARBE/{ MOV AL,[BP+FARBE] }
         $26/$88/$05   { MOV ES:[DI],AL    }
        );
END; { PLOT }


PROCEDURE XPLOT(X,Y:WORD;FARBE:BYTE);
BEGIN
  INLINE($A1/XWID/     {     MOV AX,[XWID] }
         $8B/$9E/Y/    {     MOV BX,[BP+Y] }
         $F7/$E3/      {     MUL BX        }
         $03/$86/X/    {     ADD AX,[BP+X] }
         $73/$01/      {     JNC L1        }
         $42/          { L1: INC DX        }
         $A3/VA/       {     MOV [VA],AX   }
         $89/$16/VA+2  {     MOV [VA+2],DX }
        );
  IF V.S <> AS THEN SETSEG(V.S);
  INLINE($B8/$A000/    { MOV AX,A000       }
         $8E/$C0/      { MOV ES,AX         }
         $8B/$3E/VA/   { MOV DI,[VA]       }
         $8A/$86/FARBE/{ MOV AL,[BP+FARBE] }
         $26/$30/$05   { XOR ES:[DI],AL    }
        );
END; { PLOT }



FUNCTION VIDADAP:WORD; EXTERNAL;
{$L VIDEOID}


{
  CHECKVGA ERSETZT PROCEDURE MODUS, TESTET ABER AUCH DIE VGA- KARTE
  ERGEBNIS : -1 = KEINE VGA
             -2 = VIDEO- RAM- FEHLER
              0 = KEINE SEGMENT- ZUGRIFFE M�GLICH
             >0 = ANZAHL VIDEO- SEGMENTE
}
FUNCTION  CHECKVGA(MODE:BYTE):INTEGER;
VAR   V  : BYTE ABSOLUTE $A000:$FFFF;
      I  : BYTE;
      R  : REGISTERS;

FUNCTION CHECKSEG(ANZ:BYTE):BOOLEAN;
VAR   B  : BYTE;
BEGIN
  CHECKSEG := FALSE;
  FOR B := 0 TO ANZ DO BEGIN
    SETSEG(B);
    V := B;
  END; { NEXT B }
  FOR B := 0 TO ANZ DO BEGIN
    SETSEG(B);
    IF V <> B THEN EXIT;
  END; { NEXT B }
  CHECKSEG := TRUE;
END; { CHECKSEG }

BEGIN { CHECKVGA }
  CHECKVGA := -1;
  IF NOT ( HI(VIDADAP) IN [7,8,11,12] ) THEN EXIT;

VSYNCH;
  R.AL := MODE; { VIDEOMODUS }
  R.AH := $00;
  INTR($10,R);  { SETZEN }

  CHECKVGA := -2;
  SETSEG(1);
  V := $33;
  IF V <> $33 THEN BEGIN
    V := 0;
    USEET4000 := TRUE;
    SETSEG(1);
    V := $33;
    IF V <> $33 THEN EXIT;
  END;
  V := $AA;
  IF V <> $AA THEN EXIT;

  IF NOT CHECKSEG(3) THEN CHECKVGA := 0 ELSE
    IF NOT CHECKSEG(7) THEN CHECKVGA := 4 ELSE
      IF NOT CHECKSEG(15) THEN CHECKVGA := 8 ELSE
        CHECKVGA := 16;

  FOR I := 0 TO 15 DO BEGIN
    SETSEG(I);
    V := 0;
  END;

  SETSEG(0);
  MINX := 0; MAXX := PRED(XWID);
  MINY := 0; MAXY := PRED(YWID);
END; { CHECKVGA }


FUNCTION GETATC(IDX:BYTE):BYTE;
VAR   B  : BYTE;
BEGIN
  CLI;
  B := PORT[ISTA];
  PORT[$3C0] := IDX;
  B := PORT[$3C1];
  PORT[$3C0] := B;
  PORT[$3C0] := $20;
  STI;
  GETATC := B;
END; { GETATC }


PROCEDURE SETATC(IDX,DATA:BYTE);
VAR   B  : BYTE;
BEGIN
  CLI;
  B := PORT[ISTA];
  PORT[$3C0] := IDX;
  PORT[$3C0] := DATA;
  PORT[$3C0] := $20;
  STI;
END; { SETATC }


PROCEDURE VGASETPALETTE(VAR P : VGAPALETTETYP; START,STOP : BYTE);
BEGIN
  VSYNCH;
{
    F�R LOKALE VARIABLE UND PROZEDUR- PARAMETER MU� DIE BASEPOINTER- INDIREKTE
  ADRESSIERUNG VERWANDT WERDEN.
    SOLANGE NUR GLOBALE VARIABLE ALS PALETTE �BERGEBEN WERDEN, W�RDE DIE
  ADRESSIERUNG �BER DAS DATASEGMENT AUSREICHEN, ABER MIT DEM EXTRASEGMENT
  K�NNEN AUCH LOKALE VARIABLE ALS PALETTE BENUTZT WERDEN.
}
  INLINE($8E/$86/P+2/    { MOV ES,[BP+P+2]   }
         $8A/$86/START/  { MOV AL,[BP+START] }
         $28/$E4/        { SUB AH,AH         }
         $BA/$3C8/       { MOV DX,3C8H       }
         $EE/            { OUT DX,AL         }
         $89/$C1/        { MOV CX,AX         }
         $01/$C0/        { ADD AX,AX ; START * 2 }
         $01/$C8/        { ADD AX,CX ; START * 3 }
         $03/$86/P/      { ADD AX,[BP+P]     }
         $89/$C6         { MOV SI,AX         }
        );
  INLINE($8A/$86/STOP/   { MOV AL,[BP+STOP]  }
         $28/$E4/        { SUB AH,AH         }
         $40/            { INC AX            }
         $8A/$8E/START/  { MOV CL,[BP+START] }
         $28/$ED/        { SUB CH,CH         }
         $29/$C8/        { SUB AX,CX         }
         $89/$C1/        { MOV CX,AX         }
         $01/$C9/        { ADD CX,CX ; * 2   }
         $01/$C1/        { ADD CX,AX ; * 3   }
         $FC/            { CLD               }
         $BA/$3C9/       { MOV DX,3C9H       }
         $26/$F3/$6E     { REP OUTSB ES:     }
        );
END; { VGASETPALETTE }


PROCEDURE VGAGETPALETTE(VAR P : VGAPALETTETYP);
VAR   R  : REGISTERS;
BEGIN
  R.AX := $1017;
  R.BX := 0;
  R.CX := 256;
  R.ES := SEG(P);
  R.DX := OFS(P);
  INTR($10,R);
END; { VGAGETPALETTE }


PROCEDURE VERLAUF(VAR P:VGAPALETTETYP;F1,R1,G1,B1,F2,R2,G2,B2:BYTE);
VAR   I   : BYTE;
      NR  : INTEGER;
BEGIN
  NR := F2 - F1;
  IF NR < 1 THEN EXIT;
  FOR I := 0 TO NR DO BEGIN
    P[F1 + I].R := (R1 * ( NR - I ) + R2 * I) DIV NR;
    P[F1 + I].G := (G1 * ( NR - I ) + G2 * I) DIV NR;
    P[F1 + I].B := (B1 * ( NR - I ) + B2 * I) DIV NR;
  END; { NEXT I }
END; { VERLAUF }


PROCEDURE SET320X200;
BEGIN
  VMOD := $13;
  XWID := 320;
  YWID := 200;
END; { SET320X200 }

PROCEDURE SET640X350;
BEGIN
  VMOD := $2D;
  XWID := 640;
  YWID := 350;
END; { SET640X350 }

PROCEDURE SET640X400;
BEGIN
  VMOD := $2F;
  XWID := 640;
  YWID := 400;
END; { SET640X400 }

PROCEDURE SET640X480;
BEGIN
  VMOD := $2E;
  XWID := 640;
  YWID := 480;
END; { SET640X480 }

PROCEDURE SET800X600;
BEGIN
  VMOD := $30;
  XWID := 800;
  YWID := 600;
END; { SET800X600 }

PROCEDURE SET1024X768;
BEGIN
  IF NOT USEET4000 THEN BEGIN
    SET800X600;
  END ELSE BEGIN
    VMOD := $38;
    XWID := 1024;
    YWID := 768;
  END;
END; { SET1024X768 }


PROCEDURE OVERSCAN(FARBE:BYTE);
VAR   R  : REGISTERS;
BEGIN
  R.AX := $1001;
  R.BH := FARBE;
  INTR($10,R);
END; { OVERSCAN }


PROCEDURE ROTIERE(VAR PAL:VGAPALETTETYP;VON,BIS:BYTE;RUECKWAERTS:BOOLEAN);
VAR   COL  : COLORVALUE;
BEGIN
  IF RUECKWAERTS THEN BEGIN
    COL := PAL[BIS];
    MOVE(PAL[VON],PAL[SUCC(VON)],SIZEOF(VGAPALETTETYP) - 3 * (256 - BIS + VON));
    PAL[VON] := COL;
  END ELSE BEGIN
    COL := PAL[VON];
    MOVE(PAL[SUCC(VON)],PAL[VON],SIZEOF(VGAPALETTETYP) - 3 * (256 - BIS + VON));
    PAL[BIS] := COL;
  END;
  IF FASTSETPALETTE OR ((BIS - VON) < 128) THEN BEGIN
    VGASETPALETTE(PAL,VON,BIS);
  END ELSE BEGIN
    VGASETPALETTE(PAL,VON,(BIS - VON) SHR 1);
    VGASETPALETTE(PAL,SUCC((BIS - VON) SHR 1),BIS);
  END;
END; { ROTIERE }


PROCEDURE ABBLENDEN(VAR PAL:VGAPALETTETYP;STUFEN:WORD;AB:BOOLEAN);
VAR   J  : WORD;

PROCEDURE BLENDEN;
VAR   I  : BYTE;
      P  : VGAPALETTETYP; { DIE VARIABLE P MU� HIER LOKAL DEFINIERT SEIN }
BEGIN
  P := PAL;
  FOR I := 0 TO 255 DO BEGIN
    WITH P[I] DO BEGIN
      R := (WORD(R) * J) DIV STUFEN;
      G := (WORD(G) * J) DIV STUFEN;
      B := (WORD(B) * J) DIV STUFEN;
    END; { WITH P[I] }
  END; { NEXT I }
  IF FASTSETPALETTE THEN BEGIN
    VGASETPALETTE(P,0,255);
  END ELSE BEGIN
    VGASETPALETTE(P,0,127);
    VGASETPALETTE(P,128,255);
  END;
END; { BLENDEN }

BEGIN { BLENDE }
  IF AB THEN FOR J := STUFEN DOWNTO 0 DO BLENDEN
        ELSE FOR J := 0 TO STUFEN DO BLENDEN;
END; { ABBLENDE }


PROCEDURE SETFONT(HIG:BYTE);
VAR   R  : REGISTERS;
BEGIN
  WITH R DO BEGIN
    CHRHIG := HIG;
    CASE HIG OF
       8 : BX := $300;
      14 : BX := $200;
      16 : BX := $600;
    ELSE
      CHRHIG := 16;
      BX := $600;
    END; { CASE HIG }
    AX := $1130;
    INTR($10,R);
    CHSP := PTR(ES,BP);
  END; { WITH R }
END; { SETFONT }


PROCEDURE WRITECHAR(CHR:CHAR;X,Y:WORD;FARBE:BYTE);
VAR   I,J,B,BM  : BYTE;
      Z         : WORD;
BEGIN
  Z  := Y;
  FOR I := 0 TO PRED(CHRHIG) DO BEGIN
    BM := $80;
    B  := CHSP^[BYTE(CHR)*CHRHIG + I];
    FOR J := 0 TO 7 DO BEGIN
      IF B AND BM <> 0 THEN PLOT(X+J,Z,FARBE);
      BM := BM SHR 1;
    END; { NEXT J }
    INC(Z);
  END; { NEXT I }
END; { WRITECHAR }


PROCEDURE WRITEFGBG(CHR:CHAR;X,Y:WORD;FG,BG:BYTE);
VAR   I,J,B,BM  : BYTE;
      Z         : WORD;
BEGIN
  Z  := Y;
  FOR I := 0 TO PRED(CHRHIG) DO BEGIN
    BM := $80;
    B  := CHSP^[BYTE(CHR)*CHRHIG + I];
    FOR J := 0 TO 7 DO BEGIN
      IF B AND BM = 0 THEN PLOT(X+J,Z,BG)
                      ELSE PLOT(X+J,Z,FG);
      BM := BM SHR 1;
    END; { NEXT J }
    INC(Z);
  END; { NEXT I }
END; { WRITEFGBG }


PROCEDURE XORWRITE(CHR:CHAR;X,Y:WORD;FG,BG:BYTE);
VAR   I,J,B,BM  : BYTE;
      Z         : WORD;
BEGIN
  Z  := Y;
  FOR I := 0 TO PRED(CHRHIG) DO BEGIN
    BM := $80;
    B  := CHSP^[BYTE(CHR)*CHRHIG + I];
    FOR J := 0 TO 7 DO BEGIN
      IF B AND BM = 0 THEN XPLOT(X+J,Z,BG)
                      ELSE XPLOT(X+J,Z,FG);
      BM := BM SHR 1;
    END; { NEXT J }
    INC(Z);
  END; { NEXT I }
END; { XORWRITE }


PROCEDURE WRITECHAR1(CHR:CHAR;X,Y:WORD;FARBE:BYTE);
VAR   I,J  : BYTE;
BEGIN
  FOR I := 0 TO PRED(CHRHIG) DO BEGIN
    FOR J := 0 TO 7 DO
      IF CHSP^[BYTE(CHR)*CHRHIG+PRED(CHRHIG)-I] AND BITMSK1[J] <> 0
        THEN PLOT(X+J,Y+I,FARBE);
  END; { NEXT I }
END; { WRITECHAR1 }


PROCEDURE DOPPCHAR(CHR:CHAR;X,Y:WORD;FARBE:BYTE);
VAR   I,J,B,BM  : BYTE;
      Z0,Z      : WORD;
BEGIN
  Z  := Y;
  FOR I := 0 TO PRED(CHRHIG) DO BEGIN
    BM := $80;
    B  := CHSP^[BYTE(CHR)*CHRHIG + I];
    FOR J := 0 TO 7 DO BEGIN
      IF B AND BM <> 0 THEN BEGIN
        Z0 := X + (J SHL 1);
        PLOT(     Z0 ,     Z ,FARBE);
        PLOT(SUCC(Z0),     Z ,FARBE);
        PLOT(     Z0 ,SUCC(Z),FARBE);
        PLOT(SUCC(Z0),SUCC(Z),FARBE);
      END;
      BM := BM SHR 1;
    END; { NEXT J }
    INC(Z,2);
  END; { NEXT I }
END; { DOPPCHAR }


PROCEDURE GRAPHTEXT(X,Y:WORD;FARBE:BYTE;TXT:STRING);
VAR   I  : BYTE;
BEGIN
  FOR I := 1 TO LENGTH(TXT) DO WRITECHAR(TXT[I],X + 8 * PRED(I),Y,FARBE);
END; { GRAPHTEXT }


PROCEDURE FGBGTEXT(X,Y:WORD;FG,BG:BYTE;TXT:STRING);
VAR   I  : BYTE;
BEGIN
  FOR I := 1 TO LENGTH(TXT) DO WRITEFGBG(TXT[I],X + 8 * PRED(I),Y,FG,BG);
END; { FGBGTEXT }


PROCEDURE XORTEXT(X,Y:WORD;FG,BG:BYTE;TXT:STRING);
VAR   I  : BYTE;
BEGIN
  FOR I := 1 TO LENGTH(TXT) DO XORWRITE(TXT[I],X + 8 * PRED(I),Y,FG,BG);
END; { XORTEXT }


PROCEDURE DOPPTEXT(X,Y:WORD;FARBE:BYTE;TXT:STRING);
VAR   I  : BYTE;
BEGIN
  FOR I := 1 TO LENGTH(TXT) DO DOPPCHAR(TXT[I],X + 16 * PRED(I),Y,FARBE);
END; { DOPPTEXT }


BEGIN
  AS := PORT[SEGP];
  SET320X200;
  SETFONT(14);
END.

