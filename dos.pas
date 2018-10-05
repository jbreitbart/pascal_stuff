PROGRAM MSDOS;

Uses CRT, DOS;

var a, b, z : String;
    disk    : REAL;
    wieder  : LONGINT;

label anfang, Ende, para, schreib, nein;
label dir, cls, dirw, attrib, ver, typeauto, break, pas, lauf, lauf2, auto, com, mem, typecon;
label del;

BEGIN
 checkbreak:=false;
 anfang:
 wieder := 0;
 write ('C:\>');
 readln (a);
  for wieder := 0 to 50 DO
  BEGIN
   DISK := diskfree (0);
  END;
 writeln;
 if a = ('del') then goto para;
 if a = ('del *.*') then goto del;
 if a = ('type config.sys') then goto typecon;
 if a = ('mem') then goto mem;
 if a = ('mem /c') then goto mem;
 if a = ('command') then goto com;
 if a = ('autoexec') then goto auto;
 if a = ('a:') then goto lauf;
 if a = ('b:') then goto lauf;
 if a = ('c:') then goto lauf;
 if a = ('d:') then goto lauf;
 if a = ('e:') then goto lauf;
 if a = ('cd pascal') then goto pas;
 if a = ('rd') then goto para;
 if a = ('break') then goto break;
 if a = ('break on') then goto anfang;
 if a = ('break off') then goto anfang;
 if a = ('type') then goto para;
 if a = ('type Autoexec.bat') then goto typeauto;
 if a = ('type autoexec.bat') then goto typeauto;
 if a = ('ver') then goto ver;
 if a = ('') then goto anfang;
 if a = ('dir') then goto dir;
 if a = ('Dir') then goto dir;
 if a = ('dIr') then goto dir;
 if a = ('dIR') then goto dir;
 if a = ('DIR') then goto dir;
 if a = ('diR') then goto dir;
 if a = ('cls') then goto cls;
 if a = ('dir /s') then goto dir;
 if a = ('dir /p') then goto dir;
 if a = ('dir /w') then goto dirw;
 if a = ('format c:') then goto Ende;
 if a = ('format') then goto Para;
 if a = ('attrib') then goto attrib;
 if a = ('md') then goto para;
 writeln ('Befehl oder Dateiname nicht gefunden');
 goto ANFANG;
  del:
   write ('Alle Datei(en) im Verzeichnes werden gelîscht ? (J/N)');
   readln (a);
   if a = ('n') then goto anfang;
   if a = ('N') then goto anfang;
   writeln ('Schreibschutzt fehler');
  typecon:
   writeln ('DEVICE=C:\DOS\SETVER.EXE');
   writeln ('DEVICE=C:\HIMEM.SYS');
   writeln ('DOS=HIGH');
   writeln ('COUNTRY=049,850,C:\DOS\COUNTRY.SYS');
   writeln ('DEVICE=C:\DOS\DISPLAY.SYS CON=(EGA,,1)');
   writeln ('FILES=20');
   goto anfang;
  mem:
   write ('Speicher zu sehr fragmentiert;');
   write (a);
   writeln (' kann nicht ausgefÅhrt werden');
   goto anfang;
  com:
   writeln ('COMMAND.COM ist nicht ausfÅhrbar');
   writeln;
   goto anfang;
  auto:
   writeln ('Microsoft (R) Mouse Driver Version 7.00');
   writeln ('Copyright (C) Microsoft Corp 1990-1995. All rights reserved.');
   writeln ('Mouse driver installed');
   goto anfang;
  lauf:
   write ('Nicht bereit beim Lesen von Laufwerk ');
   writeln (a);
   write ('(A)bbrechen, (W)iederholen, (U)ebergehen?');
   readln (b);
   if b = ('u') then goto lauf2;
   if b = ('U') then goto lauf2;
   goto lauf;
  lauf2:
   write ('Aktuelles Laufwerk nicht mehr gÅltig>');
   readln (a);
   if a = ('c:') then goto lauf;
   if a = ('b:') then goto lauf;
   if a = ('a:') then goto lauf;
   goto lauf2;
  pas:
   writeln ('UngÅltiges Verzeichnis');
   writeln;
   goto anfang;
  break:
   writeln ('BREAK ist ausgeschaltet (OFF)');
   goto anfang;
  typeauto:
   writeln ('@ECHO OFF');
   writeln ('PROMPT $p$g');
   writeln ('PATH = C:\WINDOWS\COMMAND;C:\DOS;C:\WINDOWS;C:\DOS');
   writeln ('SET TEMP C:\TEMP');
   writeln ('KEYB GR,,C:\WINDOWS\KEYBOARD.SYS');
   writeln ('LH C:\MOUSE\MOUSE.COM');
   goto anfang;
  attrib:
   writeln (' A         C:\AUTOEXEC.BAT');
   writeln (' A S       C:\COMMAND.COM');
   writeln (' A         C:\CONFIG.SYS');
   writeln (' A S R     C:\IO.SYS');
   writeln (' A S R     C:\MSDOS.SYS');
   writeln;
   goto ANFANG;
  ver:
   writeln;
   writeln ('MS-DOS VERSION 6.22');
   writeln;
   writeln;
   goto ANFANG;
  dir:
   writeln ('DatentrÑger im Laufwerk ist:  Windows 95');
   writeln ('DatentrÑgernummer: 2F87-9466');
   writeln ('Verzeichniss von C:\');
   writeln;
   writeln ('AUTOEXEC BAT        350 05-05-95  12:01p');
   writeln ('COMMAND  COM      50031 05-05-95  12:00p');
   writeln ('CONFIG   SYS        323 05-05-95  12:01p');
   writeln ('IO       SYS      33663 05-05-95  12:00p');
   writeln ('MSDOS    SYS      37426 05-05-95  12:00p');
   writeln ('        5 Datei(en)    121793  Byte');
   writeln ('                    795155648  Byte');
   writeln;
   goto ANFANG;
  cls:
   CLRSCR;
   goto anfang;
  dirw:
   writeln ('DatentrÑger im Laufwerk ist:  Windows 95');
   writeln ('DatentrÑgernummer: 2F87-9466');
   writeln ('Verzeichniss von C:\');
   writeln;
   writeln ('AUTOEXEC.BAT   COMMAND.COM   CONFIG.SYS    IO.SYS         MSDOS.SYS');
   writeln ('        5 Datei(en)    121793  Byte');
   writeln ('                     795155648 Byte');
   writeln;
   goto anfang;
  Para:
   writeln ('Erforderliche(r) Parameter feht(en) - ');
   writeln;
   goto Anfang;
 goto ANFANG;
 ENDE:
  writeln ('Warnung ! Alle Daten auf der Festplatte C: werden gelîscht');
  write ('Formatierung durchfÅhren (J/N)? ');
  readln (b);
  if b = ('N') then goto anfang;
  if b = ('n') then goto anfang;
END.