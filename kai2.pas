PROGRAM Mein_erstes_Uebungsprogramm;
USES Crt;
VAR
  f : STRING;
  g : STRING;
BEGIN
  ClrScr;
  Write('Bitte gib deinen Namen ein: ');
  ReadLn(f);
  Write('Hallo ');
  Write(f);
  Write(', wie geht es dir? ');
  ReadLn(g);
  Write ('Es geht dir also ');
  Write (g);
  writeln (' du absolut demliches Arschloch');
  if f = 'Kai' then Begin
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
END;
 
  ReadLn
END.

