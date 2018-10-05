program Kreis_zeichnen;

uses crt, graph;
var treiber, modus, xmittelpunkt,
    ymittelpunkt, xradius, yradius, x, y                 : integer;
    winkel, xekreis, yekreis, xkreis, ykreis   : real;

begin
 treiber:=detect; modus:=0;
 initgraph(Treiber,Modus,'');
 xmittelpunkt:=150;
 ymittelpunkt:=240;
 radius:=50;
 winkel:=0;
 while winkel < 2*pi do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis*2;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,13);
   winkel:=winkel+0.01;
  end;
 xmittelpunkt:=0;
 ymittelpunkt:=240;
 radius:=20;
 winkel:=0;
 while winkel < 2*pi do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis*2;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,13);
   winkel:=winkel+0.01;
  end;
  readln;
  closegraph
end.