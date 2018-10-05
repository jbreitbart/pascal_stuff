uses alles,graph;
var a,hohe,winkel,geschwin,g : Real;
    x,y,weit : Integer;
begin
 write('Anfangswinkel : ');
 readln(winkel);
 write('Geschwindigkeit : ');
 readln(geschwin);
 write('Gravitation : ');
 readln(g);
 grd:=detect;
 initgraph(grd,grm,'');
 weit:=0;
 x:=0;
 closegraph;
 repeat
  hohe:=(weit * (sin(winkel)/cos(winkel)) - (g*sqr(x))) / (2*sqr(geschwin)*sqr(cos(winkel)));
  writeln(hohe:8:2);
  waitkey;
  y:=round(479-hohe/10);
  x:=round(weit/10);
  weit:=weit+10;
 until (hohe=0) and (x<>0);
 waitkey;
 closegraph;
end.
y:=x arctan @ - g*xý / 2*anfanggeschwiný*cos(@)ý