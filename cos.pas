uses alles,crt,graph;

var a,alt,lv1 : Real;
    x     : Word;

begin
 grd:=detect;
 initgraph(grd,grm,'');
 line (9,239,609,239);
{ line (310,9,310,469);}
 lv1:=-1;
 x:=0;
 alt:=0;
 repeat
  a:=cos(lv1);
{  line(x,round(239-(a*230)),x-1,Round(239-(alt*230)));}
  putpixel(x,round(239-(a*230)),white);
  x:=x+1;
  lv1:=lv1+(1/3)/100;
  alt:=a;
 until lv1>=1;
 readln;
 closegraph;
end.