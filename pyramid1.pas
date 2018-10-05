Program Pyramide;

uses crt,graph;

var grdriver,grmodus,spitzex,spitzey:Integer;

procedure ell;

var treiber, modus, xmittelpunkt,
    ymittelpunkt, xradius,yradius, x, y          : integer;
    s : string;
    color : byte;
    winkel,a,winkelcos : real;

begin
 xmittelpunkt:=320;
 ymittelpunkt:=340;
 winkel:=0;
 color:=1;
 xradius:=200;
 yradius:=50;
 randomize;
 repeat
 setcolor(random(16));
 winkel:=0;
 repeat
  x:=round(xmittelpunkt+xradius*cos(winkel));
  y:=round(ymittelpunkt-yradius*sin(winkel));
  putpixel(x,y,color);
  line(spitzex,spitzey,x,y);
  delay(100);
  winkel:=winkel+0.01;
 until winkel >= 2 * Pi;
 until keypressed;
end;

begin
 grdriver:=Detect;
 initgraph(grdriver,grmodus,'');
 spitzex:=round(getmaxx/2);
 spitzey:=15;
 putpixel(spitzex,spitzey,white);
 ell;
 readln;
 closegraph;
end.