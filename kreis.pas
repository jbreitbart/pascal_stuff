program Kreis_zeichnen;

uses crt, graph, alles;

var treiber, modus, xmittelpunkt,
    ymittelpunkt, radius, x, y, color, color1, color2, color3 : integer;
    winkel, xekreis, yekreis, xkreis, ykreis   : real;

begin
 treiber:=InstallUserDriver('SVGA256',NIL);
 modus:=2;
 initgraph(treiber,modus,'');
 xmittelpunkt:=round (getmaxx / 2);
 ymittelpunkt:=round (getmaxy / 2);
 randomize;
 color:=1;
 color2:=200;
 radius:= 1;
 repeat
  if radius <= 1 then
  Begin
  repeat
  color3:=color2;
  color1:=color;
  color:= Random(256);
  color2:=random(256);
  winkel:=0;
 while winkel < pi/2 do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,color);
   winkel:=winkel+0.001;
   end;
  while winkel < pi do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,color1);
   winkel:=winkel+0.001;
   end;
  while winkel < pi/2*3 do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,color2);
   winkel:=winkel+0.001;
   end;
  while winkel < 2*pi do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,color3);
   winkel:=winkel+0.001;
   end;
  radius:=radius+3;
  until (radius >=400) or keypressed;
  if radius >=400 then
  repeat
  Begin
  color3:=0;
  color1:=0;
  color:=0;
  color2:=0;
  winkel:=0;
  while winkel < pi/2 do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,color);
   winkel:=winkel+0.001;
  end;
  while winkel < pi do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,color1);
   winkel:=winkel+0.001;
   end;
  while winkel < pi/2*3 do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,color2);
   winkel:=winkel+0.001;
   end;
  while winkel < 2*pi do
  begin
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=radius*xekreis;
   ykreis:=radius*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   putpixel(x,y,color3);
   winkel:=winkel+0.001;
   end;
   radius:= radius - 3;
  end;
  until (radius<=1) or keypressed;
  end;
  until keypressed;
  closegraph
end.