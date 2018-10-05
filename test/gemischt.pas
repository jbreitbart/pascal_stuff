UNIT Gemischt;


{ ------------------------------------------------------------------------ }

{ In dieser Unit befinden sich hilfreiche Add-Ins fÅr Turbo Pascal         }

{ (C)opyright Kai Burkard    30. September 1997  bis 09. Mai 1998          }

{ ------------------------------------------------------------------------ }



INTERFACE

USES Crt, Graph, Dos;

CONST HiRes  = 2;
      LowRes = 0;
      Cr = '(C)opyright 1997/98 by Kai Burkard      Telefon & Fax: 06626 / 919414';
      WMenu = 'Datei  Bearbeiten  Ansicht  ?';

{ ***** Grafik allgemein ***** }
PROCEDURE Grafikmodus;
PROCEDURE SVgaModus (Treiber : String; Modus : Byte);

{ ***** Knîpfe und SchaltflÑchen ***** }

PROCEDURE Button(X1, Y1, X2, Y2 : Integer; Pushed : Boolean; Design : Byte);
PROCEDURE TextButton  (X1, Y1, X2, Y2 : Integer; PP : Boolean; Txt : String);
PROCEDURE Display     (X1, Y1, X2, Y2 : Integer; PP : Boolean; Color : Byte);
PROCEDURE RoundButton (X1, Y1, Radius : Integer; Color : Byte);
PROCEDURE Switch      (X, Y : Integer; S : Boolean);
PROCEDURE WinButton   (X, Y : Integer);

{ ***** Fenster und Windows ***** }
PROCEDURE TextFenster   (X1, Y1, X2, Y2 : Integer; Titel : String);
PROCEDURE GrafikFenster (X1, Y1, X2, Y2 : Integer; Titel : String);

{ ***** Windows OberflÑchen - Objekte ***** }
PROCEDURE WWindow(X1, Y1, X2, Y2, Color : Integer; Titel, Menu : String);
PROCEDURE WMessageBox(Title, Message : String; Art : Byte);

{ ***** Allgemeine Erleichterungen ***** }
PROCEDURE WaitKey;
PROCEDURE ReadText(X,Y : Integer; Var Egbe : String);

{ ***** Laden / Speichern von bestimmten Dateien ***** }
PROCEDURE LoadClip  (X1, Y1 : Integer; Datei : String);
PROCEDURE SaveClip  (X1, Y1, X2, Y2 : Integer; Datei : String);
PROCEDURE LoadPic (Name : String);
PROCEDURE SavePic (Name : String);
PROCEDURE LoadIcon(X1,Y1:Integer;Datei:String;Durch:Byte);
PROCEDURE LoadWindowsIcon(X,Y : Integer; Datei : String; V : Byte);
PROCEDURE LoadBMP(Dat : String);
PROCEDURE SaveBMP(Dat : String);

{ ***** Rund um die Maussteuerrung ***** }
PROCEDURE MouseInit;
PROCEDURE MouseShow(Zeiger : Byte);
PROCEDURE MouseHide(Zeiger : Word);
FUNCTION  MouseIn   (X1, Y1, X2, Y2 : Integer) : Boolean;
FUNCTION  Maustaste(Taste : Byte) : Boolean;
FUNCTION  SelectButton(X1, Y1, X2, Y2 : Integer) : Boolean;
FUNCTION  LMouse : Boolean;
FUNCTION  RMouse : Boolean;
FUNCTION  XMouse : Integer;
FUNCTION  YMouse : Integer;

{ ***** Einfache Grafikbefehle ***** }
PROCEDURE Box(X1, Y1, X2, Y2 : Integer; Color : Byte);
PROCEDURE Kugel(X1, Y1, Radius : Integer; Color : Byte);

{ ***** Proceduren die Paletten festlegen ***** }
PROCEDURE PaletteRGB;
PROCEDURE PaletteRGB2;
PROCEDURE WindowsPalette;
PROCEDURE GetRGBPalette(ColorNum:Integer; Var RedNum,GreenNum,BlueNum: Byte);

{ ***** Abspielen von Sounds ***** }
PROCEDURE PlayAudioCD(Start,Length : LONGINT);

{ ------------------------------------------------------------------------ }



IMPLEMENTATION

TYPE arrayofbyte= Array[0..$1A] of Byte;
     arrayofchar1= Array [0..37] of char;
     arrayofchar= Array [0..2047] of char;

const copyright=0;
      abstract=1;
      docum=2;


VAR Regs : Registers;
    A : Byte;
    ParamBlock: ArrayofByte;
    i : Integer;
    CDROM : Boolean;
    anz_lw,lw_id:Byte;
    copyrightfilename,abstractfilename,documfilename:ArrayofChar1;
    dump,vtoc : Arrayofchar;
    SBAvailable : BOOLEAN;

  Procedure GetRGBPalette(ColorNum:Integer; Var RedNum,GreenNum,BlueNum: Byte);
    Type
      {PaletteType=Record      ...turbo preset type...
          Size: Byte;
          Colors: Array[0..maxcolors] of ShortInt;
        End;       }
      CGAColors = Array[0..11] of byte;

    Const                     {the four CGA palettes}
      C0:CGAColors = (  0,  0,  0, 85,255, 85,255, 85, 85,255,255, 85);
      C1:CGAColors = (  0,  0,  0, 85,255,255,255, 85,255,255,255,255);
      C2:CGAColors = (  0,  0,  0,  0,170,  0,170,  0,  0,170, 85,  0);
      C3:CGAColors = (  0,  0,  0,  0,170,170,170,  0,170,170,170,170);

    Var
      Palette:PaletteType;
      ColorValue: ShortInt;
      ColorIndex: Integer;
      Regs: Registers;
      CGAPalette: CGAColors;

    Begin
      Case GetMaxColor of
        1: Begin                                     {2 color}
             Case ColorNum of
               0: Begin RedNum:=0; GreenNum:=0; BlueNum:=0; End;
               1: Begin RedNum:=255; GreenNum:=255; BlueNum:=255;  End;
             End;
           End;
        3: Begin                                     {4 color}
             Case GetGraphMode of
               0: CGAPalette:=C0;
               1: CGAPalette:=C1;
               2: CGAPalette:=C2;
               3: CGAPalette:=C3;
             End;
             RedNum:=  CGAPalette[ColorNum*3+0];
             GreenNum:=CGAPalette[ColorNum*3+1];
             BlueNum:= CGAPalette[ColorNum*3+2];
           End;
       15: Begin                                     {16 color modes}
             GetPalette(Palette);
             If (GetMaxY<349)
               Then                 {EGA palette byte code: 765I3RGB}
                 Begin
                   ColorValue:=Palette.Colors[ColorNum] SHR 4;
                   If Odd(ColorValue)
                     Then
                       Begin
                         RedNum:=1; GreenNum:=1; BlueNum:=1;
                       End
                     Else
                       Begin
                         RedNum:=0; GreenNum:=0; BlueNum:=0;
                       End;
                 End
               Else                 {VGA palette byte code: 76rgbRGB}
                 Begin
                   ColorValue:=Palette.Colors[ColorNum] SHR 3;
                   If Odd(ColorValue) then BlueNum:=1 else BlueNum:=0;
                   ColorValue:=ColorValue shr 1;
                   If Odd(ColorValue) then GreenNum:=1 else GreenNum:=0;
                   ColorValue:=ColorValue shr 1;
                   If Odd(ColorValue) then RedNum:=1 else RedNum:=0;
                 End;

             ColorValue:=Palette.Colors[ColorNum];
             If Odd(ColorValue) then BlueNum:=BlueNum+2;
             ColorValue:=ColorValue shr 1;
             If Odd(ColorValue) then GreenNum:=GreenNum+2;
             ColorValue:=ColorValue shr 1;
             If Odd(ColorValue) then RedNum:=RedNum+2;

             RedNum:=RedNum*85;        {85=255/3...brings 0-3value to}
             GreenNum:=GreenNum*85;    {0-255 range}
             BlueNum:=BlueNum*85;
           End;
      255: Begin                        {256 Colors}
             Regs.AH:=$10;              {Read contents of multiple DAC registers}
             Regs.AL:=$15;
             Regs.BX:=ColorNum;         {The DAC color register of interest}
             Intr($10,Regs);
             RedNum:=Regs.DH*4;         {DAC is 18 bit, 6 bits each R,G,and B}
             GreenNum:=Regs.CH*4;       {thus DAC.R ranges 0-63}
             BlueNum:=Regs.CL*4;        {so multiply by 4 to range 0-255}
           End;   { 255}
     End;  {case GetMaxColor of}
  End;    {getRGBPalette}


function Installed:Boolean;
begin
 regs.ax:=$1500; {Anz. CD-LW}
 regs.bx:=$0;
 intr($2F,regs);
 Anz_LW:=regs.bx;
 LW_ID:=regs.cx;
 if regs.bx>0 then Installed:=true else Installed:=False;
end;

Function Version:REAL;
begin
 regs.ax:=$150C; {Version}
 intr($2F,regs);
 version:=regs.bh+regs.bl/100;
end;

function getfilename(LW_ID: Integer; var FileName: arrayofchar1; Filesort:Integer):boolean;
begin
 regs.ax:=$1502+Filesort; {Nam}
 regs.cx:=LW_ID;
 regs.es:=seg(Filename);
 regs.bx:=ofs(Filename);
 intr($2F,regs);
 if (regs.flags AND FCarry) =0 then getfilename:=true else getfilename:=false;
end;

function ReadVTOC(LW_ID,VTOC_NUM:Integer; var buffer: Arrayofchar):Boolean;
begin
 regs.ax:=$1505; {VTOC lesen}
 regs.cx:=LW_ID;
 regs.dx:=VTOC_NUM;
 regs.es:=seg(Buffer);
 regs.bx:=ofs(Buffer);
 intr($2F,regs);
 if (regs.flags and FCarry) =0 then readVTOC:=true else ReadVTOC:=false;
end;

Function Readcd(LW_ID: Integer; Firstsec: LONGINT; anz_Sec:Integer; var Buf:Arrayofchar) :Boolean;
begin
 regs.ax:=$1508;
 regs.cx:=LW_ID;
 regs.si:=FirstSec shr 16;
 regs.di:=firstsec and $FFFF;
 regs.dx:=Anz_Sec;
 regs.es:=seg(buf);
 regs.bx:=ofs(buf);
 intr($2F,regs);
 if (Regs.flags and fcarry)=0 then readcd:=true
 else readcd:=false;
end;

Function senddevicerequest(command : Byte; lw_id : Integer; var Paramblock: arrayofByte): word;
begin
 paramblock[2]:=Command;
 regs.ax:=$1510;
 regs.cx:=LW_ID;
 regs.es:=seg(Paramblock);
 regs.bx:=ofs(Paramblock);
 intr($2F,regs);
 senddevicerequest:=word(Paramblock[4]*256+Paramblock[3]);
end;

procedure writeErrors(Status:Word);
begin
 if(status AND (1 shl 8)) <> 0 then write('Funktion ausgefÅhrt');
 if(status AND (1 shl 9)) <> 0 then write(' (Playing).')
 else writeln;
 if (Status and (1 shl 15)) <> 0 then begin
  writeln('Fehler: ');
  case Lo(status) of
   $00: writeln('Kein Schreibzugriff mîglich');
   $01: writeln('Unbekanntes Laufwerk');
   $02: Writeln('Laufwerk nicht bereit (Keine CD ?)');
   $03: writeln('Unbekannte Funktion');
   $04: writeln('CRC-Fehler');
   $05: writeln('Parameter-Block falscher LÑnge');
   $06: writeln('Suchfehler');
   $07: writeln('Falsches CD-ROM-Format');
   $08: writeln('Sektor nicht gefunden');
   $0A: writeln('Schreibfehler');
   $0B: writeln('Lesefehler');
   $0C: writeln('Fehler');
   $0E: writeln('Kein Medium');
   $0F: Writeln('UngÅlziger Medienwechsel');
  end;
 end;
end;

PROCEDURE PlayAudioCD(Start,Length : LONGINT);
BEGIN
 For i:= 0 to $1A DO paramblock[i]:=0;
 paramblock[$0e]:=Lo(Start);
 paramblock[$0F]:=Hi(Start);
 Paramblock[$12]:=Lo(Length);
 Paramblock[$13]:=Hi(Length);
 writeerrors(Senddevicerequest($84,LW_ID,ParamBlock));
END;


PROCEDURE WindowsPalette;
VAR Dat : File Of Byte;
    R, G, B, T : Byte;
    X : Integer;
BEGIN
 Assign(Dat,'C:\Pascal\Win.pal');
 Reset(Dat);
 For X:=1 To 62 Do Read(Dat,R);
 For X:=0 To 255 Do
 Begin
   Read(Dat,R);
   Read(Dat,G);
   Read(Dat,B);
   Read(Dat,T);
   SetRGBPalette(X,R,G,B);
 End;
 Close(Dat);
END;

PROCEDURE SavePic(Name : String);
VAR Speicher : Array[0..639] Of Byte;
    Lx, Ly, Bereich, Resultat : Word;
    Datei : File;
BEGIN
  Bereich:=639;
  Assign(Datei, Name); Rewrite(Datei);
  For Ly:=0 To 479 Do
  Begin
  For Lx:=0 To 639 Do
  Begin
   Speicher[Lx]:=GetPixel(Lx,Ly);
  End;
  BlockWrite(Datei, Speicher, Bereich, Resultat);
  End;
  Close(Datei);
END;

PROCEDURE LoadPic(Name : String);
VAR Speicher : Array[0..639] Of Byte;
    Lx, Ly, Bereich, Resultat : Word;
    Datei : File;
BEGIN
  Bereich:=639;
  Assign(Datei, Name); Reset(Datei);
  For Ly:=0 To 479 Do
  Begin
  BlockRead(Datei, Speicher, Bereich, Resultat);
  For Lx:=0 To 639 Do
  Begin
   If GetPixel(Lx,Ly)=Speicher[Lx] Then Else PutPixel(Lx,Ly,Speicher[Lx]);
  End;
  End;
  Close(Datei);
END;

PROCEDURE PaletteRGB;
VAR X : Integer;
BEGIN
 For X:=1 To 60 Do
 SetRGBPalette(X,X,0,0);
 For X:=61 To 121 Do
 SetRGBPalette(X,0,X-60,0);
 For X:=122 To 182 Do
 SetRGBPalette(X,0,0,X-121);
 For X:=183 To 243 Do
 SetRGBPalette(X,X-182,X-182,X-182);
 For X:=244 To 255 Do
 SetRGBPalette(X,0,0,0);
END;

PROCEDURE ReadText(X,Y : Integer; Var Egbe : String);
VAR AX : Integer;
    Ch : Char;
    LBuchstabe, Buchstabe : String;
BEGIN
 AX:=X;
 SetTextJustify(RightText,BottomText);
 Buchstabe:='';
 Repeat
 Repeat
  SetColor(White);
  Line(AX, Y, AX, Y-10);
 Until KeyPressed;
  SetColor(Black);
  Line(AX, Y, AX, Y-10);
  SetColor(White);
  Ch := ReadKey;
  LBuchstabe:=Buchstabe;
  Buchstabe:=Ch;
  If (Ch<>Chr(13)) and (Ch<>Chr(8)) Then Egbe:=Egbe+LBuchstabe;
  If Ch=Chr(8) Then Egbe:=Egbe;
  If (Ch<>Chr(13)) and (Ch<>Chr(8)) Then OutTextXY(AX,Y,Buchstabe);
  If Ch<>Chr(8) Then AX:=AX+7 Else AX:=AX-7;
  If Ch=Chr(8) Then Box(AX-8,Y,AX,Y-10,Black);
 Until Ch=Chr(13);
 If LBuchstabe<>Chr(8) Then Egbe:=Egbe+LBuchstabe;
END;

PROCEDURE LoadWindowsIcon(X,Y : Integer; Datei : String; V : Byte);
VAR Dat : File Of Byte;
    C : Byte;
    Lx, Ly : Word;
BEGIN
 Assign(Dat,'C:\Pascal\Icons\'+Datei+'.ico');
 Reset(Dat);
 For Lx := 1 To 1214 Do Read(Dat,C); { öberspringen der Palettendaten }
 For Ly := 32 DownTo 5 Do
 For Lx := 1 To 32 Do
 Begin
  Read(Dat,C);
  Box(Lx*V+X,Ly*V+Y,Lx*V+X+V, Ly*V+Y+V, C);
 End;
 Close(Dat);
END;


PROCEDURE PaletteRGB2;
VAR X : Integer;
BEGIN
 For X:=001 To 050 Do
 SetRGBPalette(X,X,0,0);
 For X:=051 To 100 Do
 SetRGBPalette(X,0,X-50,0);
 For X:=101 To 150 Do
 SetRGBPalette(X,0,0,X-100);
 For X:=151 To 200 Do
 SetRGBPalette(X,X-150,X-150,0);
 For X:=201 To 250 Do
 SetRGBPalette(X,X-200,X-200,X-200);
 For X:=251 To 255 Do
 SetRGBPalette(X,0,0,0);
END;






PROCEDURE Box(X1,Y1,X2,Y2 : Integer; Color : Byte);
BEGIN
 SetFillStyle(1,Color);
 Bar(X1,Y1,X2,Y2);
END;

PROCEDURE SVGA(Card:String;Modus:Byte);
VAR GT, TT, GM : Integer;
{$F+}
 FUNCTION TestDetect0:Integer;
 BEGIN
   TestDetect0:=0;
 END;
 FUNCTION TestDetect1:Integer;
 BEGIN
   TestDetect1:=1;
 END;
 FUNCTION TestDetect2:Integer;
 BEGIN
   TestDetect2:=2;
 END;
 FUNCTION TestDetect3:Integer;
 BEGIN
   TestDetect3:=3;
 END;
 FUNCTION TestDetect4:Integer;
 BEGIN
   TestDetect4:=4;
 END;
{$F-}
BEGIN
 If Modus=0 Then TT:=InstallUserDriver(Card,@TestDetect0);
 If Modus=1 Then TT:=InstallUserDriver(Card,@TestDetect1);
 If Modus=2 Then TT:=InstallUserDriver(Card,@TestDetect2);
 If Modus=3 Then TT:=InstallUserDriver(Card,@TestDetect3);
 If Modus=4 Then TT:=InstallUserDriver(Card,@TestDetect4);
 GT:=Detect;
 InitGraph(GT,GM,'');
END;


PROCEDURE MouseInit;
BEGIN
  a := mem[$0040:$0049];
  if a=7 then mem[$0040:$0049]:=6; {Herkules Åberlisten}
  Regs.AX:=0;
  Intr($33,Regs);
  IF Regs.AX=0 THEN
  BEGIN
    Writeln;
    Writeln('Maustreiber nicht geladen! Programm abgebrochen',#7);
    Halt(1);
  END;
END;

PROCEDURE LoadIcon(X1,Y1:Integer;Datei:String;Durch:Byte);
VAR F : Text;
    X, Y, C : Integer;
BEGIN
 Assign(F,'C:\Pascal\Icons\'+Datei+'.tpi');
 Reset(F);
 For X:=0 To 64 Do
  For Y:=0 To 63 Do
  BEGIN
   ReadLn(F,C);
   If C<>Durch Then
   BEGIN
    PutPixel(X1+X,Y1+Y,C);
   END;
  END;
 Close(F);
END;

PROCEDURE MouseShow(Zeiger : Byte);
BEGIN
  Regs.AX := Zeiger;
  Intr($33,Regs);
END;

PROCEDURE MouseHide(Zeiger : Word);
BEGIN
  With Regs do
  begin
   AH := 1;
   BH := 0;
   CX := Zeiger;
   Intr($10, Regs);
  end;
END;

FUNCTION  XMouse : Integer;
BEGIN
 Regs.AX := 3;
 Intr($33,Regs);
 XMouse := Regs.CX
END;

FUNCTION  YMouse : Integer;
BEGIN
 Regs.AX := 3;
 Intr($33,Regs);
 YMouse := Regs.DX;
END;

FUNCTION  MouseIn   (X1, Y1, X2, Y2 : Integer) : Boolean;
BEGIN
 If (XMouse>X1) and (XMouse<X2) and (YMouse>Y1) and (YMouse<Y2) Then MouseIn:=True Else MouseIn:=False;
END;

FUNCTION SelectButton(X1, Y1, X2, Y2 : Integer) : Boolean;
BEGIN
 IF MouseIn(X1, Y1, X2, Y2) and LMouse Then SelectButton:=True;
END;

FUNCTION Maustaste(Taste : Byte) : Boolean;
BEGIN
   Regs.AX := 3;
   Intr($33,Regs);
   Maustaste := ((1 Shl (Taste-1)) And Regs.BX)<>0;
END;

PROCEDURE Switch(X,Y:Integer;S:Boolean);
BEGIN
 Button(X,Y,X+30,Y+50,True,1);
 If S=True Then Display(X+7,Y+6,X+23,Y+20,True,Green) Else Display(X+7,Y+6,X+23,Y+20,True,LightGreen);
 If S=False Then Display(X+7,Y+30,X+23,Y+44,True,Red) Else Display(X+7,Y+30,X+23,Y+44,True,LightRed);
END;

FUNCTION  LMouse : Boolean;
BEGIN
 If Maustaste(1) Then LMouse:=True Else LMouse:=False;
END;

FUNCTION  RMouse : Boolean;
BEGIN
 If Maustaste(2) Then RMouse:=True Else RMouse:=False;
END;


PROCEDURE LoadClip(X1, Y1 : Integer; Datei : String);
VAR Dat : File of Byte;
    Lv1, Lv2 : Integer;
    Farbe, Ew1, Ew2 : Byte;
BEGIN
 Assign(Dat,Datei+'.BLD');
 Reset(Dat);
 Read(Dat,Ew1);
 Read(Dat,Ew2);
 For Lv2:=Y1 To Y1+Ew2 Do
 For Lv1:=X1 To X1+Ew1 Do
 BEGIN
  Read(Dat,Farbe);
  PutPixel(Lv1,Lv2,Farbe);
 END;
 Close(Dat);
END;

PROCEDURE SaveClip(X1, Y1, X2, Y2 : Integer; Datei : String);
VAR Dat : File of Byte;
    Lv1, Lv2 : Integer;
    Farbe : Byte;
BEGIN
 Assign(Dat,Datei+'.BLD');
 Rewrite(Dat);
 Farbe:=X2-X1;
 Write(Dat,Farbe);
 Farbe:=Y2-Y1;
 Write(Dat,Farbe);
 For Lv2:=Y1 To Y2 Do
 For Lv1:=X1 To X2 Do
 BEGIN
   Farbe:=GetPixel(Lv1,Lv2);
   Write(Dat,Farbe);
 END;
 Close(Dat);
END;


PROCEDURE RoundButton (X1, Y1, Radius : Integer; Color : Byte);
BEGIN
 A:=GetColor;
 SetColor(Brown);
 Circle(X1,Y1,Radius);
 SetFillStyle(9,Color);
 FloodFill(X1,Y1,Brown);
 SetColor(A);
END;


PROCEDURE TextFenster   (X1, Y1, X2, Y2 : Integer; Titel : String);
VAR Lv, Lv2 : Integer;
BEGIN
 TextColor(Black);
 For Lv:=X1 To X2 Do
 For Lv2:=Y1 To Y2 Do
 BEGIN
   GotoXY(Lv,Lv2);
   Write('€');
 END;
 TextColor(White);
 For Lv:=X1 To X2 Do
 BEGIN
   GotoXY(Lv,Y1); Write('Õ');
   GotoXY(Lv,Y2); Write('Õ');
 END;
 For Lv:=Y1 To Y2 Do
 BEGIN
   GotoXY(X1,Lv); Write('∫');
   GotoXY(X2,Lv); Write('∫');
 END;
 GotoXY(X2,Y1); Write('ª');
 GotoXY(X2,Y2); Write('º');
 GotoXY(X1,Y2); Write('»');
 GotoXY(X1,Y1); Write('…');
 GotoXY(X1+3,Y1); Write(Titel);
END;


PROCEDURE Grafikmodus;
VAR Treiber, Modus : Integer;
BEGIN
 Treiber:=Detect;
 InitGraph(Treiber,Modus,'');
END;

PROCEDURE SVgaModus(Treiber:String; Modus:Byte);
BEGIN
 SVGA(Treiber,Modus);
END;


PROCEDURE Button(X1, Y1, X2, Y2 : Integer; Pushed : Boolean; Design : Byte);
VAR L : Integer;
BEGIN

If Design=1 Then
BEGIN
  Box(X1,Y1,X2,Y2,Black);
  If Pushed=True Then SetColor(White) Else SetColor(DarkGray);
   Line(X1+1,Y1+1,X2-1,Y1+1);
   Line(X1+1,Y1+1,X1+1,Y2-1);
  If Pushed=True Then SetColor(DarkGray) Else SetColor(White);
  Line(X2-1,Y2-1,X1+1,Y2-1);
  Line(X2-1,Y2-1,X2-1,Y1+1);
  Box(X1+2,Y1+2,X2-2,Y2-2,LightGray);
END;

If Design=2 Then
BEGIN
 Box(X1,Y1,X2,Y2,Black);
 Box(X1+1,Y1+3,X2-1,Y2-3,LightGray);
 L:=X1-1;
 Repeat
  L:=L+2;
 If Pushed=True Then
 BEGIN
  PutPixel(L,Y1+4,White);
  PutPixel(L+1,Y1+5,White);
  PutPixel(L,Y2-5,DarkGray);
  PutPixel(L+1,Y2-4,DarkGray);
  Box(X1+1,Y1+1,X2-1,Y1+3,White);
  Box(X1+1,Y2-3,X2-1,Y2-1,DarkGray);
 END;
 If Pushed=False Then
 BEGIN
  PutPixel(L,Y1+4,DarkGray);
  PutPixel(L+1,Y1+5,DarkGray);
  PutPixel(L,Y2-5,White);
  PutPixel(L+1,Y2-4,White);
  Box(X1+1,Y1+1,X2-1,Y1+3,DarkGray);
  Box(X1+1,Y2-3,X2-1,Y2-1,White);
 END;
 Until L>X2-4;
END;

END;


PROCEDURE TextButton(X1, Y1, X2, Y2 : Integer; PP : Boolean; Txt : String);
BEGIN
 Button(X1, Y1, X2, Y2, PP,1);
 SetColor(Black);
 SetTextJustify(CenterText,CenterText);
 OutTextXY(X1+Round((X2-X1)/2),Y1+1+Trunc((Y2-Y1)/2),Txt);
END;

PROCEDURE Display(X1, Y1, X2, Y2 : Integer; PP : Boolean; Color : Byte);
BEGIN
 SetFillStyle(1,Black);
 Bar(X1+1, Y1+1, X2-1, Y2-1);
 SetFillStyle(1,Color);
 Bar(X1+1, Y1+1, X2-1, Y2-1);
 If PP=True Then SetColor(White)    Else SetColor(DarkGray);
 Line(X1+1, Y1+1, X2-1, Y1+1);
 Line(X1+1, Y1+1, X1+1, Y2-1);
 If PP=True Then SetColor(DarkGray) Else SetColor(White);
 Line(X2-1, Y2-1, X1+1, Y2-1);
 Line(X2-1, Y2-1, X2-1, Y1+1);
 SetColor(Black);
 Rectangle(X1, Y1, X2, Y2);
END;

PROCEDURE Kugel(X1, Y1, Radius : Integer; Color : Byte);
BEGIN
 SetColor(Color);
 SetFillStyle(1,Color);
 PieSlice(X1, Y1, 0, 360, Radius);
END;

PROCEDURE GrafikFenster (X1, Y1, X2, Y2 : Integer; Titel : String);
BEGIN
 Button(X1,Y1,X2,Y2,True,1);
 TextButton(X1+2,Y1+2,X2-2,Y1+14,True,Titel);
 Display(X1+2,Y1+16,X2-2,Y2-2,False,White);
END;

PROCEDURE WinButton   (X, Y : Integer);
BEGIN
 Box(X,Y,X+39,Y+32,Black);
 LoadIcon(X+1,Y+1,'3DButton',Black);
END;

PROCEDURE WaitKey;
BEGIN
 Repeat Until KeyPressed;
END;

PROCEDURE WWindow(X1, Y1, X2, Y2, Color : Integer; Titel, Menu : String);
BEGIN
 Box(X1, Y1, X2, Y2, LightGray);
 Box (X1+04, Y1+05, X2-04, Y1+22, Color);
 Box (X1+06, Y1+47, X2-06, Y2-28, White);
 Box (X2-19, Y1+08, X2-07, Y1+20, LightGray);
 Box (X2-23, Y1+08, X2-35, Y1+20, LightGray);
 Box (X2-37, Y1+08, X2-49, Y1+20, LightGray);
 SetColor(White);
  Line(X1   , Y1+01, X2-01, Y1+01);
  Line(X1   , Y1+01, X1   , Y2-01);
  Line(X2-04, Y1+45, X2-04, Y2-26);
  Line(X2-04, Y2-26, X1+04, Y2-26);
  Line(X1+04, Y2-04, X2-14, Y2-04);
  Line(X2-04, Y2-14, X2-04, Y2-22);
  Line(X2-14, Y2-04, X2-04, Y2-14);
  Line(X2-11, Y2-04, X2-04, Y2-11);
  Line(X2-08, Y2-04, X2-04, Y2-08);
  Line(X2-05, Y2-04, X2-04, Y2-05);
  Line(X2-07, Y1+07, X2-19, Y1+07);
  Line(X2-19, Y1+07, X2-19, Y1+20);
  Line(X2-23, Y1+07, X2-35, Y1+07);
  Line(X2-35, Y1+07, X2-35, Y1+20);
  Line(X2-37, Y1+07, X2-49, Y1+07);
  Line(X2-49, Y1+07, X2-49, Y1+20);
 SetColor(DarkGray);
  Line(X1   , Y2   , X2   , Y2   );
  Line(X2   , Y2   , X2   , Y1+01);
  Line(X1+04, Y1+45, X2-05, Y1+45);
  Line(X1+04, Y1+45, X1+04, Y2-27);
  Line(X1+04, Y2-05, X1+04, Y2-22);
  Line(X1+04, Y2-22, X2-05, Y2-22);
  Line(X2-12, Y2-04, X2-04, Y2-12);
  Line(X2-09, Y2-04, X2-04, Y2-09);
  Line(X2-06, Y2-04, X2-04, Y2-06);
  Line(X2-07, Y1+08, X2-07, Y1+20);
  Line(X2-07, Y1+20, X2-18, Y1+20);
  Line(X2-23, Y1+08, X2-23, Y1+20);
  Line(X2-23, Y1+20, X2-34, Y1+20);
  Line(X2-37, Y1+08, X2-37, Y1+20);
  Line(X2-37, Y1+20, X2-48, Y1+20);
 SetColor(Black);
  Line(X1+05, Y1+46, X1+05, Y2-28);
  Line(X1+05, Y1+46, X2-06, Y1+46);
  Line(X2-10, Y1+11, X2-16, Y1+17);
  Line(X2-10, Y1+17, X2-16, Y1+11);
  Line(X2-46, Y1+17, X2-40, Y1+17);
  Line(X2-46, Y1+18, X2-40, Y1+18);
  Line(X2-32, Y1+17, X2-26, Y1+17);
  Line(X2-32, Y1+17, X2-32, Y1+12);
  Line(X2-26, Y1+17, X2-26, Y1+12);
  Line(X2-26, Y1+12, X2-32, Y1+12);
  Line(X2-26, Y1+11, X2-32, Y1+11);
 If X2-X1>119 Then
 Begin
  SetColor(White);
  Line(X1+097, Y2-22, X1+097, Y2-04);
  SetColor(DarkGray);
  Line(X1+100, Y2-22, X1+100, Y2-04);
  SetColor(LightGray);
  Line(X1+098, Y2-22, X1+099, Y2-22);
  Line(X1+098, Y2-04, X1+099, Y2-04);
 End;
 SetTextJustify(LeftText, BottomText);
 SetTextStyle(0,0,1);
 SetColor(Black);
 OutTextXY(X1+14, Y1+38, Menu);
 SetColor(White);
 OutTextXY(X1+22, Y1+19, Titel);
END;

PROCEDURE WMessageBox(Title, Message : String; Art : Byte);
VAR L : Integer;
BEGIN
 L:=Length(Message);
 L:=L*5;
 Button(320-L,200,320+L,280,True,1);
 SetTextJustify(CenterText,CenterText);
 SetTextStyle(0,0,1);
 SetColor(Black);
 OutTextXY(320,235,Message);
 Box(320-L+3,203,320+L-3,218,Blue);
 SetColor(White);
 OutTextXY(320,211,Title);
 If Art=1 Then
 Begin
  TextButton(284,253,356,272,True,'OK');
 End;
 If Art=2 Then
 Begin
  TextButton(247,253,319,272,True,'OK');
  TextButton(321,253,393,272,True,'Chancel');
 End;
 If Art=3 Then
 Begin
  TextButton(247,253,319,272,True,'Ja');
  TextButton(321,253,393,272,True,'Nein');
 End;
 If Art=4 Then
 Begin
  TextButton(284,253,356,272,True,'Weiter');
 End;
END;

PROCEDURE LoadBMP(Dat : String);
{ Dieser LoadBMP - Befehl schafft es leider nur, Windows - BMPs mit einer
  Grî·e von 640 x 480 bei 256 Farben zu laden                             }
VAR L, X, Y : Integer;
    Datei : File;
    P : Array[0..3] Of Byte;
    Colour : Array[0..639] Of Byte;
    T : Word;
BEGIN
 { Datei îffnen }
 Assign(Datei,Dat+'.BMP');
 Reset(Datei,1);
 { Bitmap - Informationen Åberspringen }
   BlockRead(Datei,Colour,53,T);
 { Paletten - Informationen einlesen und Palette bearbeiten }
 For L:=0 To 254 Do
 Begin
   BlockRead(Datei,P,4,T);
   SetRGBPalette(L,Round(P[3]/255*62),Round(P[2]/255*62),Round(P[1]/255*62));
 End;
 { Bitmap einlesen und auf Bildschirm darstellen }
 For Y:=479 DownTo 0 Do
 Begin
   BlockRead(Datei,Colour,640,T);
   For X:=0 To 639 Do PutPixel(X,Y,Colour[X]);
   If KeyPressed Then Halt;
 End;
 { Datei schlie·en }
 Close(Datei);
END;

PROCEDURE SaveBMP(Dat : String);
{ Dieser LoadBMP - Befehl schafft es leider nur, Windows - BMPs mit einer
  Grî·e von 640 x 480 bei 256 Farben zu speichern                          }
CONST BmpIni : Array[0..52] Of Byte =
 (66,77,14,176,4,0,0,0,0,0,54,4,0,0,40,0,0,0,128,2,0,0,224,1,0,0,1,0,8,0,0,0,
  0,0,0,176,4,0,97,15,0,0,97,15,0,0,0,0,0,0,0,0,0);
VAR L, X, Y : Integer;
    Datei : File;
    P : Array[0..3] Of Byte;
    Colour : Array[0..639] Of Byte;
    T : Word;
BEGIN
 Assign(Datei,Dat+'.BMP');
 Rewrite(Datei,1);
   BlockWrite(Datei,BmpIni,53,T);
 For L:=0 To 254 Do
 Begin
   GetRGBPalette(L,P[3],P[2],P[1]);
   P[0]:=0;
   BlockWrite(Datei,P,4,T);
 End;
 For Y:=479 DownTo 0 Do
 Begin
   For X:=0 To 639 Do Colour[X]:=GetPixel(X,Y);
   BlockWrite(Datei,Colour,640,T);
 End;
 Close(Datei);
END;

{ ------------------------------------------------------------------------ }

BEGIN
 ClrScr;
END.
