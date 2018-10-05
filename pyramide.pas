Program Pyramide;

uses crt,graph;

var grdriver,grmodus,spitzex,spitzey,x1,x2,x3,x4,y1,y2,y3,y4:Integer;
    winkel1,winkel2,winkel3,winkel4: real;

procedure ell(a:Integer);

var xmittelpunkt,ymittelpunkt, xradius,yradius : integer;

begin
 xmittelpunkt:=320;
 ymittelpunkt:=340;
 xradius:=200;
 yradius:=50;
 if a = 1 then Begin
                winkel1:=winkel1-0.01;
                x1:=round(xmittelpunkt+xradius*cos(winkel1));
                y1:=round(ymittelpunkt-yradius*sin(winkel1));
                line(spitzex,spitzey,x1,y1);
               end;
 if a = 2 then Begin
                winkel2:=winkel2-0.01;
                x2:=round(xmittelpunkt+xradius*cos(winkel2));
                y2:=round(ymittelpunkt-yradius*sin(winkel2));
                line(spitzex,spitzey,x2,y2);
               end;
 if a = 3 then Begin
                 winkel3:=winkel3-0.01;
                 x3:=round(xmittelpunkt+xradius*cos(winkel3));
                 y3:=round(ymittelpunkt-yradius*sin(winkel3));
                 line(spitzex,spitzey,x3,y3);
                end;
 if a = 4 then Begin
                winkel4:=winkel4-0.01;
                x4:=round(xmittelpunkt+xradius*cos(winkel4));
                y4:=round(ymittelpunkt-yradius*sin(winkel4));
                line(spitzex,spitzey,x4,y4);
               end;
end;

begin
 winkel2:=1.25*pi;
 winkel3:=1.75*pi;
 winkel1:=pi/4*3;
 winkel4:=0.25*pi;
 x1:=0;
 x2:=0;
 x3:=0;
 x4:=0;
 y1:=0;
 y2:=0;
 y3:=0;
 y4:=0;
 grdriver:=InstallUserDriver('vesa',NIL);
 grmodus:=2;
 initgraph(grdriver,grmodus,'');
 spitzex:=round(getmaxx/2);
 spitzey:=15;
 randomize;
 repeat
  setactivepage(0);
  cleardevice;
  ell(1);
  ell(2);
  ell(3);
  ell(4);
  setcolor(white);
  line(x1,y1,x2,y2);
  line(x1,y1,x4,y4);
  line(x2,y2,x3,y3);
  line(x3,y3,x4,y4);
  delay(300);
  setvisualpage(0);
  setactivepage(1);
  cleardevice;
  ell(1);
  ell(2);
  ell(3);
  ell(4);
  setcolor(white);
  line(x1,y1,x2,y2);
  line(x1,y1,x4,y4);
  line(x2,y2,x3,y3);
  line(x3,y3,x4,y4);
  delay(300);
  setvisualpage(1);
  setactivepage(2);
  cleardevice;
  ell(1);
  ell(2);
  ell(3);
  ell(4);
  setcolor(white);
  line(x1,y1,x2,y2);
  line(x1,y1,x4,y4);
  line(x2,y2,x3,y3);
  line(x3,y3,x4,y4);
  delay(300);
  setvisualpage(2);
  setactivepage(3);
  cleardevice;
  ell(1);
  ell(2);
  ell(3);
  ell(4);
  setcolor(white);
  line(x1,y1,x2,y2);
  line(x1,y1,x4,y4);
  line(x2,y2,x3,y3);
  line(x3,y3,x4,y4);
  delay(300);
  setvisualpage(3);
 until keypressed;
 closegraph;
end.