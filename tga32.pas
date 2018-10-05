
PROGRAM TGA32;
{
  UMWANDELN EINES TARGA 24- BIT FILES IN EIN TARGA 16- BIT FILE
}


TYPE  RGBTYP = RECORD R,G,B : BYTE END;


TYPE  HDRTYP = RECORD
        FILL              : ARRAY[1..6] OF WORD;
        WID               : WORD;
        HIG               : WORD;
        TYP               : BYTE;
        FLAGS             : BYTE;
      END;


VAR   I,J,K    : INTEGER;
      BB       : BYTE;
      W,W2     : WORD;
      BUF      : ARRAY[0..$3FFF] OF RGBTYP;
      BUF2     : ARRAY[0..$3FFF] OF WORD ABSOLUTE BUF;
      F1,F2    : FILE;
      S,N1,N2  : STRING;
      HDR      : HDRTYP;
      BPP      : BYTE;


FUNCTION LIESHDR:BOOLEAN;
BEGIN
  LIESHDR := FALSE;
  BLOCKREAD(F1,HDR,SIZEOF(HDR));
  WITH HDR DO BEGIN
    IF FILL[1] <> 0 THEN EXIT;
    IF FILL[2] <> 2 THEN EXIT;
    IF FILL[3] <> 0 THEN EXIT;
    IF FILL[4] <> 0 THEN EXIT;
    IF FILL[5] <> 0 THEN EXIT;
    IF FILL[6] <> 0 THEN EXIT;

    IF TYP = $18 THEN BEGIN
      BPP := 3;
      LIESHDR := TRUE;
      EXIT;
    END;
    IF TYP = $10 THEN BEGIN
      BPP := 2;
      LIESHDR := TRUE;
      EXIT;
    END;
  END; { WITH HDR }
END; { LIESHDR }


BEGIN
  IF PARAMCOUNT < 2 THEN HALT;
  N1 := PARAMSTR(1);
  N2 := PARAMSTR(2);
  IF POS('.',N1) = 0 THEN N1 := N1 + '.TGA';
  IF POS('.',N2) = 0 THEN N2 := N2 + '.TGA';

  ASSIGN(F1,N1);
  RESET(F1,1);
  BPP := 0;
  IF NOT LIESHDR THEN BEGIN
    WRITELN(N1,' hat keinen gltigen Header');
    HALT;
  END;
  IF BPP <> 3 THEN BEGIN
    WRITELN(N1,' ist kein 24- Bit TARGA- File');
    HALT;
  END;

  ASSIGN(F2,N2);
  REWRITE(F2,1);
  HDR.TYP := $10;
  BLOCKWRITE(F2,HDR,SIZEOF(HDR));

  REPEAT
    BLOCKREAD(F1,BUF,SIZEOF(BUF),W);
    IF W > 0 THEN BEGIN
(*
WRITE(W:6,W DIV 3:6,'        ');
*)
      FOR I := 0 TO (PRED(W) DIV 3) DO BEGIN
        WITH BUF[I] DO BEGIN
          W2 :=        (WORD(B) AND $F8) SHL 7;
          W2 := W2 OR ((WORD(G) AND $F8) SHL 2);
          W2 := W2 OR  (WORD(R) AND $F8) SHR 3;
        END; { WITH }
        BUF2[I] := W2;
      END; { NEXT I }
      BLOCKWRITE(F2,BUF,(W DIV 3) SHL 1);
    END;
  UNTIL (W < SIZEOF(BUF));
  CLOSE(F2);
  CLOSE(F1);

END.

