
UNIT SELECTD;
{
  STELLT DAS DIRECTORY EIN, AUF DEM SICH DAS AUFGERUFENE
   PROGRAMM BEFINDET
  BEI  PROGRAMMENDE WIRD DAS URSPR�NGLICHE DIRECTORY WIEDER SELEKTIERT

  PAUL SCHUBERT, ROTTWEILER STR.8, 6000 FRANKFURT 1, 069 / 231145

  DIESE VERSION IST MIT TURBO PASCAL VERSION >= 5.0 COMPILIERBAR,
  F�R VERSION 4.0 SELECTD4 BENUTZEN.
}
{$F+}

INTERFACE


VAR   QUELLDIR,ZIELDIR : STRING[64];


PROCEDURE SELECTDNOEXIT;


IMPLEMENTATION


VAR   EXITSAVE  : POINTER;
      I         : WORD;


PROCEDURE SELECTDNOEXIT;
BEGIN
  EXITPROC := EXITSAVE;
END;


PROCEDURE MYEXIT;
BEGIN
{$I-}
  CHDIR(QUELLDIR);
  I := IORESULT;
{$I+}
  EXITPROC := EXITSAVE;
END;



BEGIN
  GETDIR(0,QUELLDIR);
  ZIELDIR := PARAMSTR(0);
  I := LENGTH(ZIELDIR);
  WHILE (I > 0) AND (ZIELDIR[I] <> '\') DO BEGIN
    DELETE(ZIELDIR,I,1);
    DEC(I);
  END;
  IF (LENGTH(ZIELDIR) <> 3)
    THEN IF (I > 0) AND (ZIELDIR[I] = '\') THEN DELETE(ZIELDIR,I,1);
  IF LENGTH(ZIELDIR) = 0 THEN ZIELDIR := QUELLDIR;
  IF QUELLDIR <> ZIELDIR THEN BEGIN
{$I-}
  CHDIR(ZIELDIR);
  I := IORESULT;
{$I+}
  END;
  EXITSAVE := EXITPROC;
  EXITPROC := @MYEXIT;
END.

