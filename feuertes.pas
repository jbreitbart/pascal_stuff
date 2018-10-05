{$A+,B-,D+,E+,F-,G+,I-,L+,N+,O-,R-,S-,V-,X+}
{$M 16384,0,655360}

Program Burn;
uses
  Dos,Crt;

Const
  RootRand     =  20;
  Decay        =  5; 
  MinY         = 50; 
  Smooth       =   1; 
  MinFire      =  10; 
  XStart       =  15; 
  XEnd         = 287; 
  Width        = XEnd-XStart;
  MaxColor     = 110;  
  FireIncrease : Byte =   1; 

Var
  Scr : Array[0..199,0..319] Of Byte Absolute $A000:$0000;

Type
  ColorValue     = record
                     R, G, B : byte;
                   end;
  VGAPaletteType = array[0..255] of ColorValue;


procedure ReadPal(var Pal);
var
  K    : VGAPaletteType Absolute Pal;
  Regs : Registers;
begin
  with Regs do
  begin
    AX := $1017;
    BX := 0;
    CX := 256;
    ES := Seg(K);
    DX := Ofs(K);
    Repeat Until Port[$03DA] And $08 = $08; 
    Intr($10,Regs);
  end;
end;

procedure WritePal(var Pal);
Var
  K : VGAPaletteType Absolute Pal;
  Regs : Registers;
begin
  with Regs do
  begin
    AX := $1012;
    BX := 0;
    CX := 256;
    ES := Seg(K);
    DX := Ofs(K);
    Repeat Until Port[$03DA] And $08 = $08; 
    Intr($10,Regs);
  end;
end;

Procedure Hsi2Rgb(H, S, I : Real; var C : ColorValue);
var
  T : Real;
  Rv, Gv, Bv : Real;
begin
  T := H;
  Rv := 1 + S * Sin(T - 2 * Pi / 3);
  Gv := 1 + S * Sin(T);
  Bv := 1 + S * Sin(T + 2 * Pi / 3);
  T := 63.999 * I / 2;
  with C do
  begin
    R := trunc(Rv * T);
    G := trunc(Gv * T);
    B := trunc(Bv * T);
  end;
end; 


procedure put(x,y : integer; c : byte); assembler;
 asm
  mov ax,y
  mov bx,ax
  shl ax,8
  shl bx,6
  add bx,ax
  add bx,x
  mov ax,0a000h
  mov es,ax
  mov al,c
  mov es:[bx],al
 end;

Function get(x,y : integer):byte;
begin
 asm
  mov ax,y
  mov bx,ax
  shl ax,8
  shl bx,6
  add bx,ax
  add bx,x
  mov ax,0a000h
  mov es,ax
  mov al,es:[bx]
  mov @result,al
 end;
end;

Procedure MakePal;
Var
  I : Byte;
  Pal   : VGAPaletteType;

begin
  FillChar(Pal,SizeOf(Pal),0);
  For I:=1 To MaxColor Do
    HSI2RGB(4.6-1.5*I/MaxColor,I/MaxColor,I/MaxColor,Pal[I]);
  For I:=MaxColor To 255 Do
  begin
    Pal[I]:=Pal[I-1];
    With Pal[I] Do
    begin
      If R<63 Then Inc(R);
      If R<63 Then Inc(R);
      If (I Mod 2=0) And (G<53)  Then Inc(G);
      If (I Mod 2=0) And (B<63) Then Inc(B);
    end;
  end;

  WritePal(Pal);

end;


Function Rand(R:Integer):Integer;
begin
  Rand:=Random(R*2+1)-R;
end;

procedure help;
var r : Registers;
begin
  R.Ax:=$0000+$13;
  Intr($10,R);
  MakePal;
end;

Var
  FlameArray : Array[XStart..XEnd] Of Byte;
  LastMode : Byte;
  I,J : Integer;
  X,P : Integer;
  MoreFire,
  V   : Integer;
  FlameArray1 : Array[XStart..XEnd] Of Byte;
  LastMode1 : Byte;
  I1,J1 : Integer;
  X1,P1 : Integer;
  MoreFire1,
  V1  : Integer;
  R   : Registers;

begin

  Help;
  RandomIze;
  R.Ax:=$0F00;
  Intr($10,R);
  LastMode:=R.Al;
  R.Ax:=$0013;
  Intr($10,R);

  MoreFire:=90;
  MoreFire1:=90;
  MakePal;
  For I:=XStart To XEnd Do
    FlameArray[I]:=0;

  For I1:=XStart To XEnd Do
    FlameArray1[I1]:=0;

  FillChar(Scr,SizeOf(Scr),0);

  FireIncrease:=3;
  FillChar(FlameArray[50],5,255);
  FillChar(FlameArray1[250],5,255);
  repeat
    For I:=XStart To XEnd Do Put(I,199,FlameArray[I]);
    For I:=XStart To XEnd Do
    For J:=MinY To 199 Do
    begin
      V:=Get(I,J);
      If (V=0) Or (V<Decay) Or (I<=XStart) Or (I>=XEnd) Then Put(I,Pred(J),0)
      else
        Put(I-Pred(Random(3)),Pred(J),V-Random(Decay));
    end;
    For I1:=XStart To XEnd Do Put(I1,199,FlameArray1[I1]);
    For I1:=XStart To XEnd Do
    For J1:=MinY To 199 Do
    begin
      V1:=Get(I1,J1);
      If (V1=0) Or (V1<Decay) Or (I1<=XStart) Or (I1>=XEnd) Then Put(I1,Pred(J1),0)
      else
        Put(I1-Pred(Random(3)),Pred(J1),V1-Random(Decay));
    end;

  Until keypressed;
  R.Ax:=$0000+LastMode;
  Intr($10,R);
end.