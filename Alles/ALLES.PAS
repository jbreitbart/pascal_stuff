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
     Laufvar    = 0..16000;
{********************************CD-ROM**************************************}
     arrayofchar= Array [0..2047] of char;
     arrayofchar1= Array [0..37] of char;
     arrayofbyte= Array[0..$1A] of Byte;

Var Zeichensatz : Array[0..255] of T_Speicher absolute $F000:$FA6E;
    mauszeiger  : SCMaskType;
    grd,grm     : Integer;
{********************************CD-ROM**************************************}
    anz_lw,lw_id:Byte; {anz_lw = Anzahl der CD-ROM Laufwerke, lw_id=Nummer des Laufwerkes (bekommen durch Install ihre Werte)}
    copyrightfilename,abstractfilename,documfilename:ArrayofChar1;{Abstract=kurze Zusammenfassung des CD-Inhaltes,
                                                                   docum=Quelle der Daten}
    dump,vtoc : Arrayofchar;{VTOC=Volume Tabel of Contens}

{**********************************KAI***************************************}
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
PROCEDURE Button(x1,y1,x2,y2:word); {Knopf}
procedure buttonschrift (x1,y1,x2,y2 : word;msg : String); {Knopf mit zentrierter Schrift}
procedure ubutton(x1,y1,x2,y2 : word); {Knopf gedrÅckt}
procedure buttonvoll (x,y,x1,y1 : word); {Knopf ausgefÅllt}
procedure ReadText(X,Y:Word;var s : String);{ Fragt Text im Grafikmodus ab}
procedure ReadText3d(X,Y:Word;var s : String);{Das gleiche wie Readtext nur in 3D}
procedure ReadText3dSound(x,y : Word; var s : String);
procedure readint(x,y : word; var s : Word);{Fragt einen Word-Wert ab}
PROCEDURE SavePic(Path:String); {Speichert den Bildschirminhalt}
PROCEDURE LoadPic(Path:String); {LÑdt die Datei die mit Savepic gespeichert wurde}
procedure dreieck (x1,y1,x2,y2,x3,y3:word); { Zeichnet ein Dreieck}
procedure schnee(x,y : Integer); {Zeichnet eine Schneeflocke}
procedure schneeunten(x,y : Integer); {Zeichnet eine Schneeflocke am Boden}
procedure schneeweg(x,y : Integer); {öbermalt eine Schneeflocke}
procedure feld (x,y,x1,y1 : word);
Function Compare(s1,s2 : String) : Boolean; {Vergleicht 2 Strings miteinander. 1. String ohne Wildcards 2. String mit Wildcards
                                             Max 100 Zeichen, Wildcards=? und *}
Procedure WaitKey; { Wartet auf Tastendruck}
function zufall (min, max : integer) :Integer; { Random mit Minimum und Maximum}
function zufallr(min,max : real) : real; {Random mit Real}
procedure hideLw(dr:Byte;on:Boolean);{ Versteckt ein Laufwerk}
procedure keepx(kenn:Byte; biswohin:Pointer);{ ErklÑrung siehe unten}
procedure Datum;{ Gibt das Datum aus}
procedure Uhr;{ Gibt die Uhrzeit aus}
procedure gross(var s:string);{ Wandelt String in Grossbuchstaben um}
procedure loschen(var s :string);{ Lîscht die Leerzeichen aus einem String}
procedure mausrechts;{ Wartet auf rechten Mausklick}
procedure Setcursor (Cur : Word); { VerÑndert die Cursorform}
function inttostr (i : Longint) : String; {Wandelt einen Integer in einen String um}
procedure kopieren(von,zu : String); {Kopiert Dateien}
procedure check; {Kopierschutz}
procedure Install (N:String); {Installiert den Kopierschutz in eine EXE}
function Installed:Boolean; {Testet ob CD-ROM vorhanden}
Function Version:REAL; {Liefert die MSCDEX Version zurÅck}
function getfilename(LW_ID: Integer; var FileName: arrayofchar1; Filesort:Integer):boolean;
function ReadVTOC(LW_ID,VTOC_NUM:Integer; var buffer: Arrayofchar):Boolean;
Function Readcd(LW_ID: Integer; Firstsec: LONGINT; anz_Sec:Integer; var Buf:Arrayofchar) :Boolean;
Function senddevicerequest(command : Byte; lw_id : Integer; var Paramblock: arrayofByte): word;
procedure PlayAudio(Start,Length : LONGINT); {Spielt eine Audio CD ab}
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
{******************************Richard***************************************}
Procedure Empfindl(Horiz,Vert : Word);{ Empfindlichkeit der Mausbewegung}
function Testdrive (Drive:Byte):Boolean;{ Testet Laufwerk, gibt true wenn Laufwerk O.K.}
Procedure BigTitel(Titel:T_Titel; PosY:Byte);{ Titel im Textmodus, Titel max. 8 Zeichen}

IMPLEMENTATION

procedure buttonschrift (x1,y1,x2,y2 : word;msg : String);
var lv1 : Laufvar;
    Art : TextSettingsType;
begin
 for lv1 := x1-1 to x2+1 DO putpixel(lv1,y1-1,lightgray);
 for lv1 := x1-1 to x2+1 DO putpixel(lv1,y1,lightgray);
 for lv1 := y1-1 to y2+1 do putpixel(x1,lv1,lightgray);
 for lv1 := y1-1 to y2+1 do putpixel(x1-1,lv1,lightgray);
 for lv1 := x1-1 to x2+1 do putpixel(lv1,y2,darkgray);
 for lv1 := x1-1 to x2+1 do putpixel(lv1,y2+1,darkgray);
 for lv1 := y1-1 to y2+1 do putpixel(x2,lv1,darkgray);
 for lv1 := y1-1 to y2+1 do putpixel(x2+1,lv1,darkgray);
 gettextsettings(art);
 SetTextJustify(CenterText,CenterText);
 OutTextXY(((x2 - x1) div 2)+x1,((y2-y1) div 2)+y1,Msg);
 settextJustify(art.Horiz,art.Vert);
end;

FUNCTION compare(s1, s2 : string):
    boolean;
VAR d: array[0..100,0..100]
  of boolean;
  b, p, q, r: boolean;
  i, j : word;
BEGIN
 FOR i:=0 TO length(s2) DO
  FOR j:=0 TO length(s1) DO
    d[i,j]:=FALSE;
 d[0,0]:=TRUE;
 FOR i:=1 TO length(s2) DO
 BEGIN
  q:=FALSE; r:=FALSE;
  IF s2[i]='*' THEN BEGIN
   q:=TRUE; r:=TRUE
  END;
  FOR j:=1 TO length(s1) DO
  BEGIN
   IF s2[i]IN [s1[j],'*','?'] THEN
    p:=TRUE ELSE p:=FALSE;
   b:= d[i-1,j-1] AND p;
   b:= b OR (d[i-1,j] AND q);
   b:= b OR (d[i,j-1] AND r);
   d[i,j]:=b
  END
 END;
 compare:=d[length(s2),length(s1)]
END;

procedure kopieren (von,zu : String);

var f,f1 : file of longint;
    test : longint;

begin
 assign(f,von);
 assign(f1,zu);
 reset(f);
 rewrite(f1);
 repeat
  read(f,test);
  write(f1,test);
 until eof(f);
end;

procedure buttonvoll (x,y,x1,y1 : word);
var lvx,lvy : Laufvar;
    farbe : Byte;
begin
 ubutton(x,y,x1,y1);
 for lvx:= x+1 to x1-1 DO
 for lvy:= y+1 to y1-1 DO begin
  farbe:=getpixel(lvx,lvy);
  putpixel(lvx,lvy,farbe+8);
 end;
end;

procedure feld (x,y,x1,y1 : word);
var lv1 : Laufvar;
begin
 for lv1:=0 to 4 DO begin
  line(x+lv1,y-lv1,x1-lv1,y1-lv1);
  line(x+lv1,y+lv1,x1-lv1,y1+lv1);
 end;
end;

{************************************CD-ROM**********************************}
const copyright=0;
      abstract=1;
      docum=2;

var regs :Registers;
    ParamBlock:ArrayofByte;
    i : Integer;

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

procedure PlayAudio(Start,Length : LONGINT);
begin
 For i:= 0 to $1A DO paramblock[i]:=0;
 paramblock[$0e]:=Lo(Start);
 paramblock[$0F]:=Hi(Start);
 Paramblock[$12]:=Lo(Length);
 Paramblock[$13]:=Hi(Length);
 writeerrors(Senddevicerequest($84,LW_ID,ParamBlock));
end;

{***********************************CD-ROM ENDE******************************}
{**********************************Kopierschutz******************************}
procedure get (VAR s : STRING);
var R : Array [0..255] of word;
    i : Word;
begin
 port[$1f6]:=$80;
 port[$1f7]:=$ec;
 while (port[$1f7] and $88) <> 8 DO;
 for i :=0 to 255 DO R[i]:=portw[$1f0];
 move(R[10],S[1],20);
 s[0]:=#20; {StringlÑnge definieren}
end;

procedure check;
const B='!2/$%&/@&%@@@@@@@@@@';
var s: String;
begin
 get(s);
 if s <> B then begin
  writeln('Du Dieb wir werden dich finden!');
  halt(22);
 end;
end;

procedure Install (N : String);
var s, S1 : String;
    f : file;
    a,b,c,x : Word;
    i,l,k : Longint;
begin
 N:=N+#0;
 get(s);
 assign(f,n);
 reset(f,1);;
 L:=Filesize(f);
 k:=0;
 for i := 0 to L div 255 DO begin
  x:=255;
  if i=L div 255 then x:=L mod 255;
  blockread(f,s1[1],x);
  s1[0]:=chr(x);
  a:=pos('!2/$',S1);
  b:=pos('%&/@',s1);
  if a>0 then k:=i*255+a;
  if b>0 then K:=i*255+b-5;
 end;
 close(f);
 if k>0 then begin
  a:=k shr 16;
  b:=k mod 65536;
  c:=Seg(N);
  asm
   push ds
   mov ax,$3d02
   mov ds,c
   lea dx,N+1
   int $21
   jc @err
   mov bx,ax
   mov dx,b
   mov cx,a
   mov ax,$4200
   int $21
   mov ah,40h
   mov cx,20
   lea dx,s+1
   int $21
   mov ah,$3e
   int $21
   @err:
    pop ds
  end;
 end;
end;
{******************************Kopierschutz Ende*****************************}

procedure schnee(x,y : Integer);
begin
 putpixel(x,y,white);
 putpixel(x-1,y,lightgray);
 putpixel(x+1,y,lightgray);
 putpixel(x,y-1,lightgray);
 putpixel(x,y+1,lightgray);
end;

procedure schneeunten(x,y : Integer);
begin
 putpixel(x,y,white);
 putpixel(x-1,y,white);
 putpixel(x+1,y,white);
 putpixel(x,y-1,white);
 putpixel(x,y+1,white);
end;

procedure schneeweg(x,y : Integer);
begin
 putpixel(x,y,black);
 putpixel(x-1,y,black);
 putpixel(x+1,y,black);
 putpixel(x,y-1,black);
 putpixel(x,y+1,black);
end;

procedure readint(x,y : word; var s : Word);

var taste : char;
    zusammen : array [0..5] of char;
    lv1,cursorpos : Laufvar;
    farbealt:byte;
    test,code : Integer;

begin
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 5 DO zusammen[lv1]:='»';
 s:=0;
 lv1:=0;
 test:=0;
 repeat
  setcolor (white);
  if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
  else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
  if keypressed then begin
    taste:=readkey;
    if (taste = return) or (taste = backspace) or ((taste>=#48) and (taste<=#57)) then begin
    cursorpos:=cursorpos+1;
    setcolor (black);
    if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
    else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
    delay(300);
  if (taste = backspace) and (lv1>=1) then begin
   lv1:=lv1-1;
   setcolor(black);
   line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
   x:=x-textwidth(zusammen[lv1]);
   outtextxy(x,y,zusammen[lv1]);
   zusammen[lv1]:='»';
  end;
  if (taste <> return) and (taste <> backspace) and (taste>=#48) and (taste<=#57) and (lv1<=4) then
  begin
   setcolor(farbealt);
   outtextxy(x,y,taste);
   zusammen[lv1]:=taste;
   x:=x+textwidth(taste);
   lv1:=lv1+1;
  end;
 end;
 end;
 delay(600);
 setcolor (black);
 if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
 else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
 delay(300);
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='»' then exit;
  val(zusammen[lv1],test,code);
  s:=s*10+test;
 end;
end;

function IntToStr(i: Longint): string;

var s: string[11];
begin
  Str(i, s);
  IntToStr := s;
end;

procedure button (x1,y1,x2,y2 : word);
var lv1 : Laufvar;
begin
 for lv1 := x1-1 to x2+1 DO putpixel(lv1,y1-1,lightgray);
 for lv1 := x1-1 to x2+1 DO putpixel(lv1,y1,lightgray);
 for lv1 := y1-1 to y2+1 do putpixel(x1,lv1,lightgray);
 for lv1 := y1-1 to y2+1 do putpixel(x1-1,lv1,lightgray);
 for lv1 := x1-1 to x2+1 do putpixel(lv1,y2,darkgray);
 for lv1 := x1-1 to x2+1 do putpixel(lv1,y2+1,darkgray);
 for lv1 := y1-1 to y2+1 do putpixel(x2,lv1,darkgray);
 for lv1 := y1-1 to y2+1 do putpixel(x2+1,lv1,darkgray);
end;

procedure ubutton (x1,y1,x2,y2 : word);
var lv1 : Laufvar;
begin
 for lv1 := x1-1 to x2+1 DO putpixel(lv1,y1-1,darkgray);
 for lv1 := x1-1 to x2+1 DO putpixel(lv1,y1,darkgray);
 for lv1 := y1-1 to y2+1 do putpixel(x1,lv1,darkgray);
 for lv1 := y1-1 to y2+1 do putpixel(x1-1,lv1,darkgray);
 for lv1 := x1-1 to x2+1 do putpixel(lv1,y2,lightgray);
 for lv1 := x1-1 to x2+1 do putpixel(lv1,y2+1,lightgray);
 for lv1 := y1-1 to y2+1 do putpixel(x2,lv1,lightgray);
 for lv1 := y1-1 to y2+1 do putpixel(x2+1,lv1,lightgray);
end;

procedure readtext3d(x,y : word; var s : string);

var taste : char;
    zusammen : array [0..255] of char;
    lv1,cursorpos,a : Laufvar;
    farbealt:byte;
    art : Textsettingstype;

begin
 s:='';
 a:=0;
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 255 DO zusammen[lv1]:='»';
 lv1:=0;
 gettextsettings(art);
 repeat
  setcolor (white);
  if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
  else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
  if keypressed then begin
    cursorpos:=cursorpos+1;
    taste:=readkey;
    setcolor (black);
    if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
    else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
    delay(300);
  if (taste = backspace) and (lv1>=1) then begin
   lv1:=lv1-1;
   if zusammen[lv1] <> ' ' then begin
    setcolor(black);
    line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
    x:=x-textwidth(zusammen[lv1]);
    for a := art.charsize downto 0 DO begin
    if (a <> art.charsize) then begin
      settextstyle (art.font,art.direction,a);
      setcolor(farbealt);
      outtextxy(x,y,zusammen[lv1]);
     end;
     delay(a*40);
     setcolor(getbkcolor);
     outtextxy(x,y,zusammen[lv1]);
    end;
  end
  else begin
   setcolor(black);
   line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
   x:=x-textwidth(zusammen[lv1]);
   outtextxy(x,y,zusammen[lv1]);
   zusammen[lv1]:='»';
 end;
  settextstyle (art.font,art.direction,art.charsize);
  zusammen[lv1]:='»';
  taste:='»';
  end;
  if taste = ' ' then begin
   setcolor(farbealt);
   outtextxy(x,y,taste);
   zusammen[lv1]:=taste;
   x:=x+textwidth(taste);
   lv1:=lv1+1;
  end;
  if (taste <> return) and (taste <> backspace) and (taste<>'»') and (taste<>' ') then
  begin
   for a := 0 to art.charsize DO begin
    settextstyle (art.font,art.direction,a);
    setcolor(farbealt);
    outtextxy(x,y,taste);
    delay(a*70);
    if a <> art.charsize then begin
     setcolor(getbkcolor);
     outtextxy(x,y,taste);
    end;
   end;
   zusammen[lv1]:=taste;
   x:=x+textwidth(taste);
   lv1:=lv1+1;
  end;
 end;
 delay(600);
 setcolor (black);
 if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
  else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
 delay(300);
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='»' then exit;
  s:=s+zusammen[lv1];
 end;
end;

procedure readtext3dsound(x,y : word; var s : string);

var taste : char;
    zusammen : array [0..255] of char;
    lv1,cursorpos,a : Laufvar;
    farbealt:byte;
    art : Textsettingstype;

begin
 s:='';
 a:=0;
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 255 DO zusammen[lv1]:='»';
 lv1:=0;
 gettextsettings(art);
 repeat
  setcolor (white);
  if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
  else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
  if keypressed then begin
    cursorpos:=cursorpos+1;
    taste:=readkey;
    sound(1000);
    delay (200);
    nosound;
    setcolor (black);
    if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
    else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
    delay(300);
  if (taste = backspace) and (lv1>=1) then begin
   lv1:=lv1-1;
   if zusammen[lv1] <> ' ' then begin
    setcolor(black);
    line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
    x:=x-textwidth(zusammen[lv1]);
    for a := art.charsize downto 0 DO begin
    if (a <> art.charsize) then begin
      settextstyle (art.font,art.direction,a);
      setcolor(farbealt);
      outtextxy(x,y,zusammen[lv1]);
     end;
     delay(a*40);
     setcolor(getbkcolor);
     outtextxy(x,y,zusammen[lv1]);
    end;
  end
  else begin
   setcolor(black);
   line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
   x:=x-textwidth(zusammen[lv1]);
   outtextxy(x,y,zusammen[lv1]);
   zusammen[lv1]:='»';
 end;
  settextstyle (art.font,art.direction,art.charsize);
  zusammen[lv1]:='»';
  taste:='»';
  end;
  if taste = ' ' then begin
   setcolor(farbealt);
   outtextxy(x,y,taste);
   zusammen[lv1]:=taste;
   x:=x+textwidth(taste);
   lv1:=lv1+1;
  end;
  if (taste <> return) and (taste <> backspace) and (taste<>'»') and (taste<>' ') then
  begin
   for a := 0 to art.charsize DO begin
    settextstyle (art.font,art.direction,a);
    setcolor(farbealt);
    outtextxy(x,y,taste);
    delay(a*70);
    if a <> art.charsize then begin
     setcolor(getbkcolor);
     outtextxy(x,y,taste);
    end;
   end;
   zusammen[lv1]:=taste;
   x:=x+textwidth(taste);
   lv1:=lv1+1;
  end;
 end;
 delay(600);
 setcolor (black);
 if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
  else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
 delay(300);
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='»' then exit;
  s:=s+zusammen[lv1];
 end;
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
 for i := 1 to Length(s) do begin
  if s[i]= 'î' then s[i]:='ô';
  if s[i]= 'Ñ' then s[i]:='é';
  if s[i]= 'Å' then s[i]:='ö';
  if (s[i]<>'î') and (s[i]<>'Ñ') and (s[i]<>'Å') then s[i] := UpCase(s[i]);
 end;
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

procedure readtext(x,y : word; var s : string);

var taste : char;
    zusammen : array [0..255] of char;
    lv1,cursorpos : Laufvar;
    farbealt:byte;

begin
 s:='';
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 255 DO zusammen[lv1]:='»';
 lv1:=0;
 taste:=' ';
 repeat
  setcolor (white);
  if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
  else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
  if keypressed then begin
    cursorpos:=cursorpos+1;
    taste:=readkey;
    setcolor (black);
    if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
    else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
    delay(300);
  if (taste = backspace) and (lv1>=1) then begin
   lv1:=lv1-1;
   setcolor(black);
   line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
   x:=x-textwidth(zusammen[lv1]);
   outtextxy(x,y,zusammen[lv1]);
   zusammen[lv1]:='»';
  end;
  if (taste <> return) and (taste <> backspace) then
  begin
   setcolor(farbealt);
   outtextxy(x,y,taste);
   zusammen[lv1]:=taste;
   x:=x+textwidth(taste);
   lv1:=lv1+1;
  end;
 end;
 delay(600);
 setcolor (black);
 if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
 else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
 delay(300);
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='»' then exit;
  s:=s+zusammen[lv1];
 end;
end;

PROCEDURE SavePic(Path:String);
var a,b : Word;
    farbe,farbealt,anzahl : word;
    F : Text;

begin
 assign(f,Path);
 rewrite(f);
 for a:= 1 to getmaxx DO
 for b:= 1 to getmaxy DO begin
  farbe:=getpixel(a,b);
  if (a=1) and (b=1) then begin
   farbealt:=farbe;
   anzahl:=0;
  end;
  if farbealt=farbe then anzahl:=anzahl+1;
  if (farbealt <> farbe) then begin
   writeln(f,anzahl);
   writeln(f,farbealt);
   anzahl:=1;
   farbealt:=farbe;
  end;
 end;
end;

PROCEDURE LoadPic(Path:String);
var a,b,lv1 : Laufvar;
    anzahl : word;
    farbe : byte;
    f : Text;

begin
 anzahl:= 0;
 farbe:=255;
 lv1:=0;
 assign(f,PATH);
 reset(f);
 FOR a:= 1 to getmaxx DO
 for b:= 1 to getmaxy DO begin
  if anzahl=lv1 then begin
   if eof(f) then exit;
   readln(f,anzahl);
   readln(f,farbe);
   lv1:=0;
  end;
  if farbe <> getbkcolor then putpixel(a,b,farbe);
  lv1:=lv1+1;
 end;
end;

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
Button(X,Y,X+200,Y+90);
Button(X+70,Y+60,X+130,Y+80);
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
Button(X+70,Y+60,X+130,Y+80);
END;

PROCEDURE WaitKey;
var taste : char;
BEGIN
 taste:=readkey;
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
 Repeat;
  zufal := RANDOM(max);
 until (zufal >=min) and (zufal <=max);
 zufall := zufal
end;

function zufallr(min,max : real) : real;
var zufal : real;
    eins,zwei : Integer;
begin
 zufal:=0;
 repeat
  zufal:=RANDOM(trunc(max));
 until (zufal>=min) and (zufal<=max);
 eins:=RANDOM(9);
 zwei:=RANDOM(9);
 zufal:=zufal+(eins/10)+(zwei/100);
 zufallr:=zufal;
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