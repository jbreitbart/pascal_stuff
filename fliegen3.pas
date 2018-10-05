program fliegen;

uses crt, graph,alles;

var x,y,z,bildx,bildy,xalt,yalt: array [1..100] of Integer;
    color : array [1..100] of byte;
    min,max : word;
    lv1,zaehler,farbe : Laufvar;
    taste : char;
    geschwindigkeit : word;

begin
 grd:=INSTALLUSERDRIVER('vesa',nil);
 grm:=2;
 initgraph(grd,grm,'');
 Randomize;
 for lv1 := 1 to 100 DO begin
  x[lv1]:=Zufall(1,640);
  y[lv1]:=Zufall(1,480);
  z[lv1]:=Zufall(20,512);
 end;
 geschwindigkeit:=2;
 For lv1 := 1 to 100 DO begin
  zaehler:=0;
  max:=512;
  min:=max-39;
  farbe:=18;
  repeat
   if (z[lv1]<=max) and (z[lv1]>=min) then color[lv1]:=farbe;
   max:=max-39;
   min:=max-39;
   zaehler:=zaehler+1;
   farbe:=farbe+1;
  until farbe=32;
 end;
 repeat
  if keypressed then begin
   taste:=readkey;
   if (taste='+') and (geschwindigkeit<65000) then geschwindigkeit:=geschwindigkeit+1;
   if (taste='-') and (geschwindigkeit>0) then geschwindigkeit:=geschwindigkeit-1;
  end;
  for lv1:= 1 to 100 DO begin
   bildx[lv1]:=((x[lv1] shl 8) div z[lv1])+320;
   bildy[lv1]:=((y[lv1] shl 8) div z[lv1])+240;
  end;
  for lv1:= 1 to 100 DO putpixel(bildx[lv1],bildy[lv1],color[lv1]);
  for lv1:= 1 to 100 DO begin
   xalt[lv1]:=bildx[lv1];
   yalt[lv1]:=bildy[lv1];
  end;
  delay(50);
  for lv1:= 1 to 100 DO begin
   if z[lv1]<=geschwindigkeit then begin
    x[lv1]:=Zufall(1,640);
    y[lv1]:=Zufall(1,480);
    z[lv1]:=512;
   end;
   dec(Z[lv1],geschwindigkeit);
   zaehler:=0;
   max:=512;
   min:=max-39;
   farbe:=18;
   repeat
    if (z[lv1]<=max) and (z[lv1]>=min) then color[lv1]:=farbe;
    max:=max-39;
    min:=max-39;
    zaehler:=zaehler+1;
    farbe:=farbe+1;
   until farbe=32;
  end;
  for lv1 := 1 to 100 DO putpixel(xalt[lv1],yalt[lv1],black);
 until port[$60] = 1;
 closegraph
end.