{$A-,B-,D+,E+,F-,G+,I-,L+,N-,O-,R+,S+,V+,X-}
{$M 16384,0,655360}

Unit Alles;

interface

uses crt,graph,dos;

CONST MouseButtonLeft = $0001;         { linke Maustaste    }
      MouseButtonRight= $0002;         { rechte Maustaste   }
      MouseButtonMid  = $0004;         { mittlere Maustaste }
      MouseHardCursor = 1;
      MouseSoftCursor = 0;
      InsCursor       = $0707;          { unterste Zeile      }
      BlkCursor       = $0007;          { Blockcursor         }
      NoCursor        = $1000;          { unsichtbarer Cursor }
      TPCursor        = $0607;          { Turbo Pascal Cursor }
      dreiTeilCursor  = $875;
      Funktiontaste   = #0;
      Backspace       = #8;
      Return          = #13;
      Tabulator       = #9;
      Escape          = #27;
      F1              = #59;
      F2              = #60;
      F3              = #61;
      F4              = #62;
      F5              = #63;
      F6              = #64;
      F7              = #65;
      F8              = #66;
      F9              = #67;
      F10             = #68;
      Entf            = #83;
      Einfg           = #82;
      Pos1            = #71;
      ende            = #79;
      Bildhoch        = #73;
      Bildrunter      = #81;
      hoch            = #72;
      runter          = #80;
      rechts          = #77;
      links           = #75;

TYPE SCMaskType = RECORD
      Smask : ARRAY[0..15] OF WORD;
      Cmask : ARRAY[0..15] OF WORD;
     END;
     T_Titel    = String[8];
     T_Speicher = Array[1..8] of Byte;

Var Zeichensatz : Array[0..255] of T_Speicher absolute $F000:$FA6E;

{**********************************KAI***************************************}
PROCEDURE Button(x1,y1,x2,y2:Integer;pn:Word);
PROCEDURE Display(x1,y1,x2,y2:Integer;pn,color:Word);
PROCEDURE MessageBox(X,Y:Integer;Message,Name:String);
PROCEDURE Balken(X1,Y1,X2,Y2,Color:Integer);
procedure loadicon(x1,y1:integer;datei:string);
{*******************************Benflash*************************************}
procedure motor;  {MotorgerÑusche}
procedure alarm;  {Alarm Ton}
procedure mg;     {Maschinen GewÑhr}
procedure alarm2; {Alarm Ton 2}
{**********************************ICH***************************************}
PROCEDURE SavePic(Path:String);
PROCEDURE LoadPic(Path:String);
PROCEDURE WaitKey; { Wartet auf Tastendruck}
function zufall (min, max : integer) :Integer; { Random mit Minimum und Maximum}
procedure hideLw(dr:Byte;on:Boolean);{ Versteckt ein Laufwerk}
procedure keepx(kenn:Byte; biswohin:Pointer);{ ErklÑrung siehe unten}
FUNCTION ReadText(X,Y:Integer) : String;{ Fragt Text im Grafikmodus ab}
procedure Datum;{ Gibt das Datum aus}
procedure Uhr;{ Gibt die Uhrzeit aus}
procedure gross(var s:string);{ Wandelt String in Grossbuchstaben um}
procedure loschen(var s :string);{ Lîscht die Leerzeichen aus einem String}
procedure mausrechts;{ Wartet auf rechten Mausklick}
procedure Setcursor (Cur : Word); { VerÑndert die Cursorform}
procedure dreieck (x1,y1,x2,y2,x3,y3:word); { Zeichnet ein Dreieck}
function  inttostr(i:longint):string;
{*************************Irgendwer*anders***********************************}
FUNCTION  MouseInstalled:BOOLEAN;{ Testet ob Maus vorhanden ist }
PROCEDURE MouseInit;{ Initialisiert den Maus-Treiber }
PROCEDURE MouseShow;{ Mauscursor anzeigen }
PROCEDURE MouseHide;{ Mauscursor abschalten }
FUNCTION MouseButton:BYTE;{ Maustasten abfragen }
FUNCTION MouseXpos:WORD;{ X-Position der Maus }
FUNCTION MouseYpos:WORD;{ Y-Position der Maus }
PROCEDURE MouseGotoXY(x,y:WORD);{ Maus positionieren }
PROCEDURE MouseWindow(x1,y1,x2,y2:WORD);{ Legt Bereich fÅr Maus fest }
FUNCTION  MouseInWindow(x1,y1,x2,y2:WORD):BOOLEAN;{ PrÅft, ob Mauszeiger innerhalb eines Bildausschnittes }
PROCEDURE MouseSetTextCursor(Typ:BYTE;Smask,Cmask:WORD);{ Definiert den Mauscursor im Textmodus }
PROCEDURE MouseSetGraphCursor(HotX,HotY:WORD; VAR SCMask);{ Definiert den Mauscursor im Grafikmodus }
{******++**********************Richard***************************************}
Procedure Empfindl(Horiz,Vert : Word);{ Empfindlichkeit der Mausbewegung}
function Testdrive (Drive:Byte):Boolean;{ Testet Laufwerk, gibt true wenn Laufwerk O.K.}
Procedure BigTitel(Titel:T_Titel; PosY:Byte);{ Titel im Textmodus, Titel max. 8 Zeichen}

IMPLEMENTATION

function IntToStr(i: Longint): string;

var s: string[11];

begin
  Str(i, s);
  IntToStr := s;
end;

procedure motor;
Var a:Integer;
 Begin
 for a:= 1 to 300 do
                  begin
                   sound(a);
                   delay (300);
                   nosound;
                  end;
 end;

procedure alarm;
Var a:Integer;
    lv1 : word;
begin
 lv1:=0;
 repeat
 for a:= 1 to 300 do
                  begin
                   sound(a);
                   delay (30);
                  end;
 nosound;
 lv1:=lv1+1;
 until lv1=13;
end;

procedure MG;
Var a:Integer;
begin
 repeat
  for a:= 1 to 300 do
                   begin
                    sound (a);
                    delay (4);
                   end;
 nosound;
 until keypressed;
end;

procedure alarm2;
Var a:Integer;
begin
 writeln('Alarm II');
 repeat
 for a:= 1 to 100 do
                  begin
                   delay (59);
                   sound (a);
                   delay (20);
                  end;
 until keypressed;
 nosound;
end;


procedure Dreieck(x1,y1,x2,y2,x3,y3 : Word);

begin
  line(x1,y1,x2,y2);
  line(x2,y2,x3,y3);
  line(x3,y3,x1,y1);
end;

procedure setcursor (Cur : Word);

var regs : registers;

begin
 with regs DO
 begin
  ah:=1;
  bh:=0;
  cx:=cur;
  intr($10,regs);
 end;
end;

{**************** BIG TITLE *********************}

Procedure LeseEintrag(Eintrag:T_Speicher);
Var Pixel_PosY, Pixel_PosX : 1..8;
    Pixel                  : Byte;
begin
 For Pixel_PosY := 1 to 7 do
  begin
   Pixel := Eintrag[Pixel_PosY];
   For Pixel_PosX := 8 DownTo 1 do
    begin
     GotoXY(Pixel_PosX,Pixel_PosY);
      If Odd (Pixel) then Write ('€') else Write(' '); Delay(3);
     Pixel := Pixel Div 2;
    end
  end;
end;

Procedure BigTitel(Titel:T_Titel; PosY:Byte);
Var N, Laenge,PosX, X : Byte;
begin
 Laenge := Length(Titel);
 PosX := ((80-8*Laenge) Div 2) And $00FF;
 For N := 1 to Laenge do
  begin
   X := PosX + 8*(N-1);
   Window(X-2,PosY,X+7,PosY+8);
   LeseEintrag(Zeichensatz[Ord(Titel[N])]);
  end;
  Window(1,1,80,25);
end;

Function TestDrive(Drive:Byte) : Boolean;
Var Regs       : Registers;
    Num_Drives : LONGINT;
begin
 Intr($11,Regs);
 Num_Drives := Regs.AX;
 If (Num_Drives And 1)=0 then Num_Drives := 0
  else Num_Drives := ((Num_Drives Shl 8) Shr 14) + 1;
 If Num_Drives < (Drive+1) then Testdrive := False
  else
   With Regs do
    begin
     DL := Drive;
     DH := 0;
     CX := 1;
     AX := $0401;
     Intr($13,Regs);
     TestDrive := AH<>$80;
     DL := Drive;
     AX := 0;
     Intr($13,Regs);
    end;
end;

Procedure Empfindl(Horiz,Vert : Word);

Var Regs : Registers;

begin
 Regs.CX := Horiz;
 Regs.DX := Vert;
 Regs.AX := 15;
 Intr($33,Regs);
end;

VAR Reg   : Registers;

FUNCTION  MouseInstalled:BOOLEAN;
BEGIN
  Reg.AX:=0;
  Intr($33,Reg);
  MouseInstalled:=(Reg.AX<>0);
END;

PROCEDURE MouseInit;
BEGIN
  Reg.AX:=0;
  Intr($33,Reg);
  IF Reg.AX=0 THEN BEGIN
    Writeln;
    Writeln('Maustreiber nicht geladen! Programm abgebrochen',#7);
    Halt(1);
  END;
END;

PROCEDURE MouseShow;
BEGIN
  Reg.AX:=1;
  Intr($33,Reg);
END;

PROCEDURE MouseHide;
BEGIN
  Reg.AX:=2;
  Intr($33,Reg);
END;

FUNCTION MouseButton:BYTE;
BEGIN
  Reg.AX:=3;
  Intr($33,Reg);
  Mousebutton:=Reg.bl;
END;

FUNCTION MouseXpos:WORD;
BEGIN
  Reg.AX:=3;
  Intr($33,Reg);
  MouseXpos:=Reg.CX;
END;

FUNCTION MouseYpos:WORD;
BEGIN
  Reg.AX:=3;
  Intr($33,Reg);
  MouseYpos:=Reg.DX;
END;

PROCEDURE MouseGotoXY(x,y:WORD);
BEGIN
  Reg.AX:=4;
  Reg.CX:=x;
  Reg.DX:=y;
  Intr($33,Reg);
END;

PROCEDURE MouseWindow(x1,y1,x2,y2:WORD);
BEGIN
  Reg.AX:=7;
  Reg.CX:=x1;
  Reg.DX:=x2;
  Intr($33,Reg);
  Reg.AX:=8;
  Reg.CX:=y1;
  Reg.DX:=y2;
  Intr($33,Reg);
END;

FUNCTION  MouseInWindow(x1,y1,x2,y2:WORD):BOOLEAN;
BEGIN
  Reg.AX:=3;
  Intr($33,Reg);
  MouseInWindow:=(x1<=Reg.CX) AND (Reg.CX<=x2) AND
                 (y1<=Reg.DX) AND (Reg.DX<=y2);
END;

PROCEDURE MouseSetTextCursor(Typ:BYTE;Smask,Cmask:WORD);
BEGIN
  Reg.AX:=10;
  Reg.BX:=Typ;    { Software / Hardware }
  Reg.CX:=Smask;
  Reg.DX:=Cmask;
  Intr($33,Reg);
END;

PROCEDURE MouseSetGraphCursor(HotX,HotY:WORD; VAR SCMask);
BEGIN
  Reg.AX:=9;
  Reg.BX:=HotX;
  Reg.CX:=HotY;
  Reg.DX:=Ofs(SCMask);
  Reg.ES:=Seg(SCMask);
  Intr($33,Reg);
END;

procedure mausrechts;
begin
 repeat until mousebutton=mousebuttonleft;
end;

procedure Datum;

const days : array [0..6] of String[11] = ('Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag');
var y, m, d, dow : Word;
begin
  GetDate(y,m,d,dow);
  Write(days[dow],', ',m:0,'.', d:0,'.', y:0);
end;

procedure uhr;

var h, m, s, hund : Word;

function LeadingZero(w : Word) : String;

var s : String;
begin
  Str(w:0,s);
  if Length(s) = 1 then s := '0' + s;
  LeadingZero := s;
end;

begin
  GetTime(h,m,s,hund);
  Write(' ',LeadingZero(h),':',LeadingZero(m),':',LeadingZero(s){,'.',LeadingZero(hund)});
end;

procedure gross (var s:String);
var i : Integer;

begin
 for i := 1 to Length(s) do s[i] := UpCase(s[i]);
end;

procedure loschen (var S : String);

var i: Integer;
    a : Byte;
    boo : boolean;

begin
 for i := 1 to length(s) DO
 Begin
  a := pos (' ',s);
  delete(s,a,1);
 end;
end;

Function ReadText(X,Y:Integer) : String;
VAR Ch : ARRAY[0..100] of Char;
    i,farbe : Integer;
    txt : String;
BEGIN
 txt:=' ';
 for i:= 0 to 100 DO
 begin
  SetTextJustify(LeftText,BottomText);
  Ch[i]:=ReadKey;
  If Ch=#0 Then Ch[i]:=ReadKey;
  if (i<>0) and (ord(ch[i]) = 8) then begin
                                       x:=x-8;
                                       i:=i-1;
                                       farbe:=getcolor;
                                       setcolor(black);
                                       outtextxy(x,y,ch[i]);
                                       delete(txt,i,2);
                                       setcolor(farbe);
                                       ch[i]:=' ';
                                      end;
  If (Ord(Ch[i])<>13) and (ord(ch[i])<>8) Then begin
                                              OutTextXY(X,Y,Ch[i]);
                                              txt:=txt+ch[i];
                                              end;
  if ord(ch[i]) = 13 then begin
                           readtext:=txt;
                           exit;
                          end;
  X:=X+8;
 end;
END;

PROCEDURE SavePic(Path:String);
Var X, Y : word;
    c    : Byte;
    F : file of byte;
BEGIN
 Assign(F,Path);
 ReWrite(F);
 For X:=0 To getmaxx Do
 For Y:=0 To getmaxy Do
 BEGIN
  C:=GetPixel(X,Y);
  Write(F,C);
 END;
 Close(F);
END;

PROCEDURE LoadPic(Path:String);
Var X, Y : word;
    c    : Byte;
    F : file of byte;
BEGIN
 Assign(F,Path);
 Reset(F);
 For X:=0 To getmaxx Do
 For Y:=0 To getmaxy Do
 BEGIN
  Read(F,C);
  PutPixel(X,Y,C);
 END;
 Close(F);
END;

PROCEDURE LoadIcon(X1,Y1:Integer;Datei:String);
VAR F : Text;
    X, Y, C : Integer;
BEGIN
 Assign(F,Datei);
 Reset(F);
 C:=0; X:=0; Y:=0;
 For X:=0 To 64 Do
  For Y:=0 To 63 Do
  BEGIN
   ReadLn(F,C);
   PutPixel(X1+X,Y1+Y,C);
  END;
END;

PROCEDURE Balken(X1,Y1,X2,Y2,Color:Integer);
VAR Laenge : Integer;
BEGIN
 Laenge:=0;
 Repeat
  Laenge:=Laenge+2;
  SetColor(Color);
  Line(X1+Laenge,Y1,X1+Laenge,Y2);
 Until Laenge>X2-X1;
END;

PROCEDURE MessageBox(X,Y:Integer;Message,Name:String);
VAR A,B:Integer;
BEGIN
Button(X,Y,X+200,Y+90,0);
Button(X+70,Y+60,X+130,Y+80,0);
SetColor(Blue);
For A:=Y+2 to Y+16 Do
Line(X+4,A,X+196,A);
SetTextJustify(CenterText,CenterText);
SetColor(White);
OutTextXY(X+100,Y+9,Name);
SetColor(Black);
OutTextXY(X+100,Y+70,'OK');
OutTextXY(X+100,Y+40,Message);
B:=0;
Repeat
If (MouseXPos>X+70) and (MouseXPos<X+130) and (MouseYPos>Y+60) and (MouseYPos<Y+80) and (MouseButton=1) Then
 B:=1;
Until B=1;
Button(X+70,Y+60,X+130,Y+80,1);
END;

PROCEDURE WaitKey;
var taste : char;
BEGIN
 taste:=readkey;
END;

PROCEDURE Button(x1,y1,x2,y2:Integer;pn:Word);
VAR A : Integer;
BEGIN
 SetColor(LightGray);
 For A:=Y1 to Y2 Do
  Line(x1,A,x2,A);
 If pn=0 Then
 Begin
  SetColor(White);
  Line(x1,y1,x1,y2);
  Line(x1,y1,x2,y1);
  SetColor(DarkGray);
  Line(x2,y2,x1,y2);
  Line(x2,y2,x2,y1);
 End
          Else
 Begin
  SetColor(DarkGray);
  Line(x1,y1,x1,y2);
  Line(x1,y1,x2,y1);
  SetColor(White);
  Line(x2,y2,x1,y2);
  Line(x2,y2,x2,y1);
 End;
END;

PROCEDURE Display(x1,y1,x2,y2:Integer;pn,color:Word);
VAR A : Integer;
BEGIN
 SetColor(color);
 For A:=y1 to y2 Do
  Line(x1,a,x2,a);
 If pn=0 Then
  Begin
   SetColor(White);
   Line(x1,y1,x2,y1);
   Line(x1,y1,x1,y2);
   SetColor(DarkGray);
   Line(x2,y2,x1,y2);
   Line(x2,y2,x2,y1);
  End
         Else
  Begin
   SetColor(White);
   Line(x2,y2,x1,y2);
   Line(x2,y2,x2,y1);
   SetColor(DarkGray);
   Line(x1,y1,x2,y1);
   Line(x1,y1,x1,y2);
  End;
End;

function zufall (min, max : integer) :Integer;
var zufal : integer;

Begin
 Randomize;
 Repeat;
  zufal := RANDOM(max);
 until (zufal >=min) and (zufal <=max);
 zufall := zufal
end;

procedure HideLW(Dr:Byte;On:Boolean);

var Rg:Registers;

begin
 If on Then Begin
  with rg Do Begin
   ax:=$5f07;
   dl:=Dr;
   msdos(Rg);
   If(flags and 1 )=0 then begin end;
  end;
 end
 else
 Begin
  with Rg DO Begin
   ax:=$5f08;
   dl:=dr;
   MsDos(Rg);
   if (Flags And 1)= 0 then begin end;
  end;
 end;
end;

procedure keepx (kenn:Byte; biswohin:Pointer);

var maxseg:^Word;

begin
 {Ab PSP bis zur angegebenen Procedure resident machen}
 maxseg:=ptr(prefixseg,2);
 maxseg^ :=Seg(biswohin^ )+(Ofs(biswohin^)) SHR 4;
 swapvectors;
 keep(kenn);
end;

{**************************ErklÑrung zu Keepx*********************************}
{Keepx(0,heapend) enstspricht keep(0)}
{keepx(0,heaporg) ohne Heap}
{keepx(0,ptr(sseg,0)) zusaÑtzlich ohne Stack}
{keepx(0,@saveint00) zusÑtzlich ohne Vektorentabelle}
{keepx(0,@input) zusÑtzlich ohne I/O-Buffer}
{...}
{Keepx(0,@keepx) nur bis zur Routine Keepx selbst}
end.