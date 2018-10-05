program fliegen;
uses crt, graph,alles;
var taste: Char;

procedure Kreisnaherkommen;
var color,radius,xmittelpunkt,ymittelpunkt,x, y,sonnex,sonney: integer;
    winkel, xekreis, yekreis, xkreis, ykreis,swinkel   : real;
    lv1,lv2,sonnelv,zaehler,lange : Laufvar;
    x1,y1,z1,xalt,yalt: array [0..60] of Integer;
    bildx,bildy : Array [0..60] of array [0..15] of Integer;

begin
 for lv1 := 0 to 60 DO begin
  x1[lv1]:=Zufall(1,640);
  y1[lv1]:=Zufall(1,480);
  z1[lv1]:=Zufall(20,512);
 end;
 lange:=0;
 repeat
  if keypressed then taste:=readkey;
  if taste=Escape then exit;
  for lv1:= 0 to 60 DO begin
   bildx[lv1][1]:=((x1[lv1] shl 8) div z1[lv1])+320;
   bildy[lv1][1]:=((y1[lv1] shl 8) div z1[lv1])+240;
  end;
  for lv1:= 0 to 60 DO putpixel(bildx[lv1][1],bildy[lv1][1],white);
  for lv1:= 0 to 60 DO begin
   xalt[lv1]:=bildx[lv1][1];
   yalt[lv1]:=bildy[lv1][1];
  end;
  delay(30);
  for lv1:= 0 to 60 DO begin
   if z1[lv1]<=1 then begin
    x1[lv1]:=Zufall(1,640);
    y1[lv1]:=Zufall(1,480);
    z1[lv1]:=512;
   end;
   dec(Z1[lv1],1);
  end;
  for lv1 := 0 to 60 DO putpixel(xalt[lv1],yalt[lv1],black);
  lange:=lange+1
 until lange=3000;
 lange:=0;
 cleardevice;
 repeat
  if keypressed then taste:=readkey;
  if taste=Escape then exit;
  for lv2:=0 to 60 DO begin
   for lv1:=0 to 15 DO begin
    bildx[lv2][lv1]:=((x1[lv2] shl 8) div (z1[lv2]+(lv1*2)))+320;
    bildy[lv2][lv1]:=((y1[lv2] shl 8) div (z1[lv2]+(lv1*2)))+240;
   end;
  end;
  if lange=0 then begin
   for lv1:=0 to 15 DO begin
    for lv2:=0 to 60 DO putpixel(bildx[lv2][lv1],bildy[lv2][lv1],white);
    delay(500);
   end;
  end
  else begin
   for lv2:=0 to 60 DO putpixel(bildx[lv2][0],bildy[lv2][0],white);
  end;
  for lv2:=0 to 60 DO begin
   xalt[lv2]:=bildx[lv2][15];
   yalt[lv2]:=bildy[lv2][15];
   dec(z1[lv2],2);
   if z1[lv2]<=17 then begin
    x1[lv2]:=Zufall(1,640);
    y1[lv2]:=Zufall(1,480);
    z1[lv2]:=512;
    for lv1:=0 to 15 DO putpixel(bildx[lv2][lv1],bildy[lv2][lv1],black);
   end;
  end;
  for lv2:=0 to 60 DO begin
   for lv1:=0 to 15 DO begin
    bildx[lv2][lv1]:=((x1[lv2] shl 8) div (z1[lv2]+(lv1*2)))+320;
    bildy[lv2][lv1]:=((y1[lv2] shl 8) div (z1[lv2]+(lv1*2)))+240;
   end;
  end;
  lange:=lange+1;
  for lv2:=0 to 60 DO putpixel(xalt[lv2],yalt[lv2],black);
 until lange = 3000;
 For lv1:=15 downto 2 DO begin
  for lv2:=0 to 60 DO putpixel(bildx[lv2][lv1],bildy[lv2][lv1],black);
  delay(500);
 end;
 cleardevice;
 for lv1:= 0 to 400 DO putpixel(Random(640),Random(480),white);
 sonney:=120;
 sonnex:=0;
 xmittelpunkt:=320;
 ymittelpunkt:=240;
 radius:= 100;
 color:=lightgreen;
 winkel:=0;
 sonnelv:=0;
 zaehler:=0;
 FOR lv1:=0 to radius DO begin
 winkel:=0;
 swinkel:=0;
 while winkel < 2*pi do
  begin
   if keypressed then taste:=readkey;
   if taste=Escape then exit;
   xekreis:=cos(winkel);
   yekreis:=sin(winkel);
   xkreis:=lv1*xekreis;
   ykreis:=lv1*yekreis;
   x:=round(xmittelpunkt + xkreis);
   y:=round(ymittelpunkt - ykreis);
   sonnex:=round(500 + ((cos(winkel)*sonnelv)));
   sonney:=round(120 - ((sin(winkel)*sonnelv)));
   putpixel(sonnex,sonney,yellow);
   putpixel(x,y,color);
   winkel:=winkel+0.0048;
   if ((sonnelv/2) = round(sonnelv/2)) then swinkel:=swinkel+0.005;
  end;
  zaehler:=zaehler+1;
  if (zaehler/2) = round(zaehler/2) then sonnelv:=sonnelv+1;
  if lv1=0 then delay(10000);
 end;
end;

begin
 grd:=detect;
 initgraph(grd,grm,'');
 randomize;
 kreisnaherkommen;
 closegraph
end.