 (*
 [][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
 []                              Cmp.Inc                               []
 []                                                                    []
 [] A Turbo Pascal Implementation of the CompuServe GIF LZW compress   []
 [] algorithm.                                                         []
 []                                                                    []
 [][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
 []                                                                    []
 [] Usage:                                                             []
 []        {$I Cmp.Inc }                                               []
 []                                                                    []
 []        Function GetByte;                                           []
 []          begin                                                     []
 []            GetByte:= ???;      { return a byte from the image }    []
 []                                { return -1 at end-of-image }       []
 []          end;                                                      []
 []                                                                    []
 []        Procedure PutByte;                                          []
 []          begin                                                     []
 []            ???(Lo(B));         { write the byte to the GIF file }  []
 []          end;                                                      []
 []                                                                    []
 []        begin                                                       []
 []          { open the GIF file }                                     []
 []          GifResult:= CompressGif(MinCodeSize);                     []
 []          { close the GIF file }                                    []
 []        end.                                                        []
 []                                                                    []
 [][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
 []                                                                    []
 []   As noted, forward referenced procedure GetByte should return a   []
 [] byte from the image to be compressed to GIF, and a -1 to indicate  []
 [] end of image.                                                      []
 []                                                                    []
 []   To retain a close parallel with the C source, PutByte is passed  []
 [] an integer, although the Lo() portion is the byte to move to the   []
 [] output GIF file.                                                   []
 []                                                                    []
 []   As much as I hate labels and goto's, the compress routine uses   []
 [] one, again to stay parallel with the C code.                       []
 []                                                                    []
 []   Although I haven't seen any documentation concerning MinCodeSize []
 [] and its effect, GIF files that I've examined all seem to use 4.    []
 []                                                                    []
 []   As in Exp.Inc, I have kept the New() and Dispose() of CodeTable  []
 [] in the CompressGIF function, although personal preference would be []
 [] to move them to the program MainLine.                              []
 []                                                                    []
 []                                              Bob Berry [76555,167] []
 []                                                                    []
 [][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
 *)

Function GetByte: Integer;              Forward;
Procedure PutByte(B: Integer);          Forward;

Const LargestCode                     = 4095;
      TableSize                       = 5003;

Type  CodeEntry                       = Record
                                          PriorCode: Integer; { 2 bytes }
                                          CodeID:    Integer; { 2 bytes }
                                          AddedChar: Byte;    { 1 byte  }
                                        end;                  { 5 * 5004=24k+}
      CodeTableType                   = Array[0..TableSize] of CodeEntry;
      TablePointer                    = ^CodeTableType;

Var   CodeSize,   ClearCode,
      EOFCode,    MinCode,
      BitOffset,  ByteOffset,
      BitsLeft,   MaxCode,
      FreeCode,   PrefixCode,
      SuffixChar,
      Hx,         D:                    Integer;
      CmpError:                         Integer;
      CodeBuffer:                       Array[0..259] of Byte;
      CodeTable:                        TablePointer;

Procedure InitializeTable(MinCodeSize: Byte);
  Var I: Integer;
  begin
    CodeSize:=  Succ(MinCodeSize);
    ClearCode:= 1 Shl MinCodeSize;
    EOFCode:=   Succ(ClearCode);
    FreeCode:=  Succ(EOFCode);
    MaxCode:=   1 Shl CodeSize;
    For I:=0 to Pred(TableSize) do CodeTable^[I].CodeID:=0;
  end;   { Procedure InitializeTable }

Procedure FlushBuffer(N: Integer);
  Var I: Integer;
  begin
    PutByte(N);
    For I:=0 to Pred(N) do PutByte(CodeBuffer[I]);
  end;   { Procedure FlushBuffer }

Procedure WriteCode(Code: Integer);
  Var
    AX,DX,I: Integer;
  begin
    ByteOffset:= BitOffset Shr 3;
    BitsLeft:=   BitOffset And 7;
    If ByteOffset>=254 then
      begin
        FlushBuffer(ByteOffset);
        CodeBuffer[0]:=CodeBuffer[ByteOffset];
        BitOffset:=BitsLeft;
        ByteOffset:=0;
      end;
    If BitsLeft>0 then
      Inline(
      $8B/$46/<CODE      {     mov   ax,<Code[bp]       ; Ax:=Code;           }
      /$31/$D2           {     xor   dx,dx              ; Dx:=0;              }
      /$8B/$0E/>BITSLEFT {     mov   cx,[>BitsLeft]     ; Cx:=BitsLeft;       }
      /$49               {A1:  dec   cx                 ; count a bit         }
      /$7C/$06           {     jl    A2                 ; ( do cx shifts )    }
      /$D1/$E0           {     shl   ax,1               ; shift bit into carry}
      /$D1/$D2           {     rcl   dx,1               ; shift carry into Dx }
      /$EB/$F7           {     jmp short A1             ; continue            }
      /$BE/>CODEBUFFER   {A2:  mov   si,>CodeBuffer     ; point to CodeBuffer }
      /$8B/$1E/>BYTEOFFSET{     mov   bx,[>ByteOffset]   ; index to ByteOffset}
      /$08/$00           {     or    [si+bx],al         ; OR low eight bits   }
      /$88/$60/$01       {     mov   [si+bx+1],ah       ;   move next 16 bits }
      /$88/$50/$02)      {     mov   [si+bx+2],dl       ;  to ByteOffset +1,+2}
    else
      begin
        CodeBuffer[ByteOffset]:=   Lo(Code);
        CodeBuffer[ByteOffset+1]:= Hi(Code);
      end;
    BitOffset:=BitOffset+CodeSize;
  end;   { Procedure WriteCode }

{ ---------------------------------------------------------------------------
  NOTE: For simplicity, CompressGIF does not test MinCodeSize for valid
        values (in [2..9]), primarily since I was too lazy. As mentioned,
        the "customary" value seems to be 4.

        "While True" and "GoTo Break" are used to parallel the C coding of
        "For (;;)" and "break".
  --------------------------------------------------------------------------- }
Function CompressGIF(MinCodeSize: Byte): Integer;
  Var   MAvail:   Integer;
        MemAvail: Real;
  Label Break;

  Function SuffixCharEqualGetByte: Integer;
    begin
      SuffixChar:=GetByte;
      SuffixCharEqualGetByte:=SuffixChar;
    end;   { Function SuffixCharEqualGetByte }

  begin
    CmpError:=0; CompressGIF:=CmpError;

(*    MAvail:=MaxAvail;
    If MAvail<0 then MemAvail:=65536.0+MAvail
    else             MemAvail:=    0.0+MAvail;
    MemAvail:=16.0*MemAvail;
    If MemAvail<SizeOf(CodeTableType) then
*)
    If MaxAvail<SizeOf(CodeTableType) then      {update for TP 4.0 and above}
      begin
        CmpError:=-2; CompressGif:=CmpError; Exit;
      end
    else New(CodeTable);
    PutByte(MinCodeSize); BitOffset:=0; InitializeTable(MinCodeSize);
    WriteCode(ClearCode);

    SuffixChar:=GetByte;
    If SuffixChar>=0 then
      begin
        PrefixCode:=SuffixChar;
        While SuffixCharEqualGetByte>=0 do
          begin
            Hx:=(PrefixCode Xor (SuffixChar Shl 5)) mod TableSize;
            D:=1;
            While True do
              begin
                If CodeTable^[Hx].CodeID=0 then
                  begin
                    WriteCode(PrefixCode);
                    D:=FreeCode;
                    If FreeCode<=LargestCode then
                      begin
                        CodeTable^[Hx].PriorCode:= PrefixCode;
                        CodeTable^[Hx].AddedChar:= SuffixChar;
                        CodeTable^[Hx].CodeID:=    FreeCode;
                        FreeCode:=                 Succ(FreeCode);
                      end;
                    If D=MaxCode then
                      If CodeSize<12 then
                        begin
                          CodeSize:=Succ(CodeSize); MaxCode:=MaxCode Shl 1;
                        end
                      else
                        begin
                          WriteCode(ClearCode); InitializeTable(MinCodeSize);
                        end;
                    PrefixCode:=SuffixChar;
                    GoTo Break;
                  end;
                If (CodeTable^[Hx].PriorCode=PrefixCode) and
                   (CodeTable^[Hx].AddedChar=SuffixChar) then
                  begin
                    PrefixCode:=CodeTable^[Hx].CodeID;
                    GoTo Break;
                  end;
                Hx:=Hx+D; D:=D+2;
                If Hx>=TableSize then Hx:=Hx-TableSize;
              end;
Break:
          end;
        If SuffixChar<>-1 then
          begin
            CmpError:=SuffixChar; CompressGIF:=CmpError; Exit;
          end;
        WriteCode(PrefixCode);
      end
    else
      If SuffixChar<>-1 then
        begin
          CmpError:=SuffixChar; CompressGif:=CmpError; Exit;
        end;
    WriteCode(EOFCode);
    If BitOffset>0 then FlushBuffer((BitOffset+7) div 8);
    FlushBuffer(0);
    Dispose(CodeTable);
  end;   { Function CompressGIF }

