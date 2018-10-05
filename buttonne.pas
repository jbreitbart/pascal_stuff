uses crt,alles,graph;

var grd, grm: Integer;

procedure button (x1,y1,x2,y2 : word);
var lv1,lv2 : Laufvar;
begin
 for lv1:= x1 to x2 DO putpixel (lv1,y1,white);
 for lv1:= y1 to y2 DO putpixel(x1,lv1,white);
 for lv1:= x1 to x2 DO putpixel(lv1,y2,darkgray);
 for lv1:= y1 to y2 DO putpixel(x2,lv1,darkgray);
 for lv1:= x1+1 to x2-1 DO
 for lv2:= y1+1 to y2-1 DO putpixel(lv1,lv2,lightgray);
end;

begin
 grd:=DETECT;
 initgraph(grd,grm,'');
 delay(40);
 button(10,10,100,50);
 readln;
 closegraph;
end.