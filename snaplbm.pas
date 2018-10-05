
PROGRAM SNAPLBM;
{
  RESIDENTES PROGRAMM ZUM ERZEUGEN VON 'SNAPSHOTS' IN DEN 256- FARBEN-
  VIDEO- MODI DES TSENG ET 4000- CHIPS

  Paul Schubert, Rottweiler Str. 8, D6000 Frankfurt /M 1, 069 / 231145

  DIE UNIT TSR WURDE IN DER ZEITSCHRIFT TOOLBOX VER™FFENTLICHT
}
{$M 4096,0,655360}
{$R-}
{$S-}
{$V-}
{$I-}

USES  TSR,DOS,CRT,TPINLINE;


{$DEFINE BEEPS}


CONST SnapID     = 11;                   { Kennziffer          }
      Version    = 'SNAPLBM';
      Hotkey     = $6800;                { Aktivierung: Alt-F1 }
      HotkeyName = 'Alt-F1';

CONST LINLEN       = 1024;
      SEGP  : WORD = $3CD; { PORTADRESSE FšR VIDEO- RAM- SEGMENT }

      FN : STRING[64] = 'SNAP0001.LBM';


TYPE  CMAPTYP  = ARRAY[0..255,0..2] OF BYTE;
      PALTYP   = ARRAY[0..15,0..2] OF BYTE;

      COLORVALUE = RECORD R,G,B : BYTE END;
      VGAPALETTETYPE = ARRAY[0..255] OF COLORVALUE;


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
      S                    : STRING;
      XWID,YWID            : WORD;
      VMOD                 : BYTE ABSOLUTE $40:$49;
      F                    : FILE;
      N                    : ARRAY[1..4] OF CHAR;
      L                    : LONGINT;

      CMAP                 : CMAPTYP;
      PAL                  : VGAPALETTETYPE ABSOLUTE CMAP;
      HDR                  : HDRTYP;
      LINBUF               : ARRAY[0..LINLEN] OF BYTE;

      FIXMOD               : BYTE;
      INTVECS              : ARRAY[0..255] OF POINTER ABSOLUTE 0:0;


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


PROCEDURE GETVGAPALETTE;
VAR   I,J  : BYTE;
      R    : REGISTERS;
BEGIN
  R.AX := $1017;
  R.BX := 0;
  R.CX := 256;
  R.ES := Seg(PAL);
  R.DX := Ofs(PAL);
  INTR($10,R);
  FOR I := 0 TO 255 DO BEGIN
    FOR J := 0 TO 2 DO BEGIN
      IF CMAP[I,J] <> 0 THEN CMAP[I,J] := (CMAP[I,J] SHL 2) OR 3;
    END; { NEXT J }
  END; { NEXT I }
END; { GETVGAPALETTE }


PROCEDURE WRITEHDR;
BEGIN
  N := 'FORM';
  BLOCKWRITE(F,N,4);
  L := LONGINT(LONGINT(XWID) * LONGINT(YWID) + LONGINT(48) + LONGINT($300));
  L := LSWAP(L);
  BLOCKWRITE(F,L,4);
  N := 'PBM ';
  BLOCKWRITE(F,N,4);
  N := 'BMHD';
  BLOCKWRITE(F,N,4);
  L := LSWAP(20);
  BLOCKWRITE(F,L,4);
  FILLCHAR(HDR,SIZEOF(HDR),0);
  WITH HDR DO BEGIN
    WID   := SWAP(XWID);
    HIG   := SWAP(YWID);
    BPP   := 8;
    COMPR := 0;
    SCWID := SWAP(XWID);
    SCHIG := SWAP(YWID);
  END; { WITH HDR }
  BLOCKWRITE(F,HDR,SIZEOF(HDR));
END; { WRITEHDR }


FUNCTION GETVIDEO:BOOLEAN;
VAR   VM  : BYTE;
BEGIN
  GETVIDEO := FALSE;
  IF FIXMOD <> 0 THEN VM := FIXMOD
                 ELSE VM := VMOD;
  IF VM = $13 THEN BEGIN
    XWID := 320;
    YWID := 200;
    GETVIDEO := TRUE;
    EXIT;
  END;
  IF VM = $2D THEN BEGIN
    XWID := 640;
    YWID := 350;
    GETVIDEO := TRUE;
    EXIT;
  END;
  IF VM = $2F THEN BEGIN
    XWID := 640;
    YWID := 400;
    GETVIDEO := TRUE;
    EXIT;
  END;
  IF VM = $2E THEN BEGIN
    XWID := 640;
    YWID := 480;
    GETVIDEO := TRUE;
    EXIT;
  END;
  IF VM = $30 THEN BEGIN
    XWID := 800;
    YWID := 600;
    GETVIDEO := TRUE;
    EXIT;
  END;
  IF VM = $38 THEN BEGIN
    XWID := 1024;
    YWID := 768;
    GETVIDEO := TRUE;
    EXIT;
  END;
END; { GETVIDEO }


{ SEGMENT DER VGA- KARTE FšR LESEN UND SCHREIBEN SETZEN }
PROCEDURE SETSEG(NR:BYTE);
BEGIN
(* ET 4000 *)
  PORT[SEGP] := (NR AND $0F) SHL 4 + (NR AND $0F);
(* ET 3000
  PORT[SEGP] := ((NR AND $07) SHL 3 + (NR AND $07)) OR $20;
*)
END; { SETSEG }


PROCEDURE INCNAME;
VAR   I  : BYTE;
BEGIN
  I := 8;
  REPEAT
    INC(FN[I]);
    IF FN[I] > '9' THEN BEGIN
      FN[I] := '0';
      DEC(I);
    END ELSE EXIT;
  UNTIL I < 5;
END; { INCNAME }


{$F+}
PROCEDURE WRITELBM;
VAR   SEGM,B1,B2  : BYTE;
      X,Y         : WORD;
LABEL LOOP;
BEGIN
  IF GETVIDEO THEN BEGIN
LOOP:
    ASSIGN(F,FN);
    RESET(F);
    IF IORESULT = 0 THEN BEGIN
      INCNAME;
      GOTO LOOP;
    END ELSE BEGIN
      CLOSE(F);
    END;
{$IFDEF BEEPS}
    SOUND(1000);
    DELAY(50);
    NOSOUND;
{$ENDIF}

    SEGM := PORT[SEGP];
    GETVGAPALETTE;
    ASSIGN(F,FN);
    REWRITE(F,1);
    WRITEHDR;

    N := 'CMAP';
    BLOCKWRITE(F,N,4);
    L := LSWAP(LONGINT($300));
    BLOCKWRITE(F,L,4);
    BLOCKWRITE(F,PAL,SIZEOF(PAL));
    N := 'BODY';
    BLOCKWRITE(F,N,4);
    L := LSWAP(LONGINT(LONGINT(XWID) * LONGINT(YWID)));
    BLOCKWRITE(F,L,4);

    B1 := 0;
    SETSEG(0);
    L := LONGINT(LONGINT(XWID) * LONGINT(YWID));
    WHILE L >= 65536 DO BEGIN
      BLOCKWRITE(F,MEM[$A000:0],65535);
      BLOCKWRITE(F,MEM[$A000:$FFFF],1);
      INC(B1);
      SETSEG(B1);
      DEC(L,65536);
    END;
    IF L > 0 THEN BLOCKWRITE(F,MEM[$A000:0],L);

    CLOSE(F);

    PORT[SEGP] := SEGM;

    INCNAME;

{$IFDEF BEEPS}
    SOUND(2000);
    DELAY(50);
    SOUND(500);
    DELAY(50);
    SOUND(1000);
    DELAY(50);
    NOSOUND;
{$ENDIF}
  END ELSE BEGIN
{$IFDEF BEEPS}
    SOUND(300);
    DELAY(200);
    NOSOUND;
{$ENDIF}
  END;
END; { WRITELBM }
{$F-}


PROCEDURE WASKANNICH;
BEGIN
  WRITELN;
  WRITELN(' Abspeichern von Bildschirminhalten in den 256- Farben- Modi als');
  WRITELN('unkomprimiertes LBM- File (Filetyp PBM)');
  WRITELN('Untersttzte Video- Modi :');
  WRITELN(' 13H - VGA Standard 320 * 200 / 256');
  WRITELN(' 2DH - ET 4000      640 * 350 / 256');
  WRITELN(' 2FH - ET 4000      640 * 400 / 256');
  WRITELN(' 2EH - ET 4000      640 * 480 / 256');
  WRITELN(' 30H - ET 4000      800 * 600 / 256');
  WRITELN(' 38H - ET 4000     1024 * 768 / 256');
END; { WASKANNICH }


BEGIN { MAIN }

  IF AlreadyLoaded(SnapID) THEN
    WriteLn(Version, '  ist bereits geladen!',
            ^M^J, 'Aktivieren Sie das Programm mit ',
            HotKeyName, '.')
  ELSE BEGIN
    IF PopUpInstalled (@WRITELBM, Hotkey, 24) THEN BEGIN
      WriteLn(Version, ' installiert.',
              ^M^J, 'Aktivieren Sie das Programm mit ',
              HotKeyName, '.');
      WASKANNICH;

      FIXMOD := 0;
      IF PARAMCOUNT > 0 THEN BEGIN
        VAL(PARAMSTR(1),I,J);
        IF J = 0 THEN FIXMOD := I;
      END;

      MakeResident(SnapID);
    END ELSE
      WriteLn(Version, '  nicht installiert,', ^M^J,
              'Fehler: Vermutlich zu wenig Hauptspeicher!');
  END;
  WASKANNICH;
END.


