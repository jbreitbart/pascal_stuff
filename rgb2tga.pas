
PROGRAM RGB2TGA;
{
  UMWANDELN EINES RGB- FILES VON THUNDER IN EIN TGA- FILE

  Paul Schubert, Rottweiler Str. 8, D6000 Frankfurt /M 1, 069 / 231145

}


TYPE  RGBTYP = RECORD R,G,B : BYTE END;


CONST HDR1 : ARRAY[0..11] OF BYTE = (0,0,2,0, 0,0,0,0, 0,0,0,0);
      HDR2 : ARRAY[0.. 1] OF BYTE = ($18,$20);


VAR   I,J,K    : INTEGER;
      BB       : BYTE;
      W        : WORD;
      BUF      : ARRAY[0..$3FFF] OF RGBTYP;
      F1,F2    : FILE;
      S,N1,N2  : STRING;


BEGIN
  IF PARAMCOUNT = 0 THEN HALT;
  S := PARAMSTR(1);
  I := POS('.',S);
  IF I > 0 THEN DELETE(S,I,4);
  N1 := S + '.RGB';
  N2 := S + '.TGA';
  ASSIGN(F1,N1);
  RESET(F1,1);
  ASSIGN(F2,N2);
  REWRITE(F2,1);
  BLOCKREAD(F1,BUF,4);
  BLOCKWRITE(F2,HDR1,SIZEOF(HDR1));
  BLOCKWRITE(F2,BUF,4);
  BLOCKWRITE(F2,HDR2,SIZEOF(HDR2));

  REPEAT
(*
  WHILE NOT EOF(F1) DO BEGIN
*)
    BLOCKREAD(F1,BUF,SIZEOF(BUF),W);
    IF W > 0 THEN BEGIN
(*
WRITE(W:6,W DIV 3:6,'        ');
*)
      FOR I := 0 TO (PRED(W) DIV 3) DO BEGIN
        WITH BUF[I] DO BEGIN
          BB := R;
          R  := B;
          B  := BB;
        END; { WITH }
      END; { NEXT I }
      BLOCKWRITE(F2,BUF,W);
    END;
(*
  END;
*)
  UNTIL (W < SIZEOF(BUF));
  CLOSE(F2);
  CLOSE(F1);

END.

