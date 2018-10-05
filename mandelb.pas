{$R-}
uses alles,graph,crt;

const xb = -0.2375;
      yb = -0.8375;
      xf = 0.00003;
      yf = 0.00002;

var  x,y : Word;
     RK,IK : Real;
     xfac,yFAC: Real;
     farbe:byte;
     anzahl : Integer;

procedure interration;

var a,b,aneu : Real;
    lv1,c : Integer;

begin
 a:=0;
 b:=0;
 anzahl:=-1;
 repeat
  aneu:=a*a-b*b+RK;
  b:=2*a*b+IK;
  a:=aneu;
  anzahl:=anzahl+1;
 until ((a*a+b*b)>=4)or (anzahl=100);
{ farbe:=round(anzahl/getmaxcolor*100);}
 farbe:=round(anzahl/getmaxcolor*100+16);
end;

procedure koordinat;
var x,y : Real;
    xm,ym : Word;
begin
 xm:=0;
 x:=-2;
 y:=1;
 ym:=0;
 repeat
  x:=x+xfac;
  xm:=xm+1;
 until xm=mousexpos+1;
 repeat
  y:=y-yfac;
  ym:=ym+1;
 until ym=mouseypos+1;
 setfillstyle(1,0);
 bar(0,0,60,30);
 setcolor(red);
 outtextxy (0,0,realtostr(x));
 outtextxy (0,20,realtostr(y));
end;

var w,q,f : Word;

begin
 grm:=2;
 grd:=installuserdriver('vesa',nil);
{ grd:=detect;}
 initgraph(grd,grm,'');
 f:=0;
 q:=0;
 w:=0;
 repeat
  setrgbpalette(f,round(f/33*62),0,0);
  f:=f+1;
 until f=33;
 q:=33;
 repeat
  setrgbpalette(f,round(q/33*62),round((f-33)/33*62),0);
  q:=q-1;
  f:=f+1;
 until f=66;
 q:=33;
 repeat
  setrgbpalette(f,0,round(q/33*62),round((f-66)/33*62));
  q:=q-1;
  f:=f+1;
 until f=101;
 xfac:=xf/(getmaxx+1);
 yfac:=yf/(getmaxy+1);
 ik:=yb;
 rk:=xb;
 x:=0;
 y:=0;
 farbe:=0;
 repeat
  repeat
   interration;
   putpixel(x,y,farbe);
   RK:=RK+xfac;
   x:=x+1;
   if esc then halt;
  until x=640;
  rk:=xb;
  x:=0;
  IK:=IK-yfac;
  y:=y+1;
 until y=480;
 waitkey;
 w:=0;
 q:=0;
 RANDOMIZE;
 repeat
  setrgbpalette(w,ROUND(q),ROUND(w/100*62),ROUND(q/101*62));
  q:=q+1;
  w:=w+1;
  if q=16000 then q:=0;
  if w=101 then w:=0;
  delay(70);
 until keypressed;
end.

 RK:=-1.47;
 IK:=0.01;
 rk:=-0.2375;
 ik:=-0.8375;
 rk:=-0.55625;
 ik:=0.64167;
 rk:=-1.99067;
 ik:=0.98867;


 repeat
  setrgbpalette(f,round(f/33*62),0,0);
  f:=f+1;
 until f=33;
 q:=33;
 repeat
  setrgbpalette(f,round(q/33*62),round((f-33)/33*62),0);
  q:=q-1;
  f:=f+1;
 until f=66;
 q:=33;
 repeat
  setrgbpalette(f,0,round(q/33*62),round((f-66)/33*62));
  q:=q-1;
  f:=f+1;
 until f=101;
