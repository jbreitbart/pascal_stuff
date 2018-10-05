{$R-}
uses crt;
CONST VGA=$A000; Max=999;
{1015}
VAR SinT, CosT:
Array[1..360]of Integer;
S:Array[1..Max]of Record x,xc,r,w:
Word; y,yc:Byte;end;
a,x,y:Word; r:ShortInt;
Procedure Neu;begin S[a].x:=x;
S[a].y:=y;
S[a].xc:=x;S[a].yc:=y;S[a].r:=1;
S[a].w:=Random(360)+1;end;
Begin For a:=0to 360do begin
 SinT[a]:=
 Round(Sin(a*Pi/180)*128*2.5);
 CosT[a]:=
 Round(Cos(a*Pi/180)*128);end;
 x:=160;y:=100;r:=1;
 For a:=1to Max do
 begin Neu;S[a].r:=Random(60)+2;
 end;
 ASM;MOV AX,19;INT 16;End;
 For a:=1to 99
 do begin Port[$3C8]:=a;
  Port[$3C9]:=63*a div 99;
  Port[$3C9]:=63*a div 99;
  Port[$3C9]:=63*a div 99;end;
 Repeat For a:=1to Max do Begin
  Mem[VGA:S[a].x+S[a].y*320]:=0;
  S[a].x:=S[a].xc+SinT[S[a].w]*S[a].r shr 7;
  S[a].y:=S[a].yc+CosT[S[a].w]*S[a].r shr 7;
  Inc(S[a].r);S[a].w:=S[a].w mod 359+2;
  If(S[a].x>310)or(S[a].x<10)or(S[a].y>190)or(S[a].y<10) then Neu;
  Mem[VGA:S[a].x+S[a].y*320]:=S[a].r;
  End;
  If(x>170)or(x<150) then r:=-r; x:=x+r; y:=y+r;
 delay(100);
 Until Port[96]=1;ASM;
 MOV AX,3;INT 16;End;
End.