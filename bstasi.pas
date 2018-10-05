program Battle_STASI;

uses alles,graph,crt;

var Spielf : Array [1..38,1..24] of byte;

procedure init;

var x,y,xpos,ypos : Word;
    lv1 : Laufvar;

begin
 RANDOMIZE;
 for x:= 1 to 38 DO
 for y:= 1 to 24 DO spielf[x,y]:=0;
 lv1:=0;
 repeat
  x:=RANDOM(35)+2;
  y:=RANDOM(22)+1;
  if spielf[x,y]=0 then begin
                         spielf[x,y]:=1;
                         lv1:=lv1+1;
                        end;
 until lv1=10;
 setcolor(darkgray);
 setpalette(lightgreen,2);
 setfillstyle(1,lightgreen);
 bar(40,50,610,410);
 x:=40;
 y:=50;
 repeat
  line(x,y,610,y);
  y:=y+15;
 until (y>=415);
 y:=50;
 x:=40;
 repeat
  line(x,y,x,410);
  x:=x+15;
 until (x=625);
 setpalette(white,7);
 x:=1;
 xpos:=41;
 ypos:=51;
 y:=1;
 repeat
  repeat
   if spielf[x,y]=1 then begin
                          setcolor(red);
                          line(xpos,ypos,xpos+13,ypos+13);
                          line(xpos+13,ypos,xpos,ypos+13);
                         end;
   x:=x+1;
   xpos:=xpos+15;
  until (x=39);
  x:=1;
  xpos:=41;
  ypos:=ypos+15;
  y:=y+1;
 until (y=24);
 mouseshow;
end;

begin
 mouseinit;
 grd:=detect;
 initgraph(grd,grm,'');
 init;
 readln;
 closegraph;
end.

SPIELFELD

0   =  Leer
1   =  Hinderniss