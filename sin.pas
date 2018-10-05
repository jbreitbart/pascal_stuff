uses alles,graph;
var a : Real;
    x,y : Word;
begin
 grd:=detect;
 initgraph(grd,grm,'');
 for x:=0 to 640 DO begin
  a:=x*2*pi/640;
  a:=sin(a);
  y:=round(240-200*a);
  putpixel(x,y,white);
 end;
 waitkey;
 closegraph;
end.