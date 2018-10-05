{$R-}

uses crt;

Const  Max = 1100;
Var SinT, CosT: Array[1..360] of Integer;
    st: array[1..max] of record
    x,xc,r,w: Word;
    y,yc:byte;end;
    a,x,y:word;
    r: Shortint;


Procedure Neu;
 Begin st[a].x:=x;st[a].y:=y;
  st[a].xc:=x;st[a].yc:=y;
  st[a].r:=1; st[a].w:=random (360)+1;
 end;

 Begin
  For a:=1 to 360 do begin
   sint[a]:=round(sin(a*pi/180)*128*2.5);
   cost[a]:=round(cos(a*pi/180)*128);
  end;
  x:=160;
  y:=100;
  r:=1;
   For a:=1 to max do begin
    neu;
    st[a].r:=random(60)+2;
   end;
  Inline ($b8/$13/$00/$cd/$10); {scr.13}
  For a:= 1 to 99 do begin
   port[$3c8]:=a;
   inline ($fa);
    port[$3c9]:=63;
    port[$3c9]:=63*a div 99;
    port[$3c9]:=0; inline($fb);end;
   repeat
    for a:=1 to max do begin
    MEM [$a000:st[a].x+st[a].y*320]:=0;
    delay (1);
    St[a].x:=st[a].xc+sint[st[a].w]* st[a].r shr 7;
    st[a].y:=st[a].yc+cost[st[a].w]* st[a].r shr 7;
    inc(st[a].r);
    st[a].w:=st[a].w mod 359+2;
   if (st[a].x>310) or (st[a].x<10) or (st[a].y>190) or (st[a].y<10) then neu;
     mem[$a000:St[a].x+st[a].y*320]:=st[a].r;end;
   If (x>170) or (x<150) then r:=-r;
     x:=x+r;
     y:=y+r;
   until Port[96]=1;
   asm
    mov ax,3
    int 10h
   end;
end.

