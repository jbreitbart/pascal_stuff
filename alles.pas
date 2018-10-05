{$A-,B-,D+,E+,F-,G+,I-,L+,N-,O-,R+,S+,V+,X-}
{$M 16384,0,655360}

Unit Alles;

interface

uses crt,graph,dos,sbapi;

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
      NoBoot  : boolean = true;              {flag to disable soft boot  }
      NoBreak : boolean = true;              {flag to disable Ctrl-Break }
      NoCtrlC : boolean = true;              {flag to disable Ctrl-C     }
      NoCtrl2 : boolean = true;              {flag to disable Ctrl-2     }
      NoAlt3  : boolean = true;              {flag to disable Alt-3 (Pad)}


TYPE SCMaskType = RECORD
      Smask : ARRAY[0..15] OF WORD;
      Cmask : ARRAY[0..15] OF WORD;
     END;
     T_Titel    = String[8];
     T_Speicher = Array[1..8] of Byte;
     Laufvar    = 0..16000;
     Dateiname  = String[12];
     PFliPlayer = ^TFliPlayer;
     TFliPlayer = OBJECT
      CONSTRUCTOR Init;
      DESTRUCTOR  Done;                      VIRTUAL;
      PROCEDURE   SetSpeed(Speed : Integer); VIRTUAL; {0=Fastest}
      PROCEDURE   ClearSpeed;                VIRTUAL;
      PROCEDURE   Play(Filename : String);   VIRTUAL;
     PRIVATE
      Buffer   : Pointer;
      Interval : Integer;
      FliFile  : File;
     END; {TFliPlayer}

{********************************CD-ROM**************************************}
     arrayofchar= Array [0..2047] of char;
     arrayofchar1= Array [0..37] of char;
     arrayofbyte= Array[0..$1A] of Byte;

Var Zeichensatz : Array[0..255] of T_Speicher absolute $F000:$FA6E;
    grd,grm     : Integer;
{********************************CD-ROM**************************************}
    CDROM : Boolean;
    anz_lw,lw_id:Byte; {anz_lw = Anzahl der CD-ROM Laufwerke, lw_id=Nummer des Laufwerkes bekommen durch Installed ihre Werte}
    copyrightfilename,abstractfilename,documfilename:ArrayofChar1;{Abstract=kurze Zusammenfassung des CD-Inhaltes,
                                                                   docum=Quelle der Daten}
    dump,vtoc : Arrayofchar;{VTOC=Volume Tabel of Contens}
    SBAvailable : BOOLEAN;

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
procedure ubuttonschrift (x1,y1,x2,y2 : word;msg : String); {Knopf gedrÅckt mit zentrierter Schrift}
procedure buttonvoll (x,y,x1,y1 : word); {Knopf ausgefÅllt}
procedure fenster(x,y,x1,y1,breite: Word;farbe : Byte); {Zeichnet ein Fenster mit Farbverlauf in 256 Farben}
procedure zentertext (x1,y1,x2,y2 : word;msg : String);
procedure ReadText(X,Y:Word;var s : String);{ Fragt Text im Grafikmodus ab}
procedure ReadText3d(X,Y:Word;var s : String);{Das gleiche wie Readtext nur in 3D}
procedure ReadText3dSound(x,y : Word; var s : String); {Das gleiche wie Readtext3d nur mit Sound}
procedure readtextlange(x,y : word; var s : string;l: Byte ); { Wie Readtext nur mit Angabe wie viele Zeichen}
procedure readint(x,y : word; var s : Word);{Fragt einen Word-Wert ab}
PROCEDURE SavePic(Path:String); {Speichert den Bildschirminhalt}
PROCEDURE LoadPic(Path:String); {LÑdt die Datei die mit Savepic gespeichert wurde}
procedure dreieck (x1,y1,x2,y2,x3,y3:word); { Zeichnet ein Dreieck}
procedure schnee(x,y : Integer); {Zeichnet eine Schneeflocke}
procedure schneeunten(x,y : Integer); {Zeichnet eine Schneeflocke am Boden}
procedure schneeweg(x,y : Integer); {öbermalt eine Schneeflocke}
procedure verzierrechteck(x1,y1,x2,y2 : Word); {Zeichnet ein verziertes Rechteck}
procedure prozentbar(x1,y1,x2,y2:Word;prozent:Real); {Zeichnet Prozentbar}
procedure feld (x,y,x1,y1 : word);
Function Compare(s1,s2 : String) : Boolean; {Vergleicht 2 Strings miteinander. 1. String ohne Wildcards 2. String mit Wildcards
                                             Max 100 Zeichen, Wildcards=? und *}
Procedure WaitKey; { Wartet auf Tastendruck}
function zufall (min, max : integer) :Integer; { Random mit Minimum und Maximum}
function zufallr(min,max : real) : real; {Random mit Real}
function zufallbuh : Boolean; {Random mit Boolean}
procedure hideLw(dr:Byte;on:Boolean);{ Versteckt ein Laufwerk}
procedure keepx(kenn:Byte; biswohin:Pointer);{ ErklÑrung siehe unten}
procedure Datum;{ Gibt das Datum aus}
procedure Uhr;{ Gibt die Uhrzeit aus}
procedure gross(var s:string);{ Wandelt String in Grossbuchstaben um}
procedure loschen(var s :string);{ Lîscht die Leerzeichen aus einem String}
procedure mausrechts;{ Wartet auf rechten Mausklick}
procedure Setcursor (Cur : Word); { VerÑndert die Cursorform}
function inttostr (i : Longint) : String; {Wandelt einen Integer in einen String um}
function RealToStr (i: real): string; {Wandelt einen Real in einen String um}
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
function esc : Boolean; {Wird True winn Escape gedrÅckt wird}
function FileExists(FileName: string): Boolean; {PrÅft ob die Datei exitiert}
function direxists(s : String) : Boolean; {PrÅft ob Verzeichniss existiert}
procedure command(befehl : String); {FÅhrt einen DOS Befehl aus}
procedure tpl; {Tastaturpuffer lîschen}
procedure neuboot; {Bringt den Computer zum Absturz}
procedure bildschirmstandby; {Schaltet den Bildschirm auf Standby}
procedure Keyboardrate(delay,rep : Byte); {Stellt die Wiederholrate der Tastatur ein}
procedure VIDEO_DISABLE(off : boolean); {Deaktiviert, aktiviert den Bildschirm}
procedure gifladen(tempstring : String); {Zeigt Gif-Bilder}
procedure verschlusseln (Name : String); {VerschlÅsselt Dateien}
procedure entschlusseln (Name : String); {EntschlÅsselt Dateien}
PROCEDURE LoadBMP(Dat : String); {LÑdt 640x480x256 Windows Bitmaps}
Procedure GetRGBPalette(ColorNum:Integer; Var RedNum,GreenNum,BlueNum: Byte);
function fgross (s:String) : String; { Wandelt String in Grossbuchstaben um}
{*************************Irgendwer*anders***********************************}
procedure modvolume(v1,v2,v3,v4:integer); {Legt das Volumen fest}
procedure moddevice(var device:integer);
procedure modsetup(var status:integer;device,mixspeed,pro,loop:integer;var str:string); {Spielt MOD-dateien ab}
procedure modstop; {Beendet das spielen einer MOD-Datei}
procedure modinit; {Initialisiert Modplayer}
Function ScreenToGif(FileName: String):Integer; {Speichert den Bildschirminhalt als GIF}
PROCEDURE PlayFli(Filename : String); {Play FLI at default speed}
procedure InstallNonStopISR;
procedure NonStopExitProc;
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

Procedure GetRGBPalette(ColorNum:Integer; Var RedNum,GreenNum,BlueNum: Byte);

Var Palette:PaletteType;
    ColorValue: ShortInt;
    ColorIndex: Integer;
    Regs: Registers;

Begin
 Case GetMaxColor of
  255: Begin                        {256 Colors}
   Regs.AH:=$10;              {Read contents of multiple DAC registers}
   Regs.AL:=$15;
   Regs.BX:=ColorNum;         {The DAC color register of interest}
   Intr($10,Regs);
   RedNum:=Regs.DH;         {DAC is 18 bit, 6 bits each R,G,and B}
   GreenNum:=Regs.CH;       {thus DAC.R ranges 0-63}
   BlueNum:=Regs.CL;        {so multiply by 4 to range 0-255}
  End;   { 255}
 End;  {case GetMaxColor of}
End;    {getRGBPalette}

PROCEDURE LoadBMP(Dat : String);
{ Dieser LoadBMP - Befehl schafft es leider nur, Windows - BMPs mit einer
  Grî·e von 640 x 480 bei 256 Farben zu laden                             }
VAR X, Y : Integer;
    Datei : File;
    Colour : Array[0..639] Of Byte;
BEGIN
 Assign(Datei,Dat+'.BMP');
 Reset(Datei,1);
 { Bitmap - Informationen Åberspringen }
 seek(datei,53);
 { Paletten - Informationen einlesen und Palette bearbeiten }
 For x:=0 To 255 Do
 Begin
   BlockRead(Datei,colour,4);
   SetRGBPalette(x,Round(colour[3]/255*62),Round(colour[2]/255*62),Round(colour[1]/255*62));
 End;
 {0 als Palettenendezeichen}
 seek(datei,filepos(datei)+1);
 { Bitmap einlesen und auf Bildschirm darstellen }
 For Y:=479 DownTo 0 Do Begin
  BlockRead(Datei,Colour,640);
  For X:=0 To 639 Do PutPixel(X,Y,Colour[X]);
 End;
 { Datei schlie·en }
 Close(Datei);
END;

{$L MOD-obj.OBJ} 	        { Link in Object file }
{$F+} 				{ force calls to be 'far'}
procedure modvolume(v1,v2,v3,v4:integer); external ; {Can do while playing}
procedure moddevice(var device:integer); external ;
procedure modsetup(var status:integer;device,mixspeed,pro,loop:integer;var str:string); external ;
procedure modstop; external ;
procedure modinit; external;
{$F-}

procedure verschlusseln (Name : String);

var f,f1 : File of byte;
    i :byte;
begin
 assign(f,paramstr(1));
 assign(f1,paramstr(1));
 reset(f);
 reset(f1);
 repeat
  read (f,i);
  if i=255 then i:=0
  else  i:=i+1;
  write(f1,i);
  if eof(f) then halt;
  read (f,i);
  if i=0 then i:=255
  else  i:=i-1;
  write(f1,i);
 until eof(f);
 close(f);
 close(f1);
end;

procedure entschlusseln (Name : String);

var fe1,fe : File of byte;
    i : Byte;
begin
 assign(fe1,paramstr(1));
 assign(fe,paramstr(1));
 reset(fe);
 reset(fe1);
 repeat
  read(fe1,i);
  if i=0 then i:=255
  else i:=i-1;
  write(fe,i);
  if eof(fe1) then halt;
  read (fe1,i);
  if i=255 then i:=0
  else i:=i+1;
  write(fe,i);
 until eof(fe1);
 close(fe1);
 close(fe);
end;


procedure gifladen(tempstring : String);
{$R-}{$S-}{$B-}

type
  BufferArray = array[0..63999] of byte;
  BufferPointer = ^BufferArray;

var
  GifFile : file of BufferArray;
  InputFileName : string;
  RawBytes : BufferPointer;   { The heap array to hold it, raw    }
  Buffer : BufferPointer;     { The Buffer data stream, unblocked }
  Buffer2 : BufferPointer;    { More Buffer data stream if needed }
  Byteoffset,                 { Computed byte position in Buffer array }
  BitIndex                    { Bit offset of next code in Buffer array }
   : longint;

  Width,      {Read from GIF header, image width}
  Height,     { ditto, image height}
  LeftOfs,    { ditto, image offset from left}
  TopOfs,     { ditto, image offset from top}
  RWidth,     { ditto, Buffer width}
  RHeight,    { ditto, Buffer height}
  ClearCode,  {GIF clear code}
  EOFCode,    {GIF end-of-information code}
  OutCount,   {Decompressor output 'stack count'}
  MaxCode,    {Decompressor limiting value for current code size}
  CurCode,    {Decompressor variable}
  OldCode,    {Decompressor variable}
  InCode,     {Decompressor variable}
  FirstFree,  {First free code, generated per GIF spec}
  FreeCode,   {Decompressor, next free slot in hash table}
  RawIndex,     {Array pointers used during file read}
  BufferPtr,
  XC,YC,      {Screen X and Y coords of current pixel}
  ReadMask,   {Code AND mask for current code size}
  I           {Loop counter, what else?}
  :word;

  Interlace,  {true if interlaced image}
  AnotherBuffer, {true if file > 64000 bytes}
  ColorMap    {true if colormap present}
  : boolean;

  ch : char;
  a,              {Utility}
  Resolution,     {Resolution, read from GIF header}
  BitsPerPixel,   {Bits per pixel, read from GIF header}
  Background,     {Background color, read from GIF header}
  ColorMapSize,   {Length of color map, from GIF header}
  CodeSize,       {Code size, read from GIF header}
  InitCodeSize,   {Starting code size, used during Clear}
  FinChar,        {Decompressor variable}
  Pass,           {Used by video output if interlaced pic}
  BitMask,        {AND mask for data size}
  R,G,B
  :byte;

    {The hash table used by the decompressor}
  Prefix: array[0..4095] of word;
  Suffix: array[0..4095] of byte;

    {An output array used by the decompressor}
  PixelValue : array[0..1024] of byte;

    {The color map, read from the GIF header}
  Red,Green,Blue: array [0..255] of byte;
  MyPalette : PaletteType;

Const
  MaxCodes: Array [0..9] of Word = (4,8,16,$20,$40,$80,$100,$200,$400,$800);
  CodeMask:Array [1..4] of byte= (1,3,7,15);
  PowersOf2: Array [0..8] of word=(1,2,4,8,16,32,64,128,256);
  Masks: Array [0..9] of integer = (7,15,$1f,$3f,$7f,$ff,$1ff,$3ff,$7ff,$fff);
  BufferSize : Word = 64000;

function NewExtension(FileName,Extension : string) : string;
var
  I : integer;
begin
  if (Extension[1] = '.') then delete(Extension,1,1);
  delete(Extension,4,251);
  I := pos('.',FileName);
  if (I = 0) then
  begin
    while (length(FileName) > 0) and (FileName[length(FileName)] = ' ')
      do delete(FileName,length(FileName),1);
    NewExtension := FileName + '.' + Extension;
  end else begin
    delete(FileName,I + 1,254 - I);
    NewExtension := FileName + Extension;
  end;
end; { NewExtension }

function Min(I,J : longint) : longint;
begin
  if (I < J) then Min := I else Min := J;
end; { Min }

procedure AllocMem(var P : BufferPointer);
var
  ASize : longint;
begin
  ASize := MaxAvail;
  if (ASize < BufferSize) then begin
    Textmode(15);
    writeln('Insufficient memory available!');
    halt;
  end else getmem(P,BufferSize);
end; { AllocMem }

function Getbyte : byte;
begin
  if (RawIndex >= BufferSize) then exit;
  Getbyte := RawBytes^[RawIndex];
  inc(RawIndex);
end;

function Getword : word;
var
  W : word;
begin
  if (succ(RawIndex) >= BufferSize) then exit;
  move(RawBytes^[RawIndex],W,2);
  inc(RawIndex,2);
  Getword := W;
end; { GetWord }

procedure ReadBuffer;
var
  BlockLength : byte;
  I,IOR : integer;
begin
  BufferPtr := 0;
  Repeat
    BlockLength := Getbyte;
    For I := 0 to Blocklength-1 do
    begin
      if RawIndex = BufferSize then
      begin
        {$I-}
        Read (GIFFile,RawBytes^);
        {$I+}
        IOR := IOResult;
        RawIndex := 0;
      end;
      if not AnotherBuffer
        then Buffer^[BufferPtr] := Getbyte
        else Buffer2^[BufferPtr] := Getbyte;
      BufferPtr := Succ (BufferPtr);
      if BufferPtr=BufferSize then begin
        AnotherBuffer := true;
        BufferPtr := 0;
        AllocMem (Buffer2);
      end;
    end;
  Until Blocklength=0;
end; { ReadBuffer }

procedure DetColor(var PValue : byte; MapValue : Byte);
var
  Local : byte;
begin
  PValue := MapValue div 64;
  if (PValue = 1)
    then PValue := 2
    else if (PValue = 2)
      then PValue := 1;
end; { DetColor }

procedure Init;
var
  I : integer;
begin
  XC := 0;          {X and Y screen coords back to home}
  YC := 0;
  Pass := 0;        {Interlace pass counter back to 0}
  BitIndex := 0;   {Point to the start of the Buffer data stream}
  RawIndex := 0;      {Mock file read pointer back to 0}
  AnotherBuffer := false;    {Over 64000 flag off}
  AllocMem(Buffer);
  AllocMem(RawBytes);
  InputFileName := NewExtension(InputFileName,'GIF');
  {$I-}
  Assign(giffile,InputFileName);
  Reset(giffile);
  I := IOResult;
  if (I <> 0) then begin
    textmode(15);
    writeln('Error opening file ',InputFileName,'. Press any key ');
    readln;
    halt;
  end;
  read(GIFFile,RawBytes^);
  I := IOResult;
{$I+}
end; { Init }

procedure ReadGifHeader;
var
  I : integer;
begin
  TempString := '';
  for I := 1 to 6 do TempString := TempString + chr(Getbyte);
  if (TempString <> 'GIF87a') then begin
    textmode(15);
    writeln('Not a GIF file, or header read error. Press enter.');
    readln;
    halt;
  end;
  RWidth := Getword;         {The Buffer width and height}
  RHeight := Getword;
  B := Getbyte;
  Colormap := (B and $80 = $80);
  Resolution := B and $70 shr 5 + 1;
  BitsPerPixel := B and 7 + 1;
  ColorMapSize := 1 shl BitsPerPixel;
  BitMask := CodeMask[BitsPerPixel];
  Background := Getbyte;
  B := Getbyte;         {Skip byte of 0's}
  MyPalette.Size := Min(ColorMapSize,16);
  if Colormap then begin
    for I := 0 to pred(ColorMapSize) do begin
      Red[I] := Getbyte;
      Green[I] := Getbyte;
      Blue[I] := Getbyte;
      DetColor(R,Red[I]);
      DetColor(G,Green [I]);
      DetColor(B,Blue [I]);
      MyPalette.Colors[I] := B and 1 +
                    ( 2 * (G and 1)) + ( 4 * (R and 1)) + (8 * (B div 2)) +
                    (16 * (G div 2)) + (32 * (R div 2));
    end;
  end;
  B := Getbyte; 
  Leftofs := Getword;
  Topofs := Getword;
  Width := Getword;
  Height := Getword;
  A := Getbyte;
  Interlace := (A and $40 = $40);
  if Interlace then begin
    textmode(15);
    writeln('unable to display interlaced GIF pictures.');
    halt;
  end;
end; { ReadGifHeader }

procedure PrepDecompressor;
begin
  Codesize := Getbyte;
  ClearCode := PowersOf2[Codesize];
  EOFCode := ClearCode + 1;
  FirstFree := ClearCode + 2;
  FreeCode := FirstFree;
  inc(Codesize); 
  InitCodeSize := Codesize;
  Maxcode := Maxcodes[Codesize - 2];
  ReadMask := Masks[Codesize - 3];
end; { PrepDecompressor }

procedure DisplayGIF;
var
  Code : word;

  procedure DoClear;
  begin
    CodeSize := InitCodeSize;
    MaxCode := MaxCodes[CodeSize-2];
    FreeCode := FirstFree;
    ReadMask := Masks[CodeSize-3];
  end; { DoClear }

  procedure ReadCode;
  var
    Raw : longint;
  begin
    if (CodeSize >= 8) then begin
      move(Buffer^[BitIndex shr 3],Raw,3);
      Code := (Raw shr (BitIndex mod 8)) and ReadMask;
    end else begin
      move(Buffer^[BitIndex shr 3],Code,2);
      Code := (Code shr (BitIndex mod 8)) and ReadMask;
    end;
    if AnotherBuffer then begin
      ByteOffset := BitIndex shr 3;
      if (ByteOffset >= 63000) then begin
        move(Buffer^[Byteoffset],Buffer^[0],BufferSize-Byteoffset);
        move(Buffer2^[0],Buffer^[BufferSize-Byteoffset],63000);
        BitIndex := BitIndex mod 8;
        FreeMem(Buffer2,BufferSize);
      end;
    end;
    BitIndex := BitIndex + CodeSize;
  end; { ReadCode }

  procedure OutputPixel(Color : byte);
  begin
    putpixel(XC,YC,Color); { about 3x faster than using the DOS interrupt! }
    inc(XC);
    if (XC = Width) then begin
      XC := 0;
      inc(YC);
    end;
  end; { OutputPixel }

var lv1 : Word;

begin { DisplayGIF }
  CurCode := 0;
  OldCode := 0;
  FinChar := 0;
  OutCount := 0;
  DoClear;
  repeat
    ReadCode;
    if (Code <> EOFCode) then begin
      if (Code = ClearCode) then begin
        DoClear;
        ReadCode;
        CurCode := Code;
        OldCode := Code;
        FinChar := Code and BitMask;
        OutputPixel(FinChar);
      end else begin    
        CurCode := Code;
        InCode := Code;
        if (Code >= FreeCode) then begin
          CurCode := OldCode;
          PixelValue[OutCount] := FinChar;
          inc(OutCount);
        end;
        if (CurCode > BitMask) then repeat
          PixelValue[OutCount] := Suffix[CurCode];
          inc(OutCount);
          CurCode := Prefix[CurCode];
        until (CurCode <= BitMask);
        FinChar := CurCode and BitMask;
        PixelValue[OutCount] := FinChar;
        inc(OutCount);
        for lv1 := pred(OutCount) downto 0 do OutputPixel(PixelValue[lv1]);
        OutCount := 0;
        Prefix[FreeCode] := OldCode;
        Suffix[FreeCode] := FinChar;
        OldCode := InCode;
        inc(FreeCode);
        if (FreeCode >= MaxCode) then begin
          if (CodeSize < 12) then begin
            inc(CodeSize);
            MaxCode := MaxCode * 2;
            ReadMask := Masks[CodeSize - 3];
          end;
        end;
      end; {not Clear}
    end; {not EOFCode}
  until (Code = EOFCode);
end; { DisplayGIF }

begin { TP4GIF }
  InputFileName := TempString;
  Init;
  ReadGifHeader;
  PrepDecompressor;
  ReadBuffer;
  FreeMem(RawBytes,BufferSize);
  DisplayGIF;
  SetAllPalette(MyPalette);
  close(GifFile);
  freemem(Buffer,BufferSize);        { totally pointless, but it's good form }
end; { TP4GIF }


procedure fenster(x,y,x1,y1,breite: Word;farbe : Byte);
var x2,y2  : Word;
begin
 for x2:=x to x1 DO
 for y2:=y to y+breite DO begin
  putpixel(x2,y2,round(x2 * y2/1000)+farbe);
  putpixel(x2,y2+(y1-y),round(x2*y2/1000)+farbe);
 end;
 for x2:=x to x+breite DO
 for y2:=y to y1+breite DO begin
  putpixel(x2,y2,round(x2*y2/1000)+farbe);
  putpixel(x2+(x1-x),y2,round(x2*y2/1000)+farbe);
 end;
end;


procedure VIDEO_DISABLE(off : boolean);
var regs : registers;

begin
 regs.ah := $12;                    { BIOS function }
 regs.al := ord(off);               { 0 = on, 1 = off }
 regs.bl := $36;                    { Subfunction }
 intr($10, regs);                   { Call BIOS }
end;

procedure Keyboardrate(delay,rep : Byte);
var
	regs : registers;

begin
	regs.ah := $03;
	regs.al := $05;
	regs.bh := delay;
	regs.bl := rep;
	intr($16, regs);
end;

{********************************SCREEN*TO*GIF*******************************}
  Type
    ByteFile = File of Byte;

  Var
    Signature    : Array[0..5] of Byte;            {GIF signature}
    SDescriptor  : Array[1..7] of byte;            {screen descriptor}
    ColorMap     : Array[0..2,0..255] of byte;     {RGB color map}
    IDescriptor  : Array[1..10] of byte;           {image descriptor}
    GifFile      : ByteFile;                       {output file}
    Debugger     : Boolean;
    X,Y          : Integer;
    GifTerminator: Byte;                           {';' GIF terminator}

  {$I CMPRSS.INC}     {Include Bob Berry's LZW GIF compression routines}

  Procedure OpenGifFile(FileName:String;Var GifFile: ByteFile);
     Begin
       Assign(GifFile,FileName);
       ReWrite(GifFile);
     End;

  Procedure CloseGifFile(Var GifFile: ByteFile);
     Begin
       Close(GifFile);
     End;

  Procedure SaveDescriptor(Var GifFile:ByteFile);
     Var
       I,J                 :Integer;
       Pixel,MaxColor      :Byte;
     Begin
       For I:=0 to 5 do Write(GifFile,Signature[I]);
       For I:=1 to 7 do Write(Giffile,SDescriptor[I]);
       For J:=0 to GetMaxColor {MaxColor} do
         For I:=0 to 2 do Write(GifFile,ColorMap[I,J]);
       For I:=1 to 10 do Write(GifFile,IDescriptor[I]);
     End;

  Procedure GetAllRGBPalette(ColorNum:Integer; Var RedNum,GreenNum,BlueNum: Byte);
       {Procedure to return the color componant values of each color number.
        Uses the TP 'GetPalette' procedure.  Each componant normalized to
        a 0..255 range, eg (0,0,0) is black, (255,255,255) is white.

        TP 'GetPalette' returns a color with the following bit plane coding
        when in 640x350 or 640x480 EGA/VGA modes:
             bit   76543210
             gives 00rgbRGB
       ..where small letters mean low intensity and large letters mean high.
       In the lower resolution EGA/VGA modes, the 'GetPalette' returns a byte
       with the following coding:
             bit   76543210
             gives 000I0RGB
       ...where the I is the intensity bit.

       Palette values for the 4 color modes are internal to this procedure.

       This procedure does not work for the IBM8451 driver modes.  I have no
       idea where the palette values would be stored in this mode.  This
       procedure does not work for the EGAMonoHi mode only because
       GetMaxColor returns 3 (4 colors) in this two color mode (should
       return 1).

       Since virgin TP does not support 256 color modes, I have included an
       EGA/VGA BIOS routine to return the DAC palette values, should you be
       inclined to experiment with SVGA.}

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

  Procedure SetGifDescriptor;
    {sets the gif signature 'Signature[0..5]', screen
     descriptor array 'SDescriptor[1..7]', and global color
     map as follows:
       Signature = GIF87a as six bytes
       Screen Descriptor as seven bytes:

             bits
         7 6 5 4 3 2 1 0  Byte #
        +---------------+
        |               |  1
        +-Screen Width -+      Raster width in pixels (LSB first)
        |               |  2
        +---------------+
        |               |  3
        +-Screen Height-+      Raster height in pixels (LSB first)
        |               |  4
        +-+-----+-+-----+      M = 1, Global color map follows Descriptor
        |M|  cr |0|pixel|  5   cr+1 = # bits of color resolution
        +-+-----+-+-----+      pixel+1 = # bits/pixel in image (bit 3 of word 5 reserved)
        |   background  |  6   background=Color index of screen background
        +---------------+          (color is defined from the Global color
        |0 0 0 0 0 0 0 0|  7        map or default map if none specified)
        +---------------+

       Global Color Map has 3*GetMaxColor bytes.

    }

    Const
      X = 1;
      Y = 1;
      X1 = 40;
      Y1 = 1;
      GIF87a: Array[0..5] of Byte = (71,73,70,56,55,97);


    Var
      I,J                       :Integer;
      CR,Pixel                  :Byte;
      Regs: Registers;
    Begin
      {*** SCREEN DESCRIPTOR ******************************}

      {Signature}
      For I:=0 to 5 do
        Signature[I]:=GIF87a[I];

      {Screen Width}
      SDescriptor[1]:=(GetMaxX+1) Mod 256;
      SDescriptor[2]:=(GetMaxX+1) Div 256;

      {Screen Height}
      SDescriptor[3]:=(GetMaxY+1) Mod 256;
      SDescriptor[4]:=(GetMaxY+1) Div 256;


      SDescriptor[5]:=0;

      {M=1}
      SDescriptor[5]:=SDescriptor[5] OR 128; {1000000}

      {CR+1=bits color resolution}
      CR:=1;
      Case GetMaxColor of    {CR+1=color resolution=bits per RGB color componant}
         1: CR:=0;
         3: CR:=0;
        15: CR:=1;
       255: CR:=7;
      End;
      SDescriptor[5]:=SDescriptor[5] OR (CR shl 4);

      {Pixel+1=bits per pixel in image}
      Pixel:=3;
      Case GetMaxColor of
         1: Pixel:=0;
         3: Pixel:=1;
        15: Pixel:=3;
       255: pixel:=7;
      End;
      SDescriptor[5]:=SDescriptor[5] OR Pixel;

      {Background color}
      SDescriptor[6]:=0;         {set as black}

      {Reserved}
      SDescriptor[7]:=0;


      {****** Global Color Map *********************}

      For I:=0 to GetMaxColor do
         GetAllRGBPalette(I,ColorMap[0,I],ColorMap[1,I],ColorMap[2,I]);

      {*** IMAGE DESCRIPTOR *****************************}

      {ImageSepChar ',' }
      IDescriptor[1]:=Ord(',');

      {Image Left}
      IDescriptor[2]:=0 mod 256;
      IDescriptor[3]:=0 div 256;

      {Image Top}
      IDescriptor[4]:=0 mod 256;
      IDescriptor[5]:=0 div 256;

      {Image Width}
      IDescriptor[6]:=(GetMaxX+1) mod 256;
      IDescriptor[7]:=(GetMaxX+1) div 256;

      {Image Height}
      IDescriptor[8]:=(GetMaxY+1) mod 256;
      IDescriptor[9]:=(GetMaxY+1) div 256;

      {ImageSpecByte}
        IDescriptor[10]:=0;
      {M=1 local color map follows, use 'pixel'}
      {M=0 use global color map, ignore 'pixel'}
        {IDescriptor[10]:=IDescriptor[10] OR 128;} {10000000}
      {I=0 formatted in sequential order}
      {I=1 formatted in interlaced order}
        {IDescriptor[10]:=IDescriptor[10] OR 64;}  {01000000}
      {Pixel+1=bits per pixel for this image}
        Case GetMaxColor of
          1: Pixel:=0;
          3: Pixel:=1;
         15: Pixel:=3;
        255: pixel:=7;
        End;
        IDescriptor[10]:=IDescriptor[10] OR Pixel;
    End;

    Function GetByte:Integer;
      {Called by the LZW compression routines, GetByte produces
       a byte representing the color value of a pixel on the screen.
       The byte is packaged as the low byte of a word (integer).
       GetByte uses the global variables X and Y to keep track of
       its position on the screen.}

      Begin
        If X<GetMaxX
          Then
            Begin
              X:=X+1;
              GetByte:=GetPixel(X,Y);
            End
          Else
            Begin
              If Y<GetMaxY
                Then
                  Begin
                    Y:=Y+1;
                    X:=0;
                    GetByte:=GetPixel(X,Y);
                  End
                Else
                  Begin
                    GetByte:=(-1);
                  End;
            End;
      End;

  Procedure PutByte(B:Integer);
    {Called by the LZW compression routines, PutByte sends a byte
     of data to the forming GIF file.  The first byte sent by the LZW
     compression routings is the 'Minimum Code Size', next byte is
     the block size, then the bytes forming the data block, the next
     block size byte, next block data bytes, etc.  The byte is accepted
     from the compression routines as the low byte of an integer.}

    Var
      ByteNum: Byte;
    Begin
      ByteNum:=Lo(B);
      Write(GifFile,ByteNum);
    End;

Function GetMinCodeSize: Byte;
    {Produces the minimum number of bits required to represent
     the actual pixel value (the color number).  This would be the same
     as the bits per pixel except that because of algorithmic constraints
     of the LZW compression routines, black and white images with a
     bits-per-pixel of 1 have a minimum code size of 2.  Thus the
     mincodesize can be from 2 (black and white) to 8 (256 colors).}
  Var
    Code: Byte;
  Begin
    Case GetMaxColor of
       1: Code:=2;
       3: Code:=2;
      15: Code:=4;
     255: Code:=8;
    End;
    GetMinCodeSize:=Code;
  End;

  Function ScreenToGif(FileName: String):Integer;
    {Master function to create a GIF file 'FileName' from the graphics screen.
     Returns ScreenToGif=0 if no errors, ScreenToGif<>0 if some error
     encountered.}
    Var
      GifResult,I                   :Integer;
      {global var  X,Y : Integer}
    Begin
      GifTerminator:=$3B;                   {';'}
      X:=-1;                                {set (X,Y) for screen location...}
      Y:=0;                                 {...used in GetByte function.}
      OpenGifFile(FileName,GifFile);        {open the file for output}
      SetGifDescriptor;                     {set up GIF file info header}
      SaveDescriptor(GifFile);              {send info header to GIF file}
      GifResult:= CompressGif(GetMinCodeSize);  {send screen data to GIF file}
      Write(GifFile,GifTerminator);         {send ';' to end GIF mode}
      CloseGifFile(GifFile);                {close the file}
      ScreenToGif:=GifResult;               {pass along error codes}
    End;
{****************************SCREEN*TO*GIF*ENDE*****************************}

{*********************************Fli*Play**********************************}
CONST
  Clock_Hz     = 4608;                   {Frequency of clock}
  Monitor_Hz   = 70;                     {Frequency of monitor}
  Clock_Scale  = Clock_Hz DIV Monitor_Hz;
  CData        = $40;                    {Port number of timer 0}
  CMode        = $43;                    {Port number of timer control word}
  BufSize      = 65528;                  {Frame buffer size - Must be even}
  MCGA         = $13;                    {Number for MCGA mode}

TYPE
  MainHeaderRec = RECORD
    Padding1 : LongInt;
    ID       : Word;
    Frames   : Word;
    Padding2 : LongInt;
    Padding3 : LongInt;
    Speed    : Word;
    Padding4 : ARRAY[1..110] OF Char; {Pad to 128 Bytes}
  END; {MainHeaderRec}

  FrameHeaderRec = RECORD
    Size     : LongInt;
    Padding1 : Word;
    Chunks   : Word;
    Padding2 : ARRAY[1..8] OF Char; {Pad to 16 Bytes}
  END; {FrameHeaderRec}

{---------------------------------------------------------------------------}

  PROCEDURE VideoMode(Mode : Word);
    INLINE ($58/$CD/$10); {POP AX/INT 10}

  PROCEDURE InitClock; ASSEMBLER; {Taken from the FLILIB source}
  ASM
    mov  al,00110100b
    out  CMode,al
    xor  al,al
    out  CData,al
    out  CData,al
  END; {InitClock}

  FUNCTION GetClock : LongInt; ASSEMBLER; {Taken from the FLILIB source}
  {this routine returns a clock with occassional spikes where time
    will look like its running backwards 1/18th of a second.  The resolution
    of the clock is 1/(18*256) = 1/4608 second.  66 ticks of this clock
    are supposed to be equal to a monitor 1/70 second tick.}
  ASM
    mov  ah,0                  {get tick count from Dos and use For hi 3 Bytes}
    int  01ah                  {lo order count in DX, hi order in CX}
    mov  ah,dl
    mov  dl,dh
    mov  dh,cl
    mov  al,0                  {read lo Byte straight from timer chip}
    out  CMode,al              {latch count}
    mov  al,1
    out  CMode,al              {set up to read count}
    in   al,CData              {read in lo Byte (and discard)}
    in   al,CData              {hi Byte into al}
    neg  al                    {make it so counting up instead of down}
  END; {GetClock}

  PROCEDURE DrawFrame(Buffer : Pointer; Chunks : Word); ASSEMBLER;
  {this is the routine that takes a frame and put it on the screen}
  ASM
    cli                        {disable interrupts}
    push ds
    push es
    lds  si,Buffer             {let DS:SI point at the frame to be drawn}
  @Fli_Loop:                   {main loop that goes through all the chunks in a frame}
    cmp  Chunks,0              {are there any more chunks to draw?}
    je   @Exit
    dec  Chunks                {decrement Chunks For the chunk to process now}
    mov  ax,[Word ptr ds:si+4] {let AX have the ChunkType}
    add  si,6                  {skip the ChunkHeader}
    cmp  ax,0Bh                {is it a FLI_COLor chunk?}
    je   @Fli_Color
    cmp  ax,0Ch                {is it a FLI_LC chunk?}
    je   @Fli_Lc
    cmp  ax,0Dh                {is it a FLI_BLACK chunk?}
    je   @Fli_Black
    cmp  ax,0Fh                {is it a FLI_BRUN chunk?}
    je   @Fli_Brun
    cmp  ax,10h                {is it a FLI_COPY chunk?}
    je   @Fli_Copy
    jmp  @Fli_Loop             {This command should not be necessary }
  @Fli_Color:
    mov  bx,[Word ptr ds:si]   {number of packets in this chunk (always 1?)}
    add  si,2                  {skip the NumberofPackets}
    mov  al,0                  {start at color 0}
    xor  cx,cx                 {reset CX}
  @Color_Loop:
    or   bx,bx                 {set flags}
    jz   @Fli_Loop             {Exit if no more packages}
    dec  bx                    {decrement NumberofPackages For the package to process now}
    mov  cl,[Byte ptr ds:si+0] {first Byte in packet tells how many colors to skip}
    add  al,cl                 {add the skiped colors to the start to get the new start}
    mov  dx,$3C8               {PEL Address Write Mode Register}
    out  dx,al                 {tell the VGA card what color we start changing}
    inc  dx                    {at the port abow the PEL_A_W_M_R is the PEL Data Register}
    mov  cl,[Byte ptr ds:si+1] {next Byte in packet tells how many colors to change}
    or   cl,cl                 {set the flags}
    jnz  @Jump_Over            {if NumberstoChange=0 then NumberstoChange=256}
    inc  ch                    {CH=1 and CL=0 => CX=256}
  @Jump_Over:
    add  al,cl                 {update the color to start at}
    mov  di,cx                 {since each color is made of 3 Bytes (Red, Green & Blue) we have to -}
    shl  cx,1                  {- multiply CX (the data counter) With 3}
    add  cx,di                 {- CX = old_CX shl 1 + old_CX   (the fastest way to multiply With 3)}
    add  si,2                  {skip the NumberstoSkip and NumberstoChange Bytes}
    rep  outsb                 {put the color data to the VGA card FAST!}
    jmp  @Color_Loop           {finish With this packet - jump back}
  @Fli_Lc:
    mov  ax,0A000h
    mov  es,ax                 {let ES point at the screen segment}
    mov  di,[Word ptr ds:si+0] {put LinestoSkip into DI -}
    mov  ax,di                 {- to get the offset address to this line we have to multiply With 320 -}
    shl  ax,8                  {- DI = old_DI shl 8 + old_DI shl 6 -}
    shl  di,6                  {- it is the same as DI = old_DI*256 + old_DI*64 = old_DI*320 -}
    add  di,ax                 {- but this way is faster than a plain mul}
    mov  bx,[Word ptr ds:si+2] {put LinestoChange into BX}
    add  si,4                  {skip the LinestoSkip and LinestoChange Words}
    xor  cx,cx                 {reset cx}
  @Line_Loop:
    or   bx,bx                 {set flags}
    jz   @Fli_Loop             {Exit if no more lines to change}
    dec  bx
    mov  dl,[Byte ptr ds:si]   {put PacketsInLine into DL}
    inc  si                    {skip the PacketsInLine Byte}
    push di                    {save the offset address of this line}
  @Pack_Loop:
    or   dl,dl                 {set flags}
    jz   @Next_Line            {Exit if no more packets in this line}
    dec  dl
    mov  cl,[Byte ptr ds:si+0] {put BytestoSkip into CL}
    add  di,cx                 {update the offset address}
    mov  cl,[Byte ptr ds:si+1] {put BytesofDatatoCome into CL}
    or   cl,cl                 {set flags}
    jns  @Copy_Bytes           {no SIGN means that CL number of data is to come -}
                               {- else the next data should be put -CL number of times}
    mov  al,[Byte ptr ds:si+2] {put the Byte to be Repeated into AL}
    add  si,3                  {skip the packet}
    neg  cl                    {Repeat -CL times}
    rep  stosb
    jmp  @Pack_Loop            {finish With this packet}
  @Copy_Bytes:
    add  si,2                  {skip the two count Bytes at the start of the packet}
    rep  movsb
    jmp  @Pack_Loop            {finish With this packet}
  @Next_Line:
    pop  di                    {restore the old offset address of the current line}
    add  di,320                {offset address to the next line}
    jmp  @Line_Loop
  @Fli_Black:
    mov  ax,0A000h
    mov  es,ax                 {let ES:DI point to the start of the screen}
    xor  di,di
    mov  cx,32000              {number of Words in a screen}
    xor  ax,ax                 {color 0 is to be put on the screen}
    rep  stosw
    jmp  @Fli_Loop             {jump back to main loop}
  @Fli_Brun:
    mov  ax,0A000h
    mov  es,ax                 {let ES:DI point at the start of the screen}
    xor  di,di
    mov  bx,200                {numbers of lines in a screen}
    xor  cx,cx
  @Line_Loop2:
    mov  dl,[Byte ptr ds:si]   {put PacketsInLine into DL}
    inc  si                    {skip the PacketsInLine Byte}
    push di                    {save the offset address of this line}
  @Pack_Loop2:
    or   dl,dl                 {set flags}
    jz   @Next_Line2           {Exit if no more packets in this line}
    dec  dl
    mov  cl,[Byte ptr ds:si]   {put BytesofDatatoCome into CL}
    or   cl,cl                 {set flags}
    js   @Copy_Bytes2          {SIGN meens that CL number of data is to come -}
                               {- else the next data should be put -CL number of times}
    mov  al,[Byte ptr ds:si+1] {put the Byte to be Repeated into AL}
    add  si,2                  {skip the packet}
    rep  stosb
    jmp  @Pack_Loop2           {finish With this packet}
  @Copy_Bytes2:
    inc  si                    {skip the count Byte at the start of the packet}
    neg  cl                    {Repeat -CL times}
    rep  movsb
    jmp  @Pack_Loop2           {finish With this packet}
  @Next_Line2:
    pop  di                    {restore the old offset address of the current line}
    add  di,320                {offset address to the next line}
    dec  bx                    {any more lines to draw?}
    jnz  @Line_Loop2
    jmp  @Fli_Loop             {jump back to main loop}
  @Fli_Copy:
    mov  ax,0A000h
    mov  es,ax                 {let ES:DI point to the start of the screen}
    xor  di,di
    mov  cx,32000              {number of Words in a screen}
    rep  movsw
    jmp  @Fli_Loop             {jump back to main loop}
  @Exit:
    sti                        {enable interrupts}
    pop  es
    pop  ds
  END; {DrawFrame}

  CONSTRUCTOR TFliPlayer.Init;
  BEGIN
    IF MemAvail < BufSize THEN Fail;
    GetMem(Buffer,BufSize);
    ClearSpeed;
  END; {Init}

  DESTRUCTOR TFliPlayer.Done;
  BEGIN
    FreeMem(Buffer,BufSize);
  END; {Done}

  PROCEDURE TFliPlayer.SetSpeed(Speed : Integer);
  BEGIN
    Interval := Speed * Clock_Scale;
  END; {SetSpeed}

  PROCEDURE TFliPlayer.ClearSpeed;
  BEGIN
    Interval := -1;
  END; {ClearSpeed}

  PROCEDURE TFliPlayer.Play(Filename : String);
  VAR
    MainHeader  : MainHeaderRec;
    FrameHeader : FrameHeaderRec;
    FrameSize   : LongInt;
    RestartPos  : LongInt;
    Frame       : Word;
    Timeout     : LongInt;

    FUNCTION ReadHeader : Boolean;
    BEGIN
      BlockRead(FliFile,MainHeader,SizeOf(MainHeader)); {Read header record}
      WITH MainHeader DO
        IF ID <> $AF11 THEN
          ReadHeader := FALSE {Not a .FLI File}
        ELSE
          BEGIN
            IF Interval = -1 THEN {Read speed from header}
              Interval := Speed * Clock_Scale;
            ReadHeader := TRUE;
          END;
    END; {ReadHeader}

    PROCEDURE ReadFrame;
    BEGIN
      BlockRead(FliFile,FrameHeader,SizeOf(FrameHeader));
      FrameSize := FrameHeader.Size - SizeOf(FrameHeader);
    END; {ReadFrame}

    PROCEDURE ProcessFrame;
    BEGIN
      BlockRead(FliFile,Buffer^,FrameSize);
      DrawFrame(Buffer,FrameHeader.Chunks);
    END; {ProcessFrame}

  BEGIN {Play}
    {$I-}
    Assign(FLiFile,Filename);
    Reset(FliFile,1);
    IF (IOResult = 0) THEN
      BEGIN
        IF ReadHeader THEN
          BEGIN
            VideoMode(MCGA);
            InitClock;
            ReadFrame;
            RestartPos := SizeOf(MainHeader) + SizeOf(FrameHeader) + FrameSize;
            ProcessFrame;
             Frame := 1;
             REPEAT
               Timeout := GetClock + Interval;
               ReadFrame;
               IF FrameSize <> 0 THEN
                 ProcessFrame;
               REPEAT UNTIL GetClock > Timeout;
               Inc(Frame);
             UNTIL (Frame > MainHeader.Frames) OR Keypressed;
             Seek(FliFile,RestartPos);
            VideoMode(CO80);
          END;
        Close(FliFile);
      END;
    {$I+}
  END; {Play}

{---------------------------------------------------------------------------}

  FUNCTION Is286Able: Boolean; ASSEMBLER;
  ASM
    PUSHF
    POP     BX
    AND     BX,0FFFH
    PUSH    BX
    POPF
    PUSHF
    POP     BX
    AND     BX,0F000H
    CMP     BX,0F000H
    MOV     AX,0
    JZ      @@1
    MOV     AX,1
  @@1:
  END; {Is286Able}

  FUNCTION IsVGA : Boolean; ASSEMBLER;
  ASM
    MOV  AX,1A00h
    MOV  BL,10h
    INT  10h
    CMP  BL,8
    MOV  AX,1
    JZ   @@1
    MOV  AX,0
  @@1:
  END; {IsVGA}

  PROCEDURE PlayFli(Filename : String);
  VAR
    Player : TFliPlayer;
  BEGIN
    IF Is286Able AND IsVga THEN
      WITH Player DO
        IF Init THEN
          BEGIN
            Play(Filename);
            Done;
          END;
  END; {AAPlay}
{*****************************Fli*Play*Ende*********************************}
 var
   PreNonStopExitProc : pointer;

 const
   nonstop : boolean = false;

 procedure InstallVector; External; {$L NonStop} {Link in NONSTOP.OBJ}
 procedure RemoveVector; External;
 procedure NonStopISR; External;

 procedure InstallNonStopISR;

 begin
  if not nonstop then
  begin
   InstallVector;                     {Point Intr 9 to my ISR, save old }
   PreNonStopExitProc := ExitProc;    {Save old ExitProc                }
   ExitProc := @NonStopExitProc;      {Link in NonStopExitProc          }
   nonstop := true;
  end;
 end;

 procedure NonStopExitProc;

 begin
  ExitProc := PreNonStopExitProc;      {Point ExitProc to next  }
  RemoveVector;                        {Return old Int 9 Vector }
 end;


function zufallbuh : Boolean;
var a : Byte;
begin
 a:=Random(250);
 if a/2 = Round(a/2) then zufallbuh:=true;
 if a/2 <> Round(a/2) then zufallbuh:=false;
end;

procedure prozentbar(x1,y1,x2,y2:Word;prozent:Real);

begin
 if prozent<>0 then bar (x1,y1,x1+(round(((x2-x1)/100)*prozent)),y2);
end;

procedure verzierrechteck(x1,y1,x2,y2 : Word);
var oldstyle : LineSettingstype;
begin
  GetLineSettings(OldStyle);
  SetLineStyle(DottedLn,0,NormWidth);
  Rectangle(x1, y1, x2, y2);
  SetLineStyle(UserBitLn,$C3,ThickWidth);
  Rectangle(Pred(x1), Pred(y1),Succ(x2), Succ(y2));
  with OldStyle do SetLineStyle(LineStyle, Pattern, Thickness);
end;

procedure bildschirmstandby;

begin
 ASM;
  MOV AX,11;
  INT 16;
 End;
end;

procedure neuboot;

begin
 asm
  mov ds,ax
  mov es,ax
  cld
  in al,21h
  or al,2
  out 21h,al
  xor ah,ah
  int 1ah
 end;
end;

procedure tpl;
begin
 asm
  mov ax,0c00h
  int 21h
 end;
end;

procedure zentertext (x1,y1,x2,y2 : word;msg : String);
var Art : TextSettingsType;
begin
 gettextsettings(art);
 SetTextJustify(CenterText,CenterText);
 OutTextXY(((x2 - x1) div 2)+x1,((y2-y1) div 2)+y1,Msg);
 settextJustify(art.Horiz,art.Vert);
end;

procedure command(befehl : String);
begin
 if befehl <> '' then befehl := '/C ' + befehl;
 SwapVectors;
 Exec(GetEnv('COMSPEC'), befehl);
 SwapVectors;
 closegraph;
 if doserror<>0 then writeln(doserror);
end;

function FileExists(FileName: string): Boolean;
var f: file;
begin
 {$I-}
 Assign(f, FileName);
 Reset(f);
 Close(f);
 {$I+}
 FileExists := (IOResult = 0) and (FileName <> '');
end;

function direxists(s : String) : Boolean;

begin
 {$I-}
 MkDir(s);
 if IOResult <> 0 then direxists:=true
 else direxists:=false;
 {$I+}
end;

function Esc : Boolean;

begin
 if port[$60]=1 then esc:=true
 else esc:=false;
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

procedure ubuttonschrift (x1,y1,x2,y2 : word;msg : String);
var lv1 : Laufvar;
    Art : TextSettingsType;
begin
 for lv1 := x1-1 to x2+1 DO putpixel(lv1,y1-1,darkgray);
 for lv1 := x1-1 to x2+1 DO putpixel(lv1,y1,darkgray);
 for lv1 := y1-1 to y2+1 do putpixel(x1,lv1,darkgray);
 for lv1 := y1-1 to y2+1 do putpixel(x1-1,lv1,darkgray);
 for lv1 := x1-1 to x2+1 do putpixel(lv1,y2,lightgray);
 for lv1 := x1-1 to x2+1 do putpixel(lv1,y2+1,lightgray);
 for lv1 := y1-1 to y2+1 do putpixel(x2,lv1,lightgray);
 for lv1 := y1-1 to y2+1 do putpixel(x2+1,lv1,lightgray);
 gettextsettings(art);
 SetTextJustify(CenterText,CenterText);
 OutTextXY(((x2 - x1) div 2)+x1{+3},((y2-y1) div 2)+y1{+2},Msg);
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
var
  FromF, ToF: file;
  NumRead, NumWritten: Word;
  buf: array[1..2048] of Char;
begin
  Assign(FromF, von);
  Reset(FromF, 1);
  Assign(ToF, zu);
  Rewrite(ToF, 1);
  repeat
    BlockRead(FromF,buf,SizeOf(buf),NumRead);
    BlockWrite(ToF,buf,NumRead,NumWritten);
  until (NumRead = 0) or (NumWritten <> NumRead);
  Close(FromF);
  Close(ToF);
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

var taste,tastealt : char;
    zusammen : array [0..5] of char;
    lv1,cursorpos : Laufvar;
    farbealt:byte;
    test,code : Integer;

begin
 tpl;
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 5 DO zusammen[lv1]:='»';
 s:=0;
 lv1:=0;
 test:=0;
 taste:='9';
 tastealt:='9';
 repeat
  setcolor (white);
  if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
  else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
  if keypressed then begin
    taste:=readkey;
    if Not((taste>=#48) and (taste<=#57) or (taste=backspace) or (taste=Return)) then taste:=tastealt;
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
  tastealt:=taste;
 end;
 end;
 delay(600);
 setcolor (black);
 if (taste <>Backspace) and (taste <> return) then line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
 else line (x,y+textheight('9'),x+TextWidth('9'),y+textheight('9'));
 delay(300);
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='»' then exit;
  val(zusammen[lv1],test,code);
  s:=s*10+test;
 end;
 tpl;
end;

function RealToStr(i: real): string;

var s: string[11];
begin
  Str(i:0:2, s);
  realToStr := s;
end;

function IntToStr(i: Longint): string;

var s: string[11];
begin
  Str(i, s);
  IntToStr := s;
end;

procedure readtextlange(x,y : word; var s : string;l: Byte );

var taste : char;
    zusammen : array [0..255] of char;
    lv1,cursorpos : Laufvar;
    farbealt:byte;

begin
 tpl;
 s:='';
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 255 DO zusammen[lv1]:='»';
 lv1:=0;
 taste:='M';
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
  if (taste <> return) and (taste <> backspace) and (lv1 < l) then
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
 else line (x,y+textheight('M'),x+TextWidth('M'),y+textheight('M'));
 delay(300);
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='»' then exit;
  s:=s+zusammen[lv1];
 end;
 tpl;
end;

procedure readtext3d(x,y : word; var s : string);

var taste : char;
    zusammen : array [0..255] of char;
    lv1,cursorpos,a : Laufvar;
    farbealt:byte;
    art : Textsettingstype;

begin
 tpl;
 s:='';
 a:=0;
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 255 DO zusammen[lv1]:='»';
 lv1:=0;
 gettextsettings(art);
 taste:='M';
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
  else line (x,y+textheight('M'),x+TextWidth('M'),y+textheight('M'));
 delay(300);
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='»' then exit;
  s:=s+zusammen[lv1];
 end;
 tpl;
end;

procedure readtext3dsound(x,y : word; var s : string);

var taste : char;
    zusammen : array [0..255] of char;
    lv1,cursorpos,a : Laufvar;
    farbealt:byte;
    art : Textsettingstype;

begin
 tpl;
 s:='';
 a:=0;
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 255 DO zusammen[lv1]:='»';
 lv1:=0;
 taste:='M';
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
  else line (x,y+textheight('M'),x+TextWidth('M'),y+textheight('M'));
 delay(300);
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='»' then exit;
  s:=s+zusammen[lv1];
 end;
 tpl;
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
      If Odd (Pixel) then Write ('€') else Write(' ');
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
    closegraph;
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

function fgross (s:String) : String;
var i : Integer;

begin
 for i := 1 to Length(s) do begin
  if s[i]= 'î' then s[i]:='ô';
  if s[i]= 'Ñ' then s[i]:='é';
  if s[i]= 'Å' then s[i]:='ö';
  if (s[i]<>'î') and (s[i]<>'Ñ') and (s[i]<>'Å') then s[i] := UpCase(s[i]);
 end;
 fgross:=s;
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
 tpl;
 s:='';
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 255 DO zusammen[lv1]:='»';
 lv1:=0;
 taste:='M';
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
 else line (x,y+textheight('M'),x+TextWidth('M'),y+textheight('M'));
 delay(300);
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='»' then exit;
  s:=s+zusammen[lv1];
 end;
 tpl;
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
 tpl;
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
{keepx(0,ptr(sseg,0)) zusÑtzlich ohne Stack}
{keepx(0,@saveint00) zusÑtzlich ohne Vektorentabelle}
{keepx(0,@input) zusÑtzlich ohne I/O-Buffer}
{...}
{Keepx(0,@keepx) nur bis zur Routine Keepx selbst}

begin
 CDROM:=installed;
 checkbreak:=false;
end.