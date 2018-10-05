
PROGRAM TGA;
{
  PROGRAMM ZUM ANZEIGEN VON 16- UND 24- BIT / PIXEL TARGA- FILES

  Paul Schubert, Rottweiler Str. 8, D6000 Frankfurt /M 1, 069 / 231145

}
{$R-}
{$S-}
{$F+}

{.$DEFINE PAUL}


USES  TPCRT,DOS,DIRUNIT,TPSTRING
      ,SVGA,TPMOUSE,TPPICK
      ;


CONST LINLEN   = 1024;

CONST RGB_DM : ARRAY[0..3,0..3] OF BYTE = (
                ( 0,12, 3,15),
                ( 8, 4,11, 7),
                ( 2,14, 1,13),
                (10, 6, 9, 5)
               );

TYPE  CMAPTYP  = ARRAY[0..255,0..2] OF BYTE;
      PALTYP   = ARRAY[0..15,0..2] OF BYTE;
      UCVAL    = RECORD B,G,R : BYTE END;

TYPE  HDRTYP = RECORD
        PALSIZ     : WORD;
        FTYP       : WORD;
        FILL1      : WORD;
        RGBSIZE    : BYTE;
        FLAG0      : BYTE;
        FILL2      : WORD;
        FILL3      : WORD;
        WID        : WORD;
        HIG        : WORD;
        TYP        : BYTE;
        FLAGS      : BYTE;
        CMAPSIZ    : WORD;
        BPP        : BYTE;
        REV        : BOOLEAN;
      END;

VAR   I,J                  : INTEGER;
      CH1,CH2              : CHAR;
      S                    : STRING;
      ENDE,DOPP            : BOOLEAN;
      PATH,FN              : STRING;
      F                    : FILE;
      HDRERR               : INTEGER;

      CMAP                 : CMAPTYP;
      PAL                  : VGAPALETTETYP ABSOLUTE CMAP;
      HDR                  : HDRTYP;
      LINBUF               : ARRAY[0..LINLEN] OF COLORVALUE;
      ULINBUF              : ARRAY[0..LINLEN] OF UCVAL ABSOLUTE LINBUF;
      WLINBUF              : ARRAY[0..LINLEN] OF WORD  ABSOLUTE LINBUF;

      RGB_XSIZE            : WORD ABSOLUTE XWID;
      MKB                  : WORD;


{$L VGARGB.OBJ}
{$F+} PROCEDURE RGB_DOT(X,Y,R,G,B:WORD); EXTERNAL; {$F-}


{ PALETTE FöR FARBRASTERUNG EINSTELLEN }
PROCEDURE SETPALETTE;
VAR   I,J,K  : INTEGER;
BEGIN
  FOR I := 0 TO 7 DO
    FOR J := 0 TO 7 DO
      FOR K := 0 TO 3 DO
        WITH PAL[I * 32 + J * 4 + K] DO BEGIN
          R := I * 9;  { 63 / 4 }
          G := J * 9;  { 63 / 4 }
          B := K * 21; { 63 / 3 }
        END;
  VGASETPALETTE(PAL,0,255);
END; { SETPALETTE }


PROCEDURE GRAPHEIN(VORGABE:BYTE);
BEGIN { GRAPHEIN }
  DOPP := FALSE;
  WITH HDR DO BEGIN
    VMOD := $13;
    XWID := 320;
    YWID := 200;

    IF VORGABE = 0 THEN BEGIN
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
      IF (WID <= 320) AND (HIG <= 200) THEN BEGIN
        SET640X400;
        DOPP := TRUE;
      END;
    END ELSE BEGIN
      CASE VORGABE OF
        2 : SET640X350;
        3 : SET640X400;
        4 : SET640X480;
        5 : SET800X600;
        6 : SET1024X768;
      END;
    END;

    IF CHECKVGA(VMOD) < 0 THEN BEGIN
      TEXTMODE(CO80);
      WRITELN;
      WRITELN('KEINE VGA- KARTE VORHANDEN, ODER DIE VGA UNTERSTöTZT');
      WRITELN('DEN GEWöNSCHTEN VIDEO- MODUS NICHT');
      HALT(1);
    END;
    MAXX := PRED(XWID);
    MAXY := PRED(YWID);

    DIRECTVIDEO := FALSE;
    IF FTYP = 1 THEN VGASETPALETTE(PAL,0,255);
    IF FTYP = 2 THEN SETPALETTE;

  END; { WITH HDR }
END; {GRAPHEIN }


PROCEDURE AUS;
BEGIN
  TEXTMODE(CO80);
  HALT(3);
END; { AUS }


FUNCTION LIESHDR:BOOLEAN;
VAR   FP   : LONGINT;
      I,J  : INTEGER;
      BB   : BYTE;
BEGIN
  LIESHDR := FALSE;
  BLOCKREAD(F,HDR,18);
  WITH HDR DO BEGIN
    CMAPSIZ := 256;

    HDRERR := 1;
    IF FILL1 <> 0 THEN EXIT;
    HDRERR := 2;
    IF FILL2 <> 0 THEN EXIT;
    HDRERR := 3;
    IF FILL3 <> 0 THEN EXIT;
    HDRERR := 4;
    IF NOT FTYP IN [1,2] THEN EXIT;
    HDRERR := 5;
    IF NOT (RGBSIZE IN [0,1]) THEN EXIT;

    REV := (FLAGS <> $20);

    HDRERR := 6;
    IF FTYP = 1 THEN BEGIN
      IF PALSIZ > 256 THEN EXIT;
      BLOCKREAD(F,PAL,PALSIZ * 3);
      FOR I := 0 TO PRED(PALSIZ) DO BEGIN
        BB := PAL[I].R SHR 2;
        PAL[I].G := PAL[I].G SHR 2;
        PAL[I].R := PAL[I].B SHR 2;
        PAL[I].B := BB;
      END;
    END;

    HDRERR := 7;
    IF TYP = $18 THEN BEGIN
      BPP := 3;
      LIESHDR := TRUE;
      HDRERR := 0;
      EXIT;
    END;
    IF TYP = $10 THEN BEGIN
      BPP := 2;
      LIESHDR := TRUE;
      HDRERR := 0;
      EXIT;
    END;
    IF TYP = $08 THEN BEGIN
      BPP := 1;
      LIESHDR := TRUE;
      HDRERR := 0;
      EXIT;
    END;
  END; { WITH HDR }
END; { LIESHDR }


PROCEDURE ZEIGEBILD;
VAR   X,Y       : INTEGER;
      RW,GW,BW  : WORD;
      C1,C2     : CHAR;
      ERG       : WORD;

PROCEDURE ZEILE8;
VAR   R,G,B,X  : WORD;
BEGIN
  BLOCKREAD(F,LINBUF,HDR.WID,ERG);
  RAMTOVGA(@LINBUF,LONGINT(Y) * LONGINT(XWID),HDR.WID);
END; { ZEILE8 }

PROCEDURE ZEILE16;
VAR   R,G,B,X  : WORD;
BEGIN
  BLOCKREAD(F,LINBUF,2 * HDR.WID,ERG);
  FOR X := 0 TO PRED(HDR.WID) DO BEGIN
    R := (WLINBUF[X] SHR 7) AND $F8;
    G := (WLINBUF[X] SHR 2) AND $F8;
    B := (WLINBUF[X] SHL 3) AND $F8;
      IF DOPP THEN BEGIN
        RGB_DOT(X SHL 1,Y SHL 1,R,G,B);
        RGB_DOT(SUCC(X SHL 1),Y SHL 1,R,G,B);
        RGB_DOT(X SHL 1,SUCC(Y SHL 1),R,G,B);
        RGB_DOT(SUCC(X SHL 1),SUCC(Y SHL 1),R,G,B);
      END ELSE BEGIN
        RGB_DOT(X,Y,R,G,B);
      END;
  END;
END; { ZEILE16 }

PROCEDURE ZEILE24;
VAR   X    : WORD;
BEGIN
  BLOCKREAD(F,LINBUF,3 * HDR.WID,ERG);
  FOR X := 0 TO PRED(HDR.WID) DO BEGIN
    WITH ULINBUF[X] DO BEGIN
      IF DOPP THEN BEGIN
        RGB_DOT(X SHL 1,Y SHL 1,R,G,B);
        RGB_DOT(SUCC(X SHL 1),Y SHL 1,R,G,B);
        RGB_DOT(X SHL 1,SUCC(Y SHL 1),R,G,B);
        RGB_DOT(SUCC(X SHL 1),SUCC(Y SHL 1),R,G,B);
      END ELSE BEGIN
        RGB_DOT(X,Y,R,G,B);
      END;
    END; { WITH }
  END;
END; { ZEILE24 }

BEGIN { ZEIGEBILD }
  GRAPHEIN(0);
  WITH HDR DO BEGIN
    IF REV THEN BEGIN
      IF DOPP THEN Y := PRED(YWID SHR 1)
              ELSE Y := PRED(YWID);
    END ELSE Y := 0;
    C1 := ' ';
    REPEAT
      CASE BPP OF
        1 : ZEILE8;
        2 : ZEILE16;
        3 : ZEILE24;
      END; { CASE HDR.BPP }
      IF REV THEN DEC(Y) ELSE INC(Y);
      IF KEYPRESSED THEN BEGIN
        C1 := READKEY; IF C1 = #0 THEN C2 := READKEY ELSE C2 := #0;
      END;
    UNTIL (Y < 0) OR (Y >= HIG) OR (C1 = ^[);
  END; { WITH HDR }

  SETSEG(0); { !!! }

(*
FOR J := 0 TO 19 DO BEGIN
  FOR I := 0 TO 255 DO BEGIN
    PLOT(I SHL 1,J,I);
    PLOT(SUCC(I SHL 1),J,I);
  END; { NEXT I }
END; { NEXT J }
*)

  WRITE(#7);
  MKB := READKEYORBUTTON;

  TEXTMODE(CO80);
  DIRECTVIDEO := TRUE;
END; { ZEIGEBILD }


{ DIE ETWAS UMFANGREICHERE AUFBEREITUNG DES PATHNAMENS IST LEIDER NICHT
  ZU UMGEHEN !
}
FUNCTION PATHNAME(NAME:STRING):STRING;
VAR   S  : STRING;
BEGIN
  S := JUSTPATHNAME(NAME);
  IF NOT (S[LENGTH(S)] IN ['\',':']) THEN S := S + '\';
  PATHNAME := S;
END; { PATHNAME }


BEGIN { MAIN }
  INITIALIZEMOUSE;
  ENABLEEVENTHANDLING;
  ENABLEPICKMOUSE;

  FN := '';
  PATH := '';
  ENDE := FALSE;
  FOR I := 1 TO PARAMCOUNT DO BEGIN
    S := STUPCASE(PARAMSTR(I));
    IF S[1] IN ['-','/'] THEN BEGIN
      DELETE(S,1,1);
      IF S[1] = 'E' THEN ENDE := TRUE;
    END ELSE BEGIN
      FN := S;
      PATH := PATHNAME(FN);
      FN := JUSTFILENAME(PARAMSTR(1));
      IF (LENGTH(FN) > 0) AND (POS('.',FN) = 0) THEN FN := FN + '.TGA';
    END;
  END; { NEXT I }
  REPEAT
    IF FN = '' THEN FN := DIRUNIT.DIRECTORY(PATH+'*.TGA');
    IF FN = '' THEN HALT;
    PATH := PATHNAME(FN);

    ASSIGN(F,FN);
    RESET(F,1);
    WRITELN;
    WRITELN('Filename : ',FN);
    IF NOT LIESHDR THEN BEGIN
      WRITELN('         ***** Lesefehler TGA- Header (',HDRERR,') *****');
      WRITELN('***** oder ein nicht unterstÅtztes Dateiformat *****');
      IF READKEY = ' ' THEN;
    END ELSE BEGIN
      ZEIGEBILD;
    END;
    CLOSE(F);
    FN := '';
  UNTIL ENDE;

END.


