uses alles,crt,graph;

var x,d,y :Word;

begin
 grd:=installuserdriver('svga256',nil);
 grm:=2;
 initgraph(grd,grm,'');
 y:=20;
 for x:=1 to 84 DO begin
  setfillstyle(1,x);
  bar(y,0,y+1,getmaxy);
  setfillstyle(1,x+85);
  bar(y+200,0,y+201,getmaxy);
  setfillstyle(1,x+85*2);
  bar (y+400,0,y+401,getmaxy);
  y:=y+2;
 end;
 d:=0;
 repeat
  for x:=1 to 84 DO begin
   setrgbpalette(x,0,round(x/85*65)+d,0);
   setrgbpalette(x+85,round(x/85*65)+d,0,0);
   setrgbpalette(x+85*2,0,0,round(x/85*65)+d);
  end;
  d:=d+3;
 until keypressed;
 waitkey;
end.