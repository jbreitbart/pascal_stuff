
procedure Kreisnaherkommen;
var color,radius,xmittelpunkt,ymittelpunkt,x, y,sonnex,sonney: integer;
    winkel, xekreis, yekreis, xkreis, ykreis,swinkel   : real;
    lv1,sonnelv,zaehler : Laufvar;
    a,b :array [0..100] of word;
    rot,geschwindig : array[0..100] of byte;
    farbe : byte;
    ende : Word;
    planetx, planety: Integer;
    x1,y1,z1,bildx,bildy,xalt,yalt: array [1..100] of Integer;
    min,max : word;
    lange : Laufvar;

begin
 for lv1 := 1 to 100 DO begin
  x1[lv1]:=Zufall(1,640);
  y1[lv1]:=Zufall(1,480);
  z1[lv1]:=Zufall(20,512);
 end;
 lange:=0;
 For lv1 := 1 to 100 DO begin
  zaehler:=0;
  max:=512;
  min:=max-39;
 end;
 repeat
  if keypressed then taste:=readkey;
  if taste=Escape then exit;
  for lv1:= 1 to 100 DO begin
   bildx[lv1]:=((x1[lv1] shl 8) div z1[lv1])+320;
   bildy[lv1]:=((y1[lv1] shl 8) div z1[lv1])+240;
  end;
  for lv1:= 1 to 100 DO putpixel(bildx[lv1],bildy[lv1],white);
  for lv1:= 1 to 100 DO begin
   xalt[lv1]:=bildx[lv1];
   yalt[lv1]:=bildy[lv1];
  end;
  delay(30);
  for lv1:= 1 to 100 DO begin
   if z1[lv1]<=1 then begin
    x1[lv1]:=Zufall(1,640);
    y1[lv1]:=Zufall(1,480);
    z1[lv1]:=512;
   end;
   dec(Z1[lv1],1);
   zaehler:=0;
   max:=512;
   min:=max-39;
  end;
  for lv1 := 1 to 100 DO putpixel(xalt[lv1],yalt[lv1],black);
  lange:=lange+1
 until lange=3000;
 lange:=0;
 cleardevice;
 repeat
  for lv1:= 1 to 100 DO begin
   bildx[lv1]:=((x1[lv1] shl 8) div z1[lv1])+320;
   bildy[lv1]:=((y1[lv1] shl 8) div z1[lv1])+240;
  end;
  if keypressed then taste:=readkey;
  if taste=Escape then exit;
  for lv1:= 1 to 100 DO putpixel(bildx[lv1],bildy[lv1],white);
  for lv1:= 1 to 100 DO begin
   xalt[lv1]:=bildx[lv1];
   yalt[lv1]:=bildy[lv1];
  end;
  delay(30);
  for lv1:= 1 to 100 DO begin
   if z1[lv1]<=1 then begin
    x1[lv1]:=Zufall(1,640);
    y1[lv1]:=Zufall(1,480);
    z1[lv1]:=512;
   end;
   dec(Z1[lv1],1);
   zaehler:=0;
   max:=512;
   min:=max-39;
  end;
  lange:=lange+1
 until lange = 3000;
 cleardevice;
 for lv1:= 0 to 400 DO putpixel(Random(640),Random(480),white);
 ende:=0;
 sonney:=120;
 sonnex:=0;
 planety:=240;
 planetx:=320-500;
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

procedure Kreisnaherkommen;
var color,radius,xmittelpunkt,ymittelpunkt,x, y,sonnex,sonney: integer;
    winkel, xekreis, yekreis, xkreis, ykreis,swinkel   : real;
    lv1,lv2,sonnelv,zaehler,lange : Laufvar;
    x1,y1,z1,xalt,yalt: array [0..40] of Integer;
    bildx,bildy : Array [0..40] of array [0..15] of Integer;

begin
 for lv1 := 0 to 40 DO begin
  x1[lv1]:=Zufall(1,640);
  y1[lv1]:=Zufall(1,480);
  z1[lv1]:=Zufall(20,512);
 end;
 lange:=0;
 repeat
  if keypressed then taste:=readkey;
  if taste=Escape then exit;
  for lv1:= 0 to 40 DO begin
   bildx[lv1][1]:=((x1[lv1] shl 8) div z1[lv1])+320;
   bildy[lv1][1]:=((y1[lv1] shl 8) div z1[lv1])+240;
  end;
  for lv1:= 0 to 40 DO putpixel(bildx[lv1][1],bildy[lv1][1],white);
  for lv1:= 0 to 40 DO begin
   xalt[lv1]:=bildx[lv1][1];
   yalt[lv1]:=bildy[lv1][1];
  end;
  delay(30);
  for lv1:= 0 to 40 DO begin
   if z1[lv1]<=1 then begin
    x1[lv1]:=Zufall(1,640);
    y1[lv1]:=Zufall(1,480);
    z1[lv1]:=512;
   end;
   dec(Z1[lv1],1);
  end;
  for lv1 := 0 to 40 DO putpixel(xalt[lv1],yalt[lv1],black);
  lange:=lange+1
 until lange=3000;
 lange:=0;
 cleardevice;
 repeat
  if keypressed then taste:=readkey;
  if taste=Escape then exit;
  for lv2:=0 to 40 DO begin
   for lv1:=0 to 15 DO begin
    bildx[lv2][lv1]:=((x1[lv2] shl 8) div (z1[lv2]+(lv1*2)))+320;
    bildy[lv2][lv1]:=((y1[lv2] shl 8) div (z1[lv2]+(lv1*2)))+240;
   end;
  end;
  for lv2:=0 to 40 DO begin
   for lv1:=0 to 15 DO putpixel(bildx[lv2][lv1],bildy[lv2][lv1],white);
  end;
  for lv2:=0 to 40 DO begin
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
  for lv2:=0 to 40 DO begin
   for lv1:=0 to 15 DO begin
    bildx[lv2][lv1]:=((x1[lv2] shl 8) div (z1[lv2]+(lv1*2)))+320;
    bildy[lv2][lv1]:=((y1[lv2] shl 8) div (z1[lv2]+(lv1*2)))+240;
   end;
  end;
  lange:=lange+1;
  for lv2:=0 to 40 DO putpixel(xalt[lv2],yalt[lv2],black);
 until lange = 3000;
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
