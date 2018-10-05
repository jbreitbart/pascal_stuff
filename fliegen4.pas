program fliegen;

uses crt, graph,alles;

var bildx,bildy: array [0..40] of array [0..15] of Integer;
    x,y,z,xalt,yalt : array [0..40] of Integer;
    lv1,lv2 : Laufvar;

begin
 grd:=Detect;
 initgraph(grd,grm,'');
 Randomize;
 for lv2:=0 to 40 DO begin
  x[lv2]:=Zufall(1,640);
  y[lv2]:=Zufall(1,480);
  z[lv2]:=Zufall(20,512);
 end;
 for lv2:=0 to 40 DO begin
  for lv1:=0 to 15 DO begin
   bildx[lv2][lv1]:=((x[lv2] shl 8) div (z[lv2]+(lv1*2)))+320;
   bildy[lv2][lv1]:=((y[lv2] shl 8) div (z[lv2]+(lv1*2)))+240;
  end;
 end;
 repeat
  for lv2:=0 to 40 DO begin
   for lv1:=0 to 15 DO putpixel(bildx[lv2][lv1],bildy[lv2][lv1],white);
  end;
  for lv2:=0 to 40 DO begin
   xalt[lv2]:=bildx[lv2][15];
   yalt[lv2]:=bildy[lv2][15];
   dec(z[lv2],2);
   if z[lv2]<=17 then begin
    x[lv2]:=Zufall(1,640);
    y[lv2]:=Zufall(1,480);
    z[lv2]:=512;
    for lv1:=0 to 15 DO putpixel(bildx[lv2][lv1],bildy[lv2][lv1],black);
   end;
  end;
  for lv2:=0 to 40 DO begin
   for lv1:=0 to 15 DO begin
    bildx[lv2][lv1]:=((x[lv2] shl 8) div (z[lv2]+(lv1*2)))+320;
    bildy[lv2][lv1]:=((y[lv2] shl 8) div (z[lv2]+(lv1*2)))+240;
   end;
  end;
  for lv2:=0 to 40 DO putpixel(xalt[lv2],yalt[lv2],black);
 until port[$60] = 1;
 closegraph
end.