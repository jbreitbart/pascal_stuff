Program Pyramide;

uses crt,graph;

var grdriver,grmodus,spitzex,spitzey,x,y:Integer;
    winkel : Real;

procedure ell;

var xmittelpunkt,ymittelpunkt, xradius,yradius: integer;

begin
 xmittelpunkt:=320;
 ymittelpunkt:=340;
{ winkel:=0;}
 xradius:=200;
 yradius:=50;
 randomize;
{ repeat}
  x:=round(xmittelpunkt+xradius*cos(winkel));
  y:=round(ymittelpunkt-yradius*sin(winkel));
{ putpixel(x,y,color);
  line(spitzex,spitzey,x,y);
  delay(100);}
  winkel:=winkel+0.01;
{ until winkel= 2 * pi;}
end;

begin
 winkel:=0;
 grdriver:=Detect;
 initgraph(grdriver,grmodus,'');
 spitzex:=round(getmaxx/2);
 spitzey:=15;
 putpixel(spitzex,spitzey,white);
 repeat
  cleardevice;
  ell;
  line(spitzex,spitzey,x,y);
  delay (200);
 until keypressed;
 readln;
 closegraph;
end.