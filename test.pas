unit test;

INTERFACE

uses crt, dos, GRAPH;

const ProgramName = 'TP4GIF';
      ProgramRevision = '2';

type BufferArray = array[0..63999] of byte;
     BufferPointer = ^BufferArray;

var GifFile : file of BufferArray;
    InputFileName : string;
    RawBytes : BufferPointer;
    Buffer : BufferPointer;  
    Buffer2 : BufferPointer; 
    Byteoffset,BitIndex : longint;
    Width,Height,LeftOfs,TopOfs,RWidth,RHeight,ClearCode,EOFCode,OutCount,MaxCode,CurCode,OldCode,InCode,FirstFree,FreeCode,
    RawIndex,BufferPtr,XC,YC,ReadMask,I:word;
    Interlace,AnotherBuffer,ColorMap: boolean;
    ch : char;
    a,Resolution,BitsPerPixel,Background,ColorMapSize,CodeSize,InitCodeSize,FinChar,Pass,BitMask,R,G,B:byte;
    Prefix: array[0..4095] of word;
    Suffix: array[0..4095] of byte;
    PixelValue : array[0..1024] of byte;
    Red,Green,Blue: array [0..255] of byte;
    MyPalette : PaletteType;
    TempString : String;

Const MaxCodes: Array [0..9] of Word = (4,8,16,$20,$40,$80,$100,$200,$400,$800);
      CodeMask:Array [1..4] of byte= (1,3,7,15);
      PowersOf2: Array [0..8] of word=(1,2,4,8,16,32,64,128,256);
      Masks: Array [0..9] of integer = (7,15,$1f,$3f,$7f,$ff,$1ff,$3ff,$7ff,$fff);
      BufferSize : Word = 64000;

procedure showgif (datei : String);

IMPLEMENTATION

function NewExtension(FileName,Extension : string) : string;
var I : integer;
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
end;

function Min(I,J : longint) : longint;
begin
  if (I < J) then Min := I else Min := J;
end;

procedure AllocMem(var P : BufferPointer);
var ASize : longint;
begin
  ASize := MaxAvail;
  if (ASize < BufferSize) then begin
    Textmode(15);
    writeln('Insufficient memory available!');
    halt;
  end else getmem(P,BufferSize);
end;

function Getbyte : byte;
begin
  if (RawIndex >= BufferSize) then exit;
  Getbyte := RawBytes^[RawIndex];
  inc(RawIndex);
end;

function Getword : word;
var W : word;
begin
  if (succ(RawIndex) >= BufferSize) then exit;
  move(RawBytes^[RawIndex],W,2);
  inc(RawIndex,2);
  Getword := W;
end;

procedure ReadBuffer;
var BlockLength : byte;
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
end;

procedure DetColor(var PValue : byte; MapValue : Byte);
var Local : byte;
begin
  PValue := MapValue div 64;
  if (PValue = 1)
    then PValue := 2
    else if (PValue = 2)
      then PValue := 1;
end;

procedure Init;
var I : integer;
begin
  XC := 0;
  YC := 0;
  Pass := 0;    
  BitIndex := 0;
  RawIndex := 0;
  AnotherBuffer := false;
  AllocMem(Buffer);
  AllocMem(RawBytes);
  InputFileName := NewExtension(InputFileName,'GIF');
  {$I-}
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
end;

procedure ReadGifHeader;
var I : integer;
begin
  TempString := '';
  for I := 1 to 6 do TempString := TempString + chr(Getbyte);
  RWidth := Getword;
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
    writeln(ProgramName,' is unable to display interlaced GIF pictures.');
    halt;
  end;
end;

procedure PrepDecompressor;
begin
  Codesize := Getbyte;
  ClearCode := PowersOf2[Codesize];
  EOFCode := ClearCode + 1;
  FirstFree := ClearCode + 2;
  FreeCode := FirstFree;
  inc(Codesize); { since zero means one... }
  InitCodeSize := Codesize;
  Maxcode := Maxcodes[Codesize - 2];
  ReadMask := Masks[Codesize - 3];
end;

procedure ShowGIF(Datei : String);
var Code : word;

  procedure DoClear;
  begin
    CodeSize := InitCodeSize;
    MaxCode := MaxCodes[CodeSize-2];
    FreeCode := FirstFree;
    ReadMask := Masks[CodeSize-3];
  end;

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
  end; 

  procedure OutputPixel(Color : byte);
  begin
    putpixel(XC,YC,Color); 
    inc(XC);
    if (XC = Width) then begin
      XC := 0;
      inc(YC);
      if (YC mod 10 = 0) then begin
      end;
    end;
  end; 

begin
  {$R-}{$S-}{$B-}
  assign(giffile,datei);
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
        for I := pred(OutCount) downto 0 do OutputPixel(PixelValue[I]);
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
      end;
    end; 
  until (Code = EOFCode);
end; 

end.