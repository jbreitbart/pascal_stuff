program Apollo;

uses crt, graph;

const wart=100;

var treiber, modus, xmittelpunkt,
    ymittelpunkt, xradius, yradius, x, y                 : integer;
    winkel, xekreis, yekreis, xkreis, ykreis   : real;
    color:byte;

begin
 treiber:=detect; modus:=0;
 initgraph(Treiber,Modus,'');
 color:=1;
 repeat
  xmittelpunkt:=350;
  ymittelpunkt:=240;
  xradius:=300;
  yradius:=50;
  winkel:=1/2*pi;
  while winkel < pi+1/2*pi do
   begin
    xekreis:=cos(winkel);
    yekreis:=sin(2*winkel);
    xkreis:=xradius*xekreis;
    ykreis:=yradius*yekreis;
    x:=round(xmittelpunkt + xkreis);
    y:=round(ymittelpunkt - ykreis);
    putpixel(x,y,color);
    winkel:=winkel+0.001;
    if keypressed then begin
     closegraph;
     halt;
    end;
    delay(wart);
   end;
  xradius:=100;
  yradius:=20;
  winkel:=pi+1/2*pi;
  while winkel < 2*pi do
   begin
    xekreis:=cos(winkel);
    yekreis:=sin(2*winkel);
    xkreis:=xradius*xekreis;
    ykreis:=yradius*yekreis;
    x:=round(xmittelpunkt + xkreis);
    y:=round(ymittelpunkt - ykreis);
    putpixel(x,y,color);
    winkel:=winkel+0.001;
    if keypressed then begin
     closegraph;
     halt;
    end;
    delay(wart);
   end;
  winkel:=0;
  while winkel < 1/2*pi do
   begin
    xekreis:=cos(winkel);
    yekreis:=sin(2*winkel);
    xkreis:=xradius*xekreis;
    ykreis:=yradius*yekreis;
    x:=round(xmittelpunkt + xkreis);
    y:=round(ymittelpunkt - ykreis);
    putpixel(x,y,color);
    winkel:=winkel+0.001;
    delay(wart);
    if keypressed then begin
     closegraph;
     halt;
    end;
   end;
  color:=color+1;
  if color=16 then color:=0;
 until keypressed;
 closegraph
end.