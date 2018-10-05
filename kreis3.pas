program Kreis_zeichnen;

uses crt, graph;
var treiber, modus, xmittelpunkt,
    ymittelpunkt, radius, x, y                 : integer;
    winkel, xekreis, yekreis, xkreis, ykreis   : real;

begin
 treiber:=detect; modus:=0;
 initgraph(Treiber,Modus,'');
 xmittelpunkt:=300;
 ymittelpunkt:=175;
 radius:=100;
 winkel:=0;
 while winkel < 2*pi do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,13);
   winkel:=winkel+0.01
  end;
  readln;
  closegraph
end.