{$R-}
uses graph;

var s,c,tifl : array[0..359] of real;
    maxtif,t : Byte;
    gd,gm,i : Integer;

procedure frac(x,y,w : Word;len : Real);

 procedure ast(x,y,w : Word);
 var x1,y1,o : Word;
 begin
  o:=w mod 360;
  if t<=maxtif then begin
   x1:=trunc(s[o]*len)+x;
   y1:=trunc(c[o]*len)+y;
   setcolor(t);
   line(x,y,x1,y1);
   frac(x1,y1,-w shl 1,len*tifl[t])
  end
 end;

begin
 inc(t);
 ast(x,y,w+120);
 ast(x,y,w);
 ast(x,y,w-120);
 dec(t);
end;

begin
 gd:=detect;
 initgraph(gd,gm,'');
 for i:=0 to 5 DO begin
  port[$3c8]:=i;
  port[$3c9]:=i*9;
  port[$3c9]:=i*12;
  port[$3c9]:=i*8;
 end;
 for i:=0 to 359 DO begin
  s[i]:=sin(i*pi/180);
  c[i]:=cos(i*pi/180);
  tifl[i]:=(i+1)/(i*2+1)
 end;
 maxtif:=4;
 repeat
  inc(i);
  t:=0;
  asm
   mov ax,$a000;mov es,ax
   mov di,80*104;mov cx,80*70
   mov dx,$3da
   @1:in al,dx;test al,8;jz @1
   @2:in al,dx;test al,8;jnz @2
   db $66;xor ax,ax
   db $66;rep stosw
  end;
  frac (320,240,i,60);
 until port[$60]=1;
 closegraph;
end.