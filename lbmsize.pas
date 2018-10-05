
PROGRAM LBMSIZE;
{
  PROGRAMM ZUM ERZEUGEN EINES AUSSCHNITTS AUS EINEM DELUXE- PAINT LBM- FILE

  Paul Schubert, Rottweiler Str. 8, D6000 Frankfurt /M 1, 069 / 231145

}
{$R-}
{$S-}
{$F+}

USES  TPCRT,DIRUNIT,TPSTRING
      ,TPENHKBD,TPDOS
      ,SVGA
      ;


CONST LINLEN   = 2048;


TYPE  IDTYPE    = ARRAY[1..4] OF CHAR;
      CMAPTYP   = ARRAY[0..255,0..2] OF BYTE;
      BYTEARRAY = ARRAY[0..1] OF BYTE;

TYPE  CHUNKTYP = RECORD
        KORR    : BOOLEAN;
        ID      : IDTYPE;
        CASE BOOLEAN OF
          TRUE  : (LEN : LONGINT);
          FALSE : (LBA : ARRAY[1..4] OF BYTE);
      END;

TYPE  HDRTYP = RECORD
        WID,HIG   : WORD;
        FILL0     : ARRAY[1..4] OF BYTE;
        BPP       : BYTE;
        AMI1      : BYTE;
        COMPR     : BYTE;
        FILL      : BYTE;
        FGCOL     : BYTE;
        BKCOL     : BYTE;
        XRAT,YRAT : BYTE;
        SCWID     : WORD;
        SCHIG     : WORD;
      END;


VAR   I,J                  : INTEGER;
      CH1,CH2              : CHAR;
      PATH,FN,FN2          : STRING;
      F,F2                 : FILE;
      CHUNK                : CHUNKTYP;
      FTYP                 : IDTYPE;
      FLEN,CHUNKPOS        : LONGINT;
      CMAPSIZ              : WORD;
      CMAP                 : CMAPTYP;
      PAL                  : VGAPALETTETYP ABSOLUTE CMAP;
      HDR                  : HDRTYP;
      TW,TH                : WORD;
      X,Y,XW               : WORD;
      ILBM,CUT             : BOOLEAN;
      LINBUF               : ARRAY[0..LINLEN] OF BYTE;
      RDWID,DSPWID         : WORD;

      NWID,NHIG            : WORD;
      NXSTA,NYSTA          : WORD;
      FIRST,MESSEN         : BOOLEAN;

      SSP                  : ^BYTEARRAY;
      COLM                 : COLORVALUE;


PROCEDURE SAVESCREEN;
BEGIN
  GETMEM(SSP,65535);
  VGATORAM(SSP,0,65535);
END; { SAVESCREEN }


PROCEDURE RESTORESCREEN;
BEGIN
  RAMTOVGA(SSP,0,65535);
  FREEMEM(SSP,65535);
END; { RESTORESCREEN }


FUNCTION LSWAP(L:LONGINT):LONGINT;
VAR   B   : ARRAY[0..3] OF BYTE;
      B1  : BYTE;
      L1  : LONGINT ABSOLUTE B;
BEGIN
  MOVE(L,B,4);
  B1 := B[0];
  B[0] := B[3]; B[3] := B1;
  B1 := B[2];
  B[2] := B[1];
  B[1] := B1;
  LSWAP := L1;
END; { LSWAP }


PROCEDURE WRITEHDR;
VAR   N  : ARRAY[1..4] OF CHAR;
      L  : LONGINT;
BEGIN
  N := 'FORM';
  BLOCKWRITE(F2,N,4);
  L := LONGINT(LONGINT(XWID) * LONGINT(YWID) + LONGINT(48) + LONGINT($300));
  L := LSWAP(L);
  BLOCKWRITE(F2,L,4);
  N := 'PBM ';
  BLOCKWRITE(F2,N,4);
  N := 'BMHD';
  BLOCKWRITE(F2,N,4);
  L := LSWAP(20);
  BLOCKWRITE(F2,L,4);
  FILLCHAR(HDR,SIZEOF(HDR),0);
  WITH HDR DO BEGIN
(*
    WID   := SWAP(XWID);
    HIG   := SWAP(YWID);
*)
    WID   := SWAP(NWID - NXSTA);
    HIG   := SWAP(NHIG - NYSTA);

    BPP   := 8;
    COMPR := 0;
    SCWID := SWAP(XWID);
    SCHIG := SWAP(YWID);
  END; { WITH HDR }
  BLOCKWRITE(F2,HDR,SIZEOF(HDR));
END; { WRITEHDR }


PROCEDURE WRITELBM;
VAR   SEGM,B1,B2  : BYTE;
      X,Y         : WORD;
      N           : ARRAY[1..4] OF CHAR;
      L           : LONGINT;
      I           : INTEGER;
BEGIN

  SEGM := PORT[SEGP];
  FOR I := 0 TO 255 DO BEGIN
    FOR J := 0 TO 2 DO BEGIN
      IF CMAP[I,J] <> 0 THEN CMAP[I,J] := (CMAP[I,J] SHL 2) OR 3;
    END; { NEXT J }
  END; { NEXT I }

  IF ODD(NWID - NXSTA) THEN INC(NWID);
  IF ODD(NHIG - NYSTA) THEN INC(NHIG);

  ASSIGN(F2,FN2);
  REWRITE(F2,1);
  WRITEHDR;

  N := 'CMAP';
  BLOCKWRITE(F2,N,4);
  L := LSWAP(LONGINT($300));
  BLOCKWRITE(F2,L,4);
  BLOCKWRITE(F2,PAL,SIZEOF(PAL));
  N := 'BODY';
  BLOCKWRITE(F2,N,4);
  L := LSWAP(LONGINT(LONGINT(NWID - NXSTA) * LONGINT(NHIG - NYSTA)));
  BLOCKWRITE(F2,L,4);

  FOR Y := NYSTA TO PRED(NHIG) DO BEGIN
    VGATORAM(@LINBUF,LONGINT(LONGINT(Y) * LONGINT(XWID) + NXSTA),NWID - NXSTA);
    BLOCKWRITE(F2,LINBUF,NWID - NXSTA);
  END; { NEXT Y }

  CLOSE(F2);

  PORT[SEGP] := SEGM;
END; { WRITELBM }


PROCEDURE GRAPHEIN(VORGABE:BYTE);
BEGIN { GRAPHEIN }
  SET320X200;

  IF VORGABE = 0 THEN BEGIN
    WITH HDR DO BEGIN
      IF WID > 320 THEN BEGIN
        SET640X350;
        IF HIG > 350 THEN SET640X400;
        IF HIG > 400 THEN SET640X480;
        IF HIG > 480 THEN SET800X600;
        IF HIG > 600 THEN SET1024X768;
      END;
      IF WID > 640 THEN BEGIN
        IF HIG <= 600 THEN SET800X600
                      ELSE SET1024X768;
      END;
      IF WID > 800 THEN SET1024X768;
    END; { WITH HDR }
  END ELSE BEGIN
    CASE VORGABE OF
      2 : SET640X350;
      3 : SET640X400;
      4 : SET640X480;
      5 : SET800X600;
      6 : SET1024X768;
    END;
  END;

  I := CHECKVGA(VMOD);
  IF I < 0 THEN BEGIN
    TEXTMODE(CO80);
    WRITELN;
    WRITELN('KEINE VGA- KARTE VORHANDEN, ODER DIE VGA UNTERSTšTZT');
    WRITELN('DEN GEWšNSCHTEN VIDEO- MODUS NICHT');
    HALT(1);
  END;
  MAXX := PRED(XWID);
  MAXY := PRED(YWID);

  VGASETPALETTE(PAL,0,PRED(CMAPSIZ));

  DIRECTVIDEO := FALSE;
END; {GRAPHEIN }


PROCEDURE READCHUNK;
VAR   B  : BYTE;
BEGIN
  WITH CHUNK DO BEGIN
    BLOCKREAD(F,ID,8);
    CHUNKPOS := FILEPOS(F);
    B := LBA[4]; LBA[4] := LBA[1]; LBA[1] := B;
    B := LBA[3]; LBA[3] := LBA[2]; LBA[2] := B;

    KORR := ODD(LEN);
    IF KORR THEN INC(LEN);
  END; { WITH CHUNK }
END; { READCHUNK }


PROCEDURE NXTCHUNK;
BEGIN
  IF (CHUNKPOS+CHUNK.LEN) <= FILESIZE(F) THEN BEGIN
    SEEK(F,CHUNKPOS+CHUNK.LEN);
  END ELSE BEGIN
    WRITE('CHUNK- Gr”áe falsch : ',CHUNKPOS+CHUNK.LEN:8,FILESIZE(F):8);
  END;
END; { NXTCHUNK }


PROCEDURE PUTLINE;
VAR   I,J,K  : INTEGER;
      W,IDX  : WORD;
      B,MSK  : BYTE;
      OTLN   : ARRAY[0..LINLEN] OF BYTE;
BEGIN
  IF HDR.BPP = 1 THEN BEGIN

    I := PRED(XW SHL 3);
    J := PRED(XW);
    REPEAT
      FOR K := 0 TO 7 DO BEGIN
        IF ODD(LINBUF[J]) THEN LINBUF[I] := 1 ELSE LINBUF[I] := 0;
        LINBUF[J] := LINBUF[J] SHR 1;
        DEC(I);
      END; { NEXT K }
      DEC(J);
    UNTIL I < 0;
    RAMTOVGA(@LINBUF,LONGINT(Y) * LONGINT(XWID),DSPWID);
  END ELSE BEGIN
    IF ILBM THEN BEGIN
      IF HDR.BPP = 4 THEN MSK := $F ELSE MSK := $FF;
      W := XW DIV HDR.BPP;
      X := 0;
      I := 0;
      REPEAT
        FOR J := 0 TO 7 DO BEGIN
          B := 0;
          IDX := I;
          FOR K := 0 TO 7 DO BEGIN
            B := (B SHR 1) OR (LINBUF[IDX] AND $80);
            LINBUF[IDX] := LINBUF[IDX] SHL 1;
            INC(IDX,W);
          END;
          OTLN[X] := B AND MSK;
          INC(X);
        END; { NEXT J }
        INC(I);
      UNTIL I >= W;
      RAMTOVGA(@OTLN,LONGINT(Y) * LONGINT(XWID),DSPWID);
    END ELSE
      RAMTOVGA(@LINBUF,LONGINT(Y) * LONGINT(XWID),DSPWID);
  END;
  INC(Y);
  X := 0;
END; { PUTLINE }


PROCEDURE READLINE;
VAR   B,B2 : BYTE;
BEGIN
  WITH HDR DO BEGIN
    IF COMPR = 0 THEN BEGIN
      BLOCKREAD(F,LINBUF,XW);
      PUTLINE;
    END ELSE BEGIN
      BLOCKREAD(F,B,1);
      IF B > $7F THEN BEGIN
        BLOCKREAD(F,B2,1);
        FILLCHAR(LINBUF[X],257 - B,B2);
        INC(X,257); DEC(X,B);
        IF X >= XW THEN PUTLINE;
      END ELSE BEGIN
        INC(B);
        BLOCKREAD(F,LINBUF[X],B);
        INC(X,B);
        IF X >= XW THEN PUTLINE;
      END;
    END;
  END; { WITH HDR }
END; { READLINE }


PROCEDURE DISPLAYBODY;
VAR   I,J          : INTEGER;
      X1,X2,Y1,Y2  : INTEGER;
      B,B2         : BYTE;
      CH1,CH2      : CHAR;
      RASTEIN      : BOOLEAN;

PROCEDURE TOGCURS;
VAR   Z1  : LONGINT;
      I   : INTEGER;
BEGIN { TOGCURS }
  Z1 := TIMEMS;
  FOR I := 1 TO HDR.WID -2 DO BEGIN
    XPLOT(I,Y1,$FF);
    XPLOT(I,Y2,$FF);
  END;
  FOR I := 1 TO HDR.HIG -2 DO BEGIN
    XPLOT(X1,I,$FF);
    XPLOT(X2,I,$FF);
  END;
  REPEAT UNTIL (TIMEMS - Z1) > 70;
END; { TOGCURS }

PROCEDURE RASTER;
VAR   I,J  : INTEGER;
BEGIN { RASTER }
  RASTEIN := NOT RASTEIN;
  I := 10;
  REPEAT
    J := 10;
    REPEAT
      XPLOT(J,I,255);
      IF (I MOD 50) = 0 THEN BEGIN
        XPLOT(J+5,I,255);
      END;
      IF (I MOD 100) = 0 THEN BEGIN
        XPLOT(J+2,I,255);
        XPLOT(J+8,I,255);
      END;

      IF (J MOD 50) = 0 THEN BEGIN
        XPLOT(J,I+5,255);
      END;
      IF (J MOD 100) = 0 THEN BEGIN
        XPLOT(J,I+2,255);
        XPLOT(J,I+8,255);
      END;

      INC(J,10);
    UNTIL J >= (HDR.WID - 10);
    INC(I,10);
  UNTIL I >= (HDR.HIG - 10);
END; { RASTER }

BEGIN { DISPLAYBODY }
  RASTEIN := FALSE;
  WITH HDR DO BEGIN
    CASE BPP OF
      1 : XW := RDWID SHR 3;
      4 : XW := RDWID SHR 1;
      8 : XW := RDWID;
    ELSE
      EXIT;
    END;
    GRAPHEIN(0);
    DSPWID := WID;
    IF DSPWID > XWID THEN DSPWID := XWID;
    X  := 0;
    Y  := 0;
    REPEAT
      READLINE;
    UNTIL Y >= HIG;
  END; { WITH HDR }
  IF MESSEN THEN BEGIN
    RASTER;

    X1 := NXSTA;
    X2 := PRED(HDR.WID);
    Y1 := NYSTA;
    Y2 := PRED(HDR.HIG);

    REPEAT
      WHILE NOT KEYPRESSED DO BEGIN
        TOGCURS;
        TOGCURS;
      END; { WHILE NOT KEYPRESSED }
      CH1 := READKEY; IF CH1 = #0 THEN CH2 := READKEY ELSE CH2 := #0;
      CASE CH2 OF
{LINKS} #75 : BEGIN
                IF X1 > 0 THEN DEC(X1);
              END;
{RECHTS}#77 : BEGIN
                IF X1 <= (X2 - 8) THEN INC(X1);
              END;
{AUF}   #72 : BEGIN
                IF Y1 > 0 THEN DEC(Y1);
              END;
{AB}    #80 : BEGIN
                IF Y1 <= (Y2 - 8) THEN INC(Y1);
              END;

{END}   #79 : BEGIN
                IF FN2 <> '' THEN BEGIN
                  IF RASTEIN THEN RASTER;
                  NWID  := SUCC(X2);
                  NHIG  := SUCC(Y2);
                  NXSTA := X1;
                  NYSTA := Y1;
                  WRITELBM;
                  EXIT;
                END ELSE WRITE(#7);
              END;
{HOME}  #71 : BEGIN
                RASTER;
              END;

{F1}    #59 : BEGIN
                SAVESCREEN;
COLM := PAL[15];
FILLCHAR(PAL[15],3,63);
VGASETPALETTE(PAL,15,16);

TEXTCOLOR(15);
GOTOXY(1,1);
WRITELN(X1:5,Y1:5,' ');
WRITELN(SUCC(X2-X1):5,SUCC(Y2-Y1):5,' ');
                IF READKEY = #0 THEN IF READKEY = ' ' THEN;
PAL[15] := COLM;
VGASETPALETTE(PAL,15,16);
                RESTORESCREEN;
              END;

{C-LI} #115 : BEGIN
                IF X2 >= (X1 - 8) THEN DEC(X2);
              END;
{C-RE} #116 : BEGIN
                IF X2 < HDR.WID THEN INC(X2);
              END;
{C-AUF}#141 : BEGIN
                IF Y2 >= (Y1 - 8) THEN DEC(Y2);
              END;
{C-AB} #145 : BEGIN
                IF Y2 < HDR.HIG THEN INC(Y2);
              END;
      END; { CASE CH2 }
    UNTIL CH1 = ^[;
  END;
END; { DISPLAYBODY }


PROCEDURE DISPLAYCHUNK;
VAR   I,J  : INTEGER;
BEGIN
  IF FIRST AND (CHUNK.ID <> 'FORM') THEN BEGIN
    WRITELN('Der 1. Chunk muá Typ ''FORM'' sein !');
    HALT;
  END;
  FIRST := FALSE;

  IF CHUNK.ID = 'CRNG' THEN BEGIN
    NXTCHUNK;
    EXIT;
  END;

  IF CHUNK.ID = 'FORM' THEN BEGIN
    FLEN := CHUNK.LEN;
    BLOCKREAD(F,FTYP,4);
    ILBM := (FTYP = 'ILBM');
    EXIT;
  END;

  IF CHUNK.ID = 'TINY' THEN BEGIN
    BLOCKREAD(F,TW,2); TW := SWAP(TW); WRITE(TW:6);
    BLOCKREAD(F,TH,2); TH := SWAP(TH); WRITE(TH:6);
  END;

  IF CHUNK.ID = 'CMAP' THEN BEGIN
    CMAPSIZ := CHUNK.LEN;
    BLOCKREAD(F,CMAP,CMAPSIZ);
    CMAPSIZ := CMAPSIZ DIV 3;
    FOR I := 0 TO PRED(CMAPSIZ) DO BEGIN
      FOR J := 0 TO 2 DO CMAP[I][J] := CMAP[I][J] SHR 2;
    END;
    EXIT;
  END;

  IF CHUNK.ID = 'BMHD' THEN BEGIN
    BLOCKREAD(F,HDR,SIZEOF(HDR));
    WITH HDR DO BEGIN
      CUT := (WID < SCWID) OR (HIG < SCHIG);

      WID := SWAP(WID);
      RDWID := WID;
      IF ODD(RDWID) THEN INC(RDWID);
      IF ILBM AND (BPP > 1) THEN BEGIN
        IF ((RDWID AND 2) > 0) THEN INC(RDWID,2);
        IF ((RDWID AND 4) > 0) THEN INC(RDWID,4);
        IF ((RDWID AND 8) > 0) THEN INC(RDWID,8);
      END;
      HIG := SWAP(HIG);
      SCWID := SWAP(SCWID);
      SCHIG := SWAP(SCHIG);
    END; { WITH HDR }
  END;

  IF CHUNK.ID = 'BODY' THEN BEGIN
    DISPLAYBODY;
    IF MESSEN THEN BEGIN
      NWID := HDR.WID;
      NWID := HDR.HIG;
    END ELSE BEGIN
      IF NWID > HDR.WID THEN NWID := HDR.WID;
      IF NHIG > HDR.HIG THEN NWID := HDR.HIG;
      WRITELBM;
    END;
  END;

  NXTCHUNK;
END; { DISPLAYCHUNK }


PROCEDURE AUS;
BEGIN
  TEXTMODE(CO80);
  HALT(3);
END; { AUS }


PROCEDURE ERKLAERE;
BEGIN
  WRITELN;
  WRITELN('LBMSIZE Inputfile[.LBM] Outputfile[.LBM] Breite H”he [X-Startwert [Y-Startwert]]');
  WRITELN;
  WRITELN('oder LBMSIZE Inputfile[.LBM] Outputfile[.LBM]  zum Vermessen des Bildes');
  HALT;
END; { ERKLAERE }


BEGIN { MAIN }

  IF (PARAMCOUNT = 0) OR (PARAMCOUNT = 3) THEN ERKLAERE;

  FN := PARAMSTR(1);
  IF POS('.',FN) = 0 THEN FN := FN + '.LBM';
  NXSTA := 0;
  NYSTA := 0;

  IF PARAMCOUNT = 2 THEN BEGIN
    FN2 := PARAMSTR(2);
    IF POS('.',FN2) = 0 THEN FN2 := FN2 + '.LBM';
  END ELSE FN2 := '';

  IF (PARAMCOUNT < 3) THEN BEGIN
    MESSEN := TRUE;
  END ELSE BEGIN
    MESSEN := FALSE;

    FN2 := PARAMSTR(2);
    IF POS('.',FN2) = 0 THEN FN2 := FN2 + '.LBM';

    VAL(PARAMSTR(3),NWID,I);
    IF (I <> 0) OR (NWID < 8) OR (NWID > 1024) THEN BEGIN
      WRITELN('FALSCHE BILDBREITE ',PARAMSTR(3));
      HALT;
    END;
    VAL(PARAMSTR(4),NHIG,I);
    IF (I <> 0) OR (NHIG < 8) OR (NHIG > 768) THEN BEGIN
      WRITELN('FALSCHE BILDBREITE ',PARAMSTR(4));
      HALT;
    END;

    IF PARAMCOUNT > 4 THEN BEGIN
      VAL(PARAMSTR(5),NXSTA,I);
      IF (I <> 0) OR (NXSTA >= NWID) THEN BEGIN
        WRITELN('FALSCHER X- START- WERT ',PARAMSTR(5));
        HALT;
      END;
    END;
    IF PARAMCOUNT > 5 THEN BEGIN
      VAL(PARAMSTR(6),NYSTA,I);
      IF (I <> 0) OR (NYSTA >= NHIG) THEN BEGIN
        WRITELN('FALSCHER Y- START- WERT ',PARAMSTR(6));
        HALT;
      END;
    END;
  END;

  FIRST := TRUE;
  ASSIGN(F,FN);
  RESET(F,1);
  REPEAT
    READCHUNK;
    DISPLAYCHUNK;
  UNTIL EOF(F);
  CLOSE(F);

  TEXTMODE(CO80);
END.


