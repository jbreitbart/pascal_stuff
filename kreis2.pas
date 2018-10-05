program Kreis_zeichnen;

uses crt, graph;

var treiber, modus : Integer;

procedure dingsda;

var ymittelpunkt,color, radius, x, y, xmittelpunkt : integer;
    winkel, xekreis, yekreis, xkreis, ykreis   : real;
begin
 xmittelpunkt:=round (getmaxx / 2);
 ymittelpunkt:=round (getmaxy / 2);
 radius:= 100;
 color:=0;
 repeat
 winkel:=0;
 color := color +1;
 while winkel < 2*pi do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,color);
   winkel:=winkel+0.01;
  end;
 until keypressed;
end;

Begin
 treiber:= Detect;
 initgraph(Treiber,Modus,'');
 dingsda;
 closegraph;
end.