
UNIT SVGA1;
{$F+}

INTERFACE


USES  DOS;


TYPE  COLORVALUE    = RECORD R,G,B : BYTE END;
      VGAPALETTETYP = ARRAY[0..255] OF COLORVALUE;

TYPE   VMREGS   = ARRAY[1..4] OF WORD;
TYPE   VMARRAY  = ARRAY[1..5] OF VMREGS;

CONST  VIDMODES : ARRAY[1..13] OF VMARRAY =
       ({ VGATYP 1 = ATI }
        ({ MODE 1 :  640 * 350 }(0,0,0,0),
         { MODE 2 :  640 * 400 }($61,0,0,0),
         { MODE 3 :  640 * 480 }($62,0,0,0),
         { MODE 4 :  800 * 600 }($63,0,0,0),
         { MODE 5 : 1024 * 768 }($64,0,0,0)),
        { VGATYP 2 = EVEREX }
        (($70,$13,0,0),($70,$14,0,0),($70,$30,0,0),($70,$31,0,0),(0,0,0,0)),
        { VGATYP 3 = TRIDENT }
        ((0,0,0,0),($5C,0,0,0),($5D,0,0,0),($5E,0,0,0),($62,0,0,0)),
        { VGATYP 4 = VIDEO7 }
        ((0,0,0,0),($6F05,$66,0,0),($6F05,$67,0,0),($6F05,$69,0,0),(0,0,0,0)),
        { VGATYP 5 = PARADISE }
        ((0,0,0,0),($5E,0,0,0),($5F,0,0,0),(0,0,0,0),(0,0,0,0)),
        { VGATYP 6 = CHIPSTECH }
        ((0,0,0,0),($78,0,0,0),($79,0,0,0),($7B,0,0,0),(0,0,0,0)),
        { VGATYP 7 = TSENG }
        (($2D,0,0,0),($2F,0,0,0),($2E,0,0,0),($30,0,0,0),($38,0,0,0)),
        { VGATYP 8 = TSENG4 }
        (($2D,0,0,0),($2F,0,0,0),($2E,0,0,0),($30,0,0,0),($38,0,0,0)),
        { VGATYP  9 = AHEADA }
        ((0,0,0,0),($60,0,0,0),($61,0,0,0),($62,0,0,0),($63,0,0,0)),
        { VGATYP 10 = AHEADB }
        ((0,0,0,0),($60,0,0,0),($61,0,0,0),($62,0,0,0),($63,0,0,0)),
        { VGATYP 11 = OAKTECH }
        ((0,0,0,0),(0,0,0,0),($53,0,0,0),($54,0,0,0),(0,0,0,0)),
        { VGATYP 12 = CIRRUS }
        ((0,0,0,0),(0,0,0,0),(0,0,0,0),(0,0,0,0),(0,0,0,0)),
        { VGATYP 13 = USER DEFINED }
        ((0,0,0,0),(0,0,0,0),(0,0,0,0),(0,0,0,0),(0,0,0,0))
       );

{ VGATYP :
  1 = ATI
  2 = EVEREX
  3 = TRIDENT
  4 = VIDEO7
  5 = PARADISE
  6 = CHIPSTECH
  7 = TSENG
  8 = TSENG4
  9 = AHEADA
 10 = AHEADB
 11 = OAKTECH
 12 = CIRRUS
}


CONST CRTC = $3D4;
      SEQ  = $3C4;
      GDC  = $3CE;
      ISTA = $3DA;
      DMC  = $3D8;

CONST FASTSETPALETTE : BOOLEAN = TRUE;


VAR   VMOD    : BYTE;
      CHRHIG  : BYTE;

VAR   CURBK,VGA512,VGATYP  : WORD;
      XWID,YWID,MINX,MINY,
      MAXX,MAXY            : WORD;



FUNCTION  WHICHVGA:BYTE;
PROCEDURE NEWBANK(BANK:WORD);

PROCEDURE POINT(X,Y,COL:WORD);
PROCEDURE XPOINT(X,Y,COL:WORD);
PROCEDURE POINT13X(X,Y,COL:WORD);
PROCEDURE XPOINT13X(X,Y,COL:WORD);

FUNCTION  RDPOINT(X,Y:WORD):BYTE;
FUNCTION  RDPOINT13X(X,Y:WORD):BYTE;

PROCEDURE BLINE(X1,Y1,X2,Y2,COL:WORD;FUNC:POINTER);

PROCEDURE SETVMODE(MODE:BYTE);


FUNCTION  CHECKVGA:INTEGER;
PROCEDURE GRAPHMODE(MODE:BYTE);
PROCEDURE SUCHMODE(VON:BYTE);
FUNCTION  GETATC(IDX:BYTE):BYTE;
PROCEDURE SETATC(IDX,DATA:BYTE);
PROCEDURE VGASETPALETTE(VAR P : VGAPALETTETYP; START,STOP : BYTE);
PROCEDURE VGAGETPALETTE(VAR P : VGAPALETTETYP);
PROCEDURE VERLAUF(VAR P:VGAPALETTETYP;F1,R1,G1,B1,F2,R2,G2,B2:BYTE);
PROCEDURE HIFILL(VON:LONGINT;WID:WORD;FILL:CHAR);
PROCEDURE HIMOVE(VON,BIS:LONGINT;WID:WORD);
PROCEDURE RAMTOVGA(VON:POINTER;BIS:LONGINT;WID:WORD);
PROCEDURE VGATORAM(VON:POINTER;BIS:LONGINT;WID:WORD);
PROCEDURE OVERSCAN(FARBE:BYTE);
PROCEDURE ROTIERE(VAR PAL:VGAPALETTETYP;VON,BIS:BYTE;RUECKWAERTS:BOOLEAN);
PROCEDURE ABBLENDEN(VAR PAL:VGAPALETTETYP;STUFEN:WORD;AB:BOOLEAN);

PROCEDURE MODE360X400;
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

FUNCTION  CPU_TYPE:INTEGER;

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

CONST PROC86  : BOOLEAN = FALSE;


VAR   AS    : BYTE;
      VA    : LONGINT;           { VIDEO- ADRESSE }
      V     : VADDR ABSOLUTE VA; { V.S = SEGMENT- ADRESSE }

      CHSP  : BYTEARRP;


VAR   CIRRUS,VIDEO7,TSENG,TSENG4,
      PARADISE,CHIPSTECH,TRIDENT,
      ATIVGA,EVEREX,AHEADA,AHEADB,
      OAKTECH                      : WORD;


{$L BANKS}
PROCEDURE NEWBANK(BANK:WORD);     EXTERNAL;
FUNCTION  WHICHVGA:BYTE;          EXTERNAL;

{$L POINT}
PROCEDURE POINT(X,Y,COL:WORD);    EXTERNAL;
PROCEDURE XPOINT(X,Y,COL:WORD);   EXTERNAL;
PROCEDURE POINT13X(X,Y,COL:WORD); EXTERNAL;
PROCEDURE XPOINT13X(X,Y,COL:WORD); EXTERNAL;

{$L RDPOINT}
FUNCTION  RDPOINT(X,Y:WORD):BYTE;    EXTERNAL;
FUNCTION  RDPOINT13X(X,Y:WORD):BYTE; EXTERNAL;

{$L LINE}
PROCEDURE BLINE(X1,Y1,X2,Y2,COL:WORD;FUNC:POINTER); EXTERNAL;

{$L MODE13X}
PROCEDURE MODE13X; EXTERNAL;

{$L GETCPU}
FUNCTION CPU_TYPE:INTEGER; EXTERNAL;


PROCEDURE SETVMODE(MODE:BYTE);
VAR   R  : REGISTERS;
BEGIN
  IF MODE = 0 THEN BEGIN
    R.AX := $13;
    R.BX := 0;
    R.CX := 0;
    R.DX := 0;
  END ELSE BEGIN
    R.AX := VIDMODES[VGATYP][MODE][1];
    R.BX := VIDMODES[VGATYP][MODE][2];
    R.CX := VIDMODES[VGATYP][MODE][3];
    R.DX := VIDMODES[VGATYP][MODE][4];
  END;
  INTR($10,R);
END; { SETVMODE }


PROCEDURE HIFILL(VON:LONGINT;WID:WORD;FILL:CHAR);
VAR   BIS  : LONGINT;
      J,K  : WORD;
BEGIN
  NEWBANK(VADDR(VON).S);
  BIS := VON + LONGINT(WID);
  IF VADDR(VON).S = VADDR(BIS).S THEN BEGIN
    FILLCHAR(MEM[$A000:VON],WID,FILL);
  END ELSE BEGIN
    J := VADDR(BIS).A;
    K := WID - J;
    FILLCHAR(MEM[$A000:VON],K,FILL);
    NEWBANK(VADDR(BIS).S);
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

  NEWBANK(VADDR(VON).S);
  IF VADDR(VON).S <> VADDR(V2).S THEN BEGIN
    J := VADDR(V2).A;
    K := WID - J;
    MOVE(MEM[$A000:VON],BUF,K);
    NEWBANK(VADDR(V2).S);
    MOVE(MEM[$A000:0],BUF[K],J);
  END ELSE BEGIN
    IF (AS = VADDR(BIS).S) AND (AS = VADDR(B2).S) THEN BEGIN
      MOVE(MEM[$A000:VON],MEM[$A000:BIS],WID);
      EXIT;
    END;
    MOVE(MEM[$A000:VON],BUF,WID);
  END;

  NEWBANK(VADDR(BIS).S);
  IF VADDR(BIS).S = VADDR(B2).S THEN BEGIN
    MOVE(BUF,MEM[$A000:BIS],WID);
  END ELSE BEGIN
    J := VADDR(B2).A;
    K := WID - J;
    MOVE(BUF,MEM[$A000:BIS],K);
    NEWBANK(VADDR(B2).S);
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

  NEWBANK(VADDR(BIS).S);
  IF VADDR(BIS).S = VADDR(B2).S THEN BEGIN
    MOVE(VON^,MEM[$A000:BIS],WID);
  END ELSE BEGIN
    J := VADDR(B2).A;
    K := WID - J;
    MOVE(VON^,MEM[$A000:BIS],K);
    NEWBANK(VADDR(B2).S);
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

  NEWBANK(VADDR(BIS).S);
  IF VADDR(BIS).S = VADDR(B2).S THEN BEGIN
    MOVE(MEM[$A000:BIS],VON^,WID);
  END ELSE BEGIN
    J := VADDR(B2).A;
    K := WID - J;
    MOVE(MEM[$A000:BIS],VON^,K);
    NEWBANK(VADDR(B2).S);
    V2 := VON; INC(SOF(V2).O,K);
    MOVE(MEM[$A000:0],V2^,J);
  END;
END; { VGATORAM }



FUNCTION VIDADAP:WORD; EXTERNAL;
{$L VIDEOID}


{
  ERGEBNIS : -1 = KEINE VGA
             -2 = VIDEO- RAM- FEHLER
              0 = KEINE SEGMENT- ZUGRIFFE M�GLICH
             >0 = ANZAHL VIDEO- SEGMENTE
}
FUNCTION  CHECKVGA:INTEGER;
BEGIN { CHECKVGA }
  CHECKVGA := -1;
  IF NOT ( HI(VIDADAP) IN [7,8,11,12] ) THEN EXIT;

  IF WHICHVGA = 0 THEN BEGIN
    CHECKVGA := 0;
    EXIT;
  END;
  IF VGA512 = 0 THEN CHECKVGA := 4
                ELSE CHECKVGA := 8;
END; { CHECKVGA }


PROCEDURE GRAPHMODE(MODE:BYTE);
VAR   V  : BYTE ABSOLUTE $A000:$FFFF;

FUNCTION CHECKSEG(ANZ:BYTE):BOOLEAN;
VAR   B  : BYTE;
BEGIN
  CHECKSEG := FALSE;
  FOR B := 0 TO ANZ DO BEGIN
    NEWBANK(B);
    V := B;
  END; { NEXT B }
  FOR B := 0 TO ANZ DO BEGIN
    NEWBANK(B);
    IF V <> B THEN EXIT;
    V := 0;
  END; { NEXT B }
  CHECKSEG := TRUE;
END; { CHECKSEG }

BEGIN { GRAPHMODE }
  SETVMODE(MODE);

  IF MODE > 0 THEN BEGIN
    IF NOT CHECKSEG(3) THEN BEGIN
      SET320X200;
      SETVMODE(MODE);
    END;
    IF MODE > 2 THEN BEGIN
      IF NOT CHECKSEG(7) THEN BEGIN
        VIDMODES[VGATYP][3][1] := 0;
        VIDMODES[VGATYP][4][1] := 0;
        VIDMODES[VGATYP][5][1] := 0;
        SUCHMODE(MODE);
        SETVMODE(MODE);
      END;
      IF MODE = 5 THEN BEGIN
        IF NOT CHECKSEG(15) THEN BEGIN
          VIDMODES[VGATYP][5][1] := 0;
          SUCHMODE(MODE);
          SETVMODE(MODE);
        END;
      END;
    END;
  END; { IF MODE > 0 }

  NEWBANK(0);
  MINX := 0; MAXX := PRED(XWID);
  MINY := 0; MAXY := PRED(YWID);
END; { GRAPHMODE }


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
VAR   R  : REGISTERS;
BEGIN
  IF PROC86 THEN BEGIN
    R.AX := $1012;
    R.BX := START;
    R.CX := SUCC(STOP - START);
    R.ES := SEG(P);
    R.DX := OFS(P[START]);
    INTR($10,R);
    EXIT;
  END;
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


PROCEDURE SUCHMODE(VON:BYTE);
VAR   I  : BYTE;

FUNCTION GIBTHOEHER:BYTE;
VAR   J  : BYTE;
BEGIN
  GIBTHOEHER := 0;
  IF J = 5 THEN EXIT;
  J := SUCC(VON);
  REPEAT
    IF VIDMODES[VGATYP][J][1] <> 0 THEN BEGIN
      GIBTHOEHER := J;
      EXIT;
    END;
    INC(J);
  UNTIL J > 5;
END; { GIBTHOEHER }

BEGIN { SUCHMODE }
  CASE GIBTHOEHER OF
    0 : BEGIN
          IF VON <= 1 THEN BEGIN
            SET320X200;
          END ELSE BEGIN
            I := PRED(VON);
            WHILE (I > 0) AND (VIDMODES[VGATYP][I][1] = 0) DO DEC(I);
            CASE I OF
              0 : SET320X200;
              1 : SET640X350;
              2 : SET640X400;
              3 : SET640X480;
              4 : SET800X600;
            END; { CASE I }
          END;
        END;
    1 : SET640X350;
    2 : SET640X400;
    3 : SET640X480;
    4 : SET800X600;
    5 : SET1024X768;
  END; { CASE GIBTHOEHER }
END; { SUCHMODE }


PROCEDURE MODE360X400;
BEGIN
  MODE13X;
  VMOD := $FF;
  XWID := 360;
  YWID := 400;
  MINX := 0;
  MINY := 0;
  MAXX := PRED(XWID);
  MAXY := PRED(YWID);
END; { SET360X400 }


PROCEDURE SET320X200;
BEGIN
  VMOD := 0;
  XWID := 320;
  YWID := 200;
END; { SET320X200 }

PROCEDURE SET640X350;
BEGIN
  IF VIDMODES[VGATYP][1][1] = 0 THEN BEGIN
    SUCHMODE(1);
  END ELSE BEGIN
    VMOD := 1;
    XWID := 640;
    YWID := 350;
  END;
END; { SET640X350 }

PROCEDURE SET640X400;
BEGIN
  IF VIDMODES[VGATYP][2][1] = 0 THEN BEGIN
    SUCHMODE(2);
  END ELSE BEGIN
    VMOD := 2;
    XWID := 640;
    YWID := 400;
  END;
END; { SET640X400 }

PROCEDURE SET640X480;
BEGIN
  IF VIDMODES[VGATYP][3][1] = 0 THEN BEGIN
    SUCHMODE(3);
  END ELSE BEGIN
    VMOD := 3;
    XWID := 640;
    YWID := 480;
  END;
END; { SET640X480 }

PROCEDURE SET800X600;
BEGIN
  IF VIDMODES[VGATYP][4][1] = 0 THEN BEGIN
    SUCHMODE(4);
  END ELSE BEGIN
    VMOD := 4;
    XWID := 800;
    YWID := 600;
  END;
END; { SET800X600 }

PROCEDURE SET1024X768;
BEGIN
  IF VIDMODES[VGATYP][5][1] = 0 THEN BEGIN
    SUCHMODE(5);
  END ELSE BEGIN
    VMOD := 5;
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
      IF B AND BM <> 0 THEN POINT(X+J,Z,FARBE);
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
      IF B AND BM = 0 THEN POINT(X+J,Z,BG)
                      ELSE POINT(X+J,Z,FG);
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
      IF B AND BM = 0 THEN XPOINT(X+J,Z,BG)
                      ELSE XPOINT(X+J,Z,FG);
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
        THEN POINT(X+J,Y+I,FARBE);
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
        POINT(     Z0 ,     Z ,FARBE);
        POINT(SUCC(Z0),     Z ,FARBE);
        POINT(     Z0 ,SUCC(Z),FARBE);
        POINT(SUCC(Z0),SUCC(Z),FARBE);
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
  SET320X200;
  SETFONT(14);
  IF ABS(CPU_TYPE) < 286 THEN PROC86 := TRUE;
END.

