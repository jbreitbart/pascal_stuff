uses alles,graph,crt;
var a,b,si : Real;
    x,y : Word;

begin
 grd:=detect;
 initgraph(grd,grm,'');
 for x:= 0 to 640 do
  for x:=0 to 640 DO begin
   a:=x*8*pi/640;
   a:=sin(a);
   y:=round(100-60*a);
   putpixel(x,y,white);
   b:=x*10*pi/640;
   b:=sin(b);
   y:=round(230-45*b);
   putpixel(x,y,lightred);
   a:=a+b;
   si:=sin(a);
   y:=round(300-100*a);
   putpixel(x,y,lightblue);
   sound(y*y);
   delay(100);
   nosound;
  end;
 waitkey;
 closegraph;
end.