program Grafik02;
uses crt, graph;
var Treiber, Modus, x, y : integer;
    alpha                : real;
    Taste                : char;
begin
 Treiber:= detect;
 InitGraph(Treiber,Modus,'');
 alpha := 0;
 While alpha < 100 do
   begin
     x := 320 + round(318*cos(alpha));
     y := 240 - round(238*cos(0.98*alpha));
     PutPixel(x,y,14);
     alpha := alpha + 0.01
   end;
  Taste := Readkey;
 CloseGraph
end.
