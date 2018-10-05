PROGRAM TEXTER;

USES CRT,GRAPH,dos,printer;

 VAR                   F :  Text;
                    TEXT : ARRAY[1..100] OF STRING;
     ANZAHL,LAUFVAR,LINE : INTEGER;
                 DIRINFO : SEARCHREC;
               DATEINAME : STRING;


 PROCEDURE TAKELISTER ; FORWARD;
 PROCEDURE LMENUE     ; FORWARD;
 PROCEDURE TAKETEXTER ; FORWARD;
 PROCEDURE KORRECTER  ; FORWARD;
{PROCEDURE SHOWTEXTER ; FORWARD;}

PROCEDURE MENUER;

VAR TASTE : CHAR;

 BEGIN
  Gotoxy(1,1);
  Textbackground(lightgray);
  ClrEol;
  GotoXY(1,1);
  Textcolor(white);
  Write(' T');
  Textcolor(black);
  Write('extverarbeitung');
  Textcolor(white);
  Write(' L');
  Textcolor(black);
  Write('istenverarbeitung');
  Write(' E');
  Textcolor(white);
  write('X');
  Textcolor(black);
  Writeln('it');
  Gotoxy(1,1);
  TASTE := Readkey;
  Case TASTE of
   'T','t' : taketexter;
   'L','l' : lmenue;
   'X','x' : Halt;
  end;
 END;

PROCEDURE nMENUER;

VAR TASTE : CHAR;

 BEGIN
  taste:='ศ';
  Textbackground(black);
  clrscr;
  Gotoxy(1,1);
  Textbackground(lightgray);
  ClrEol;
  GotoXY(1,1);
  Textcolor(white);
  Write(' T');
  Textcolor(black);
  Write('extverarbeitung');
  Textcolor(white);
  Write(' L');
  Textcolor(black);
  Write('istenverarbeitung');
  Write(' E');
  Textcolor(white);
  write('X');
  Textcolor(black);
  Writeln('it');
  Textbackground(black);
  Textcolor(lightgray);
  writeln;
  For laufvar:= 1 to ANZAHL do
   Begin
    Write(laufvar,'. ');
    writeln(TEXT[LAUFVAR]);
    line:=laufvar-17;
    If laufvar > 19 Then
      GotoXY(50,line);
   End;
  gotoxy(1,1);
  TASTE := Readkey;
  Case TASTE of
   'T','t' : taketexter;
   'L','l' : lmenue;
   'X','x' : Halt;
  end;
 END;

PROCEDURE TAKELISTER;

VAR LINE : INTEGER;

 BEGIN
  GotoXY(38,5);
  Textcolor(BLACK);
  Textbackground(LIGHTGRAY);
  Writeln('ษอAnzahl Eintrgeออป');
  GotoXY(38,6);
  Writeln('บ                  บ');
  GotoXY(38,7);
  Writeln('ศออออออออออออออออออผ');
  GotoXY(39,6);
  TEXTBACKGROUND(BLACK);
  TEXTCOLOR(LIGHTGRAY);
  writeln('                ');
  gotoxy(39,6);
  Readln(anzahl);
  gotoxy(1,2);
  writeln('                                                         ');
  writeln('                                                         ');
  writeln('                                                         ');
  writeln('                                                         ');
  writeln('                                                         ');
  writeln('                                                         ');
  writeln('                                                         ');
  gotoxy(1,4);
  For laufvar:= 1 to ANZAHL do
   Begin
    Write(laufvar,'. ');
    readln(TEXT[LAUFVAR]);
    line:=laufvar-17;
    If laufvar > 19 Then
      GotoXY(50,line);
   End;
  lmenue;
 END;

PROCEDURE Laden;
BEGIN
 Textbackground(black);
 Textcolor(lightgray);
 ClrScr;
 WriteLn('Folgende Dateien stehen zur auswahl:');
 WriteLn('-------------------------------------------');
 FindFirst('a:\*.lst',Archive,DirInfo);
 While DosError=0 Do
 BEGIN
  WriteLn(DirInfo.Name);
  FindNext(DirInfo);
 END;
 WriteLn('-------------------------------------------');
 Write('Bitte Dateiname eingeben: ');ReadLn(Dateiname);
 Assign(F,'a:\'+Dateiname+'.lst');
 Reset(F);
 readln(f,anzahl);
 For laufvar:=1 To anzahl Do
 BEGIN
  ReadLn(F,text[laufvar]);
 END;
 Close(F);
 WriteLn;
 WriteLn('Datei erfolgreich geladen');
 ReadLn;
 Laufvar:=0;
 nmenuer;
END;

PROCEDURE Speichern;
BEGIN
 Textcolor(lightgray);
 Textbackground(black);
 ClrScr;
 WriteLn('Folgende Dateien sind bereits vorhanden:');
 WriteLn('-------------------------------------------');
 FindFirst('a:\*.lst',Archive,DirInfo);
 While DosError=0 Do
 BEGIN
  WriteLn(DirInfo.Name);
  FindNext(DirInfo);
 END;
 WriteLn('-------------------------------------------');
 Write('Dateinamen angeben (max. 8 Zeichen): '); ReadLn(DateiName);
 Assign(F,'a:\'+Dateiname+'.lst');
 Rewrite(F);
 writeln(f,Anzahl);
 For laufvar:=1 To anzahl Do
 BEGIN
  WriteLn(F,text[laufvar]);
  Write('.');
 END;
 Close(F);
 WriteLn;
 WriteLn('Speichern erfolgreich');
 laufvar:=1;
 nmenuer;
END;

PROCEDURE LMENUE;

Var CHOOSE: Char;

 Begin
  Gotoxy(19,2);
  Textbackground(lightgray);
  Textcolor(BLACK);
  writeln('Listeอออออออออออออป');
  Gotoxy(19,3);
  writeln('บ   - laden       บ');
  Gotoxy(19,4);
  writeln('บ   - speichern   บ');
  Gotoxy(19,5);
  writeln('บ   - neu         บ');
  Gotoxy(19,6);
  writeln('บ   - korrigieren บ');
  Gotoxy(19,7);
  writeln('บ   - zurck      บ');
  Gotoxy(19,8);
  writeln('ศอออออออออออออออออผ');
  gotoxy(20,3);
  writeln(' L');
  Gotoxy(20,4);
  writeln(' S');
  Gotoxy(20,5);
  Writeln(' N');
  Gotoxy(20,6);
  writeln(' K');
  Gotoxy(20,7);
  writeln(' Q');
  gotoxy(1,1);
  CHOOSE:= readkey;
  Case CHOOSE of
  'l','L' : laden;
  's','S' : speichern;
  'n','N' : takelister;
  'k','K' : korrecter;
  'q','Q' : nmenuer;
  end;
end;

PROCEDURE Taketexter;

Begin
 Textbackground(black);
 textcolor(lightgray);
 clrscr;
 Writeln(' Diese Funktion ist leider noch nicht fertig');
 delay(900);
 menuer;
end;

PROCEDURE Korrecter;
BEGIN
 Textbackground(black);
 Textcolor(lightgray);
 ClrScr;
  Write('Welchen Eintrag korrigieren: '); ReadLn(laufvar);
 ClrScr;
  WriteLn('Sie bearbeiten Eintrag Nummer ',laufvar,'.');
  WriteLn;
  writeln('Alter Eintrag :');
  Writeln(laufvar,'. ',text[laufvar]);
  writeln('Neuer Eintrag');
  write(laufvar,'. ');
  readln(text[laufvar]);
  nmenuer;
END;


Begin
 Anzahl := 0;
 for laufvar:=  1 to 100 do text[laufvar]:=' ';
 Textbackground(BLACK);
 CLRSCR;
 Menuer;
End.
