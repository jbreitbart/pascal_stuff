Unit RiseTpu;

interface

uses crt,graph,dos,alles;

var Name,Planet,akverz:String;

procedure Titelbild;
procedure ladenmip(s : Dateiname;was : Byte);
Procedure Sterneb;
Procedure Ray;
Procedure Nameeingeben;
Procedure Planetenname;

IMPLEMENTATION

type Pbild=^TBild;
     TBild = record
              n : Pointer;
              i : array [0..639] of byte;
             end;

Procedure Planetenname;
var a : word;

begin
 cleardevice;
 ladenmip('Planet',1);
 ladenmip('Planet',2);
 for a:= 1 to 250 do Putpixel (random (640),random (240),white);
 setcolor(9);
 settextstyle(2,0,6);
 Outtextxy (10,30,'Neuer Planetenname :');
 readtext3d (204,30,planet);
end;

Procedure Nameeingeben;
Var a,b:integer;

Begin
 mousehide;
 cleardevice;
 Rectangle (0,0,getmaxx,getmaxy);
 settextstyle (2,0,10);
 setfillstyle (0,0);
 ray;
 bar (1,190+20,638,250+20);
 Outtextxy (10,200+20,'Name :');
 setcolor(red);
 Readtext3dsound (150,200+20,name);
 for a:=0 to 640 do
 for b:=0 to 480 do begin
 putpixel (a,b,red);
 end;
 delay (2);
 for a:=0 to 640 do
 for b:=0 to 480 do begin
 putpixel (a,b,black);
 end;
 cleardevice ;
 setcolor (9);
 Outtextxy (100,100,'Vielen Dank');
 Outtextxy (10,150,'Willkommen auf der Kolonie');
 delay (30000);
end;

Procedure Ray;
var a,b,b1 : Integer;

begin
 Randomize;
 for b:= 1 to 200 do begin
  setbkcolor (random (10));
  sound(random(40));
  delay (2);
  setcolor (9);
  delay (1);
 end;
 nosound;
 setbkcolor (black);
 Line (50,0,50,480);
 Line (590,0,590,480);
 Line (0,50,640,50);
 Line (0,430,640,430);
 delay (5000);
 setcolor (9);
 circle (110,380,50);
 sound (150);
 delay (200);
 nosound;
 delay (5000);
 circle (110,380,40);
 sound (150);
 delay (200);
 nosound;
 delay (5000);
 line (110,380,110,330);
 sound (100);
 delay (200);
 nosound;
 delay (5000);
 line (110,380,110,430);
 sound (100);
 delay (200);
 nosound;
 delay (5000);
 line (110,380,60,380);
 sound (100);
 delay (200);
 nosound;
 delay (5000);
 line (110,380,160,380);
 sound (100);
 delay (200);
 nosound;
 delay (5000);
 settextstyle (2,0,10);
 Randomize;
 For a:= 0 to 140 do begin
  setpalette(brown,RANDOM(65));
  setcolor (brown);
  outtextxy (a,100,'Identifizierung');
  delay (200);
  setcolor (black);
  outtextxy (a,100,'Identifizierung');
  setcolor (9);
  Line (50,0,50,480);
  if a<10 then line(0,0,0,480)
 end;
 setcolor (9);
 Outtextxy (140,100,'Identifizierung');
 for b1:=1 to 3 do begin
   for b:= 140 to 480 do begin
   putpixel (b,150,9);
   delay (10);
  end;
 for b:= 140 to 480 do begin
   putpixel (b,150,black);
   delay (10);
  end;
 end;
 for b:= 140 to 480 do begin
  putpixel (b,150,9);
 end;
 for b:= 1 to 2 do begin
  for b1:= 0 to 50  do
  for a:= 50 to 430 do
  putpixel (b1,a,red);
  for b1:= 0 to 50 do
  for a:= 50 to 430 do
  putpixel (b1,a,black);
  for b1:=640 downto 590 do
  for a:= 50 to 430 do
  putpixel (b1,a,red);
  for b1:=640 downto 590 do
  for a:= 50 to 430 do
  putpixel (b1,a,black);
 end;
 setcolor (9);
 rectangle (0,0,getmaxx,getmaxy);
 rectangle (0,50,640,430);
end;

Procedure Sterneb;
Var Lv1:byte;
Begin
 for lv1 := 1 to 15 do putpixel (random(640),random(480),red);
 for lv1 := 1 to 15 do putpixel (random(640),random(480),cyan);
end;

procedure ladenmip(s : Dateiname; was : Byte);

var Bild,wurzel : PBild;
    f : File;
    v : Pointer;

procedure aladen;
begin
 assign(f,akverz+'\data\'+s+'.mip');
 reset(f,1);
 bild:=nil;
 wurzel:=nil;
 repeat
  new(bild);
  blockread(f,bild^.i,sizeof(bild^.i));
  bild^.n:=Wurzel;
  wurzel:=bild;
 until eof(f);
 close(f);
end;

procedure bildladen;
var a,b : Word;
begin
 bild:=wurzel;
 b:=getmaxy;
 a:=0;
 WHILE bild<>nil DO begin
  for a:=getmaxx downto 0 DO putpixel(a,b,bild^.i[a]);
  b:=b-1;
  if bild^.n <> nil then dispose(bild);
  bild:=bild^.n;
 end;
end;

begin
 if was =1 then aladen;
 if was =2 then bildladen;
end;

procedure Titelbild;

var Sterne : Laufvar;
    taste : char;

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
 kreisnaherkommen;
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(150,5,'Rising Earth');
  delay(sterne*200);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(150,5,'Rising Earth');
  end;
 end;
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(420,5,' I');
  delay(sterne*200);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(420,5,' I');
  end;
 end;
 delay (10000);
 for sterne:=1 to 8 Do begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(220,50,'The Begining');
  delay(sterne*200);
  if sterne <> 8 then begin
   setcolor(black);
   outtextxy(220,50,'The Begining');
  end;
 end;
 delay(30000);
 cleardevice;
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(250,200,' by');
  delay(sterne*200);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(250,200,' by');
  end;
 end;
 delay (30000);
 cleardevice;
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(80,200,'Jensman and Benflash');
  delay(sterne*200);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(80,200,'Jensman and Benflash');
  end;
 end;
 delay (30000);
 cleardevice;
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(80,200,' Programed in 1997');
  delay(sterne*200);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(80,200,' Programed in 1997');
  end;
 end;
 delay (30000);
 cleardevice;
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
    setcolor(9);
  outtextxy(200,200,'in Germany');
  delay(sterne*200);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(200,200,'in Germany');
  end;
 end;
 delay (30000);
 cleardevice;
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(170,200,'(c)`Stupid Two');
  delay(sterne*200);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(170,200,'(c)`Stupid Two');
  end;
  end;
 delay(20000);
 cleardevice;
end;

end.