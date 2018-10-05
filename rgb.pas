
PROGRAM RGB;
{
  PROGRAMM ZUM ANZEIGEN VON RGB- FILES, WIE SIE VON EINIGEN RAYTRACE-
  PROGRAMMEN ERZEUGT WERDEN.
  DIE PIC- FILES VON HIGHLIGHT PC GEHEN AUCH

  Paul Schubert, Rottweiler Str. 8, D6000 Frankfurt /M 1, 069 / 231145

}
{$R+}
{$S-}

{.$DEFINE PAUL}


USES  TPCRT,DIRUNIT,TPSTRING
      ,TPMOUSE,TPPICK
      ,SVGA
      ;


CONST LINLEN   = 1024;

CONST RGB_DM : ARRAY[0..3,0..3] OF BYTE =
               ((0,12,3,15),(8,4,11,7),(2,14,1,13),(10,6,9,5));


TYPE  CMAPTYP  = ARRAY[0..255,0..2] OF BYTE;
      PALTYP   = ARRAY[0..15,0..2] OF BYTE;
      UCVAL    = RECORD R,G,B : BYTE END;

TYPE  HDRTYP = RECORD
        WID               : WORD;
        HIG               : WORD;
      END;


VAR   I,J                  : INTEGER;
      CH1,CH2              : CHAR;
      S                    : STRING;
      ENDE,DOPP            : BOOLEAN;
      PATH,FN,EXT          : STRING;
      F                    : FILE;

      PAL                  : VGAPALETTETYP;
      HDR                  : HDRTYP;
      LINBUF               : ARRAY[0..LINLEN] OF COLORVALUE;
      ULINBUF              : ARRAY[0..LINLEN] OF UCVAL ABSOLUTE LINBUF;
      WLINBUF              : ARRAY[0..LINLEN] OF WORD  ABSOLUTE LINBUF;

      RGB_XSIZE            : WORD ABSOLUTE XWID;
      MKB                  : WORD;

      REV                  : BOOLEAN;
      INTEL                : BOOLEAN;
      BPP                  : BYTE;


{$L VGARGB.OBJ}
{$F+} PROCEDURE RGB_DOT(X,Y,R,G,B:WORD); EXTERNAL; {$F-}


{ PALETTE F�R FARBRASTERUNG EINSTELLEN }
PROCEDURE SETPALETTE;
VAR   I,J,K  : INTEGER;
BEGIN
  FOR I := 0 TO 7 DO
    FOR J := 0 TO 7 DO
      FOR K := 0 TO 3 DO
        WITH PAL[I * 32 + J * 4 + K] DO BEGIN
          R := I * 9;
          G := J * 9;
          B := K * 21;
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
      WRITELN('KEINE VGA- KARTE VORHANDEN, ODER DIE VGA UNTERST�TZT');
      WRITELN('DEN GEW�NSCHTEN VIDEO- MODUS NICHT');
      HALT(1);
    END;
    MAXX := PRED(XWID);
    MAXY := PRED(YWID);

    DIRECTVIDEO := FALSE;
    SETPALETTE;

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
      L    : LONGINT;
BEGIN
  BLOCKREAD(F,HDR,4);
  LIESHDR := TRUE;

  WITH HDR DO BEGIN
    IF (WID > 4000) OR (HIG > 4000) THEN BEGIN
      INTEL := FALSE;
      HDR.WID := SWAP(HDR.WID);
      HDR.HIG := SWAP(HDR.HIG);
      L := LONGINT(WID) * LONGINT(HIG);
    END;
    L := LONGINT(WID) * LONGINT(HIG);
    IF FILESIZE(F) = (4 + 2 * L) THEN BEGIN
      BPP := 2;
    END ELSE BEGIN
      IF FILESIZE(F) = (4 + 3 * L) THEN BEGIN
        BPP := 3;
      END ELSE BEGIN
        LIESHDR := FALSE;
      END;
    END;
  END; { WITH HDR }
END; { LIESHDR }


PROCEDURE ZEIGEBILD;
VAR   X,Y       : WORD;
      RW,GW,BW  : WORD;
      C1,C2     : CHAR;
      ERG       : WORD;

PROCEDURE ZEILE16;
VAR   R,G,B,X,W  : WORD;
BEGIN
  BLOCKREAD(F,LINBUF,2 * HDR.WID,ERG);
  FOR X := 0 TO PRED(HDR.WID) DO BEGIN

    W := WLINBUF[X];
    IF NOT INTEL THEN W := SWAP(W);

    R := (W SHR 7) AND $F8;
    G := (W SHR 2) AND $F8;
    B := (W SHL 3) AND $F8;
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

BEGIN
  GRAPHEIN(0);
  X := 0;
  Y := 0;
  C1 := #0;
  WITH HDR DO BEGIN
    IF REV THEN BEGIN
      IF DOPP THEN Y := PRED(YWID SHR 1)
              ELSE Y := PRED(YWID);
    END ELSE Y := 0;
    REPEAT
      CASE BPP OF
        2 : ZEILE16;
        3 : ZEILE24;
      END; { CASE HDR.BPP }
      IF REV THEN DEC(Y) ELSE INC(Y);
      IF KEYPRESSED THEN BEGIN
        C1 := READKEY;
        IF C1 = #0 THEN C2 := READKEY ELSE C2 := #0;
      END;
    UNTIL (Y < 0) OR (Y >= HIG) OR (C1 = ^[);
  END; { WITH HDR }

  SETSEG(0); { !!! }

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

  REV := FALSE;

{$IFDEF PAUL}
  PATH := 'E:\THUNDER\';
{$ELSE}
  PATH := '';
{$ENDIF}
  FN := '';
  ENDE := FALSE;
  INTEL := TRUE;

  EXT := '.RGB';
  FOR I := 1 TO PARAMCOUNT DO BEGIN
    S := STUPCASE(PARAMSTR(I));
    IF S[1] IN ['-','/'] THEN BEGIN
      DELETE(S,1,1);
      IF S[1] = 'E' THEN ENDE := TRUE;
    END ELSE BEGIN
      FN := S;
      PATH := PATHNAME(FN);
      IF FN[LENGTH(FN)] IN ['\',':'] THEN FN := FN + '*';
      IF POS('.',FN) = 0 THEN FN := FN + '.RGB';
      IF POS('.PIC',FN) > 0 THEN EXT := '.PIC' ELSE EXT := '.RGB';
      IF NOT (PATH[LENGTH(PATH)] IN ['\',':']) AND (PATH <> '')
        THEN PATH := PATH + '\';
    END;
  END; { NEXT I }
  REPEAT
    IF (FN = '') OR (POS('*',FN) > 0) OR (POS('?',FN) > 0)
      THEN FN := DIRUNIT.DIRECTORY(PATH+'*'+EXT);
    IF FN = '' THEN HALT;
    PATH := PATHNAME(FN);

    WRITELN;
    WRITELN('Filename : ',FN);
    ASSIGN(F,FN);
    RESET(F,1);
    IF NOT LIESHDR THEN BEGIN
      WRITELN('***** Das File scheint kein RGB- File zu sein *****');
    END ELSE BEGIN
      ZEIGEBILD;
    END;
    CLOSE(F);
    FN := '';
  UNTIL ENDE;

END.


