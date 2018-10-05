PROGRAM Mein_erstes_Adventure;

{Dieses Programm wurde am 05.11.1996 von Kai Burkard in einen Informatikkurs
in der Blumensteinschule geschrieben. Zweck dieses Programmes ist die
Erheiterung von Schlern !!!}

USES Crt;
Var
  f : text ;
  Ch: Char ;

BEGIN
 ClrScr;
 TextAttr :=LightGray;
 HighVideo;
 Writeln ('Was ist Kai?');
 delay (10000);
 clrscr;
 WriteLn ('');
 WriteLn (' ษอออออออออออออป ');
 WriteLn (' บKai ist doof บ ');
 WriteLn (' ศอออออออออออออผ ');
  Sound(220);
  Delay(3000);
  NoSound;
  Sound(420);
  Delay(3000);
  NoSound;
  Sound(620);
  Delay(3000);
  NoSound;
  Sound(1020);
  Delay(3000);
  NoSound;
END.