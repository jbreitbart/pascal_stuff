{$A-,B-,D+,E+,F-,G+,I+,L+,N+,O-,R+,S+,V+,X-}
{$M 16384,0,655360}
Program Rising_Earth;

uses crt,alles,graph,risetpu,sbapi;

var Jahr                             : 2643..6001;
    monat                            : 1..12;

Procedure Spiel;

procedure hauptspiel;

procedure menu;
var lv1 : Laufvar;
    x,y,xalt,yalt : array [0..100] of word;
    rot, geschwindig : array [0..100] of byte;
    statistik,laden,speichern,schus,kauf,verkaufe,new,mili,forsch,kolonie,bau,zug : Boolean;
    mx, my,punktx, punkty : word;
    color,mousefarbe : Byte;
    pal : Byte;

procedure Statisktik;
var lv1 : Laufvar;
begin
 mousehide;
 cleardevice;
 delay(100);
 sterneb;
 for lv1:= 1 to 600 DO putpixel(Random(640),random(480),white);
 button (1,1,102,30);
 setcolor(white);
 settextstyle(2,0,4);
 outtextxy(3,10,'Geld');
 outtextxy(30,10,inttostr(geld));
 outtextxy(90,10,'ND');
 Button (112,1,213,30);
 setcolor (white);
 outtextxy (115,10,'Jahr');
 outtextxy (155,10,inttostr(jahr));
 mouseshow;
 waitkey;
 menu;
end;

Procedure Militar;
begin
 mousehide;
 cleardevice;
 anders:=true;
 mouseshow;
end;

Procedure News;
var wb,eb,fb,ab,zb : Boolean;

begin
 wb:=true;
 eb:=true;
 fb:=true;
 ab:=true;
 zb:=true;
 mousehide;
 cleardevice;
 setallpalette(grundpalette);
 setcolor(9);
 Rectangle (0,0,getmaxx,getmaxy);
 setcolor (white);
 Buttonschrift (20,110,120,140,'Wetter');
 Buttonschrift (20,170,120,200,'Erde');
 Buttonschrift (20,230,120,260,'Forschung');
 Buttonschrift (20,290,120,320,'Annoncen');
 buttonschrift (20,420,120,450,'Zurck');
 setcolor (9);
 Rectangle (150,20,600,450);
 mouseshow;
 repeat
  if (mouseinwindow(20,420,120,450)) and (zb=true) then begin
   setcolor(darkgray);
   mousehide;
   ubuttonschrift(20,420,120,450,'Zurck');
   mouseshow;
   zb:=false;
  end;
  if NOT((mouseinwindow(20,420,120,450))) and (zb=false) then begin
   setcolor(white);
   mousehide;
   buttonschrift(20,420,120,450,'Zurck');
   mouseshow;
   zb:=true
  end;
  if (mouseinwindow(20,290,120,320)) and (ab=true) then begin
   setcolor(darkgray);
   mousehide;
   ubuttonschrift(20,290,120,320,'Annoncen');
   mouseshow;
   ab:=false;
  end;
  if NOT((mouseinwindow(20,290,120,320))) and (ab=false) then begin
   setcolor(white);
   mousehide;
   buttonschrift(20,290,120,320,'Annoncen');
   mouseshow;
   ab:=true
  end;
  if (mouseinwindow(20,230,120,260)) and (fb=true) then begin
   setcolor(darkgray);
   mousehide;
   ubuttonschrift(20,230,120,260,'Forschung');
   mouseshow;
   fb:=false;
  end;
  if NOT((mouseinwindow(20,230,120,260))) and (fb=false) then begin
   setcolor(white);
   mousehide;
   buttonschrift(20,230,120,260,'Forschung');
   mouseshow;
   fb:=true
  end;
  if (mouseinwindow(20,170,120,200)) and (eb=true) then begin
   setcolor(darkgray);
   mousehide;
   ubuttonschrift(20,170,120,200,'Erde');
   mouseshow;
   eb:=false;
  end;
  if NOT((mouseinwindow(20,170,120,200))) and (eb=false) then begin
   setcolor(white);
   mousehide;
   buttonschrift(20,170,120,200,'Erde');
   mouseshow;
   eb:=true
  end;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(20,170,120,200)) then begin
   setcolor(white);
   settextstyle(2,0,5);
   outtextxy(160+40,30+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,60+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,90+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,120+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,150+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,180+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,210+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,240+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,270+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,300+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,330+20,'1234567890123456789012345678901234567890');
   outtextxy(160+40,360+20,'1234567890123456789012345678901234567890');
   settextstyle(2,0,6);
  end;
  if (mouseinwindow(20,110,120,140)) and (wb=true) then begin
   setcolor(darkgray);
   mousehide;
   ubuttonschrift(20,110,120,140,'Wetter');
   mouseshow;
   wb:=false;
  end;
  if NOT((mouseinwindow(20,110,120,140))) and (wb=false) then begin
   setcolor(white);
   mousehide;
   buttonschrift(20,110,120,140,'Wetter');
   mouseshow;
   wb:=true
  end;
 until (mousebutton=mousebuttonleft) and (mouseinwindow(20,420,120,450));
 mousehide;
 cleardevice;
 anders:=true;
 mouseshow;
end;

Procedure Colonie;
begin
 mousehide;
 cleardevice;
 anders:=true;
 mouseshow;
end;

Procedure bauen;
begin
 mousehide;
 cleardevice;
 anders:=true;
 mouseshow;
end;

Procedure Load;
begin
 mousehide;
 cleardevice;
 anders:=true;
 mouseshow;
end;

Procedure Save;
begin
 mousehide;
 cleardevice;
 anders:=true;
 mouseshow;
end;

Procedure Zugende;
begin
 if monat=12 then begin
  monat:=1;
  jahr:=jahr+1;
  sylvester;
 end
 else monat:=monat+1;
 mousehide;
 cleardevice;
 anders:=true;
 mouseshow;
end;

begin
 mousehide;
 cleardevice;
 if wasfor = 0 then Forschungwahlen;
 anders:=false;
 statistik:=false;
 kauf:=false;
 verkaufe:=false;
 new:=false;
 speichern:=false;
 laden:=false;
 kolonie:=false;
 forsch:=false;
 mili:=false;
 bau:=false;
 schus:=false;
 zug:=false;
 delay(1000);
 button (30,1,130,50);
 button (160,1,260,50);
 button (290,1,390,50);
 Button (420,1,520,50);
 button (30,100,130,150);
 button (160,100,260,150);
 button (290,100,390,150);
 Button (420,100,520,150);
 button (30,400,520,479);
 button(30,300,520,390);
 button(30,200,173,250);
 button(203,200,346,250);
 button(376,200,520,250);
 setcolor(brown);
 verzierrechteck(540,5,610,450);
 settextstyle (1,90,4);
 outtextxy (550,10,'(C) by Jensman & Benflash');
 settextstyle(2,0,6);
 setcolor(white);
 outtextxy(40,15,'Statistik');
 outtextxy(180,15,'Kaufen');
 outtextxy(300,15,'Verkaufen');
 outtextxy (430,15,'Forschung');
 outtextxy (50,115,'Milit„r');
 outtextxy (190,115,'News');
 outtextxy (310,115,'Bauen');
 outtextxy (435,115,'Kolonie');
 outtextxy (80,215,'Load');
 outtextxy (250,215,'Save');
 outtextxy (390,215,'Spiel Beenden');
 settextstyle (1,0,5);
 outtextxy (140,415,'Zug Beenden');
 for lv1:= 0 to 100 DO y[lv1]:=ZUFALL(301,389);
 for lv1:= 0 to 100 DO x[lv1]:=Zufall(31,519);
 for lv1:= 0 to 100 DO rot[lv1]:=RANDOM(4);
 for lv1:= 0 to 100 DO geschwindig[lv1]:=zufall(1,4);
 punktx:=0;
 punkty:=0;
 repeat
  mx:=mousexpos;
  my:=mouseypos;
  if (punktx=mousexpos) and (punkty=mouseypos) then begin
   punktx:=0;
   punkty:=0;
  end;
  color:=getpixel(punktx,punkty);
  putpixel(punktx,punkty,13);
  delay(10);
  if anders=true then begin
   mousegotoxy (320,320);
   mousehide;
   statistik:=false;
   kauf:=false;
   verkaufe:=false;
   new:=false;
   speichern:=false;
   laden:=false;
   kolonie:=false;
   forsch:=false;
   mili:=false;
   bau:=false;
   delay(1000);
   button (30,1,130,50);
   button (160,1,260,50);
   button (290,1,390,50);
   Button (420,1,520,50);
   button (30,100,130,150);
   button (160,100,260,150);
   button (290,100,390,150);
   Button (420,100,520,150);
   button (30,400,520,479);
   button(30,300,520,390);
   button(30,200,173,250);
   button(203,200,346,250);
   button(376,200,520,250);
   settextstyle (1,90,4);
   setcolor(brown);
   verzierrechteck(540,5,610,450);
   outtextxy (550,10,'(C) by Jensman & Benflash');
   settextstyle(2,0,6);
   setcolor(white);
   outtextxy(40,15,'Statistik');
   outtextxy(180,15,'Kaufen');
   outtextxy(300,15,'Verkaufen');
   outtextxy (430,15,'Forschung');
   outtextxy (50,115,'Milit„r');
   outtextxy (190,115,'News');
   outtextxy (310,115,'Bauen');
   outtextxy (435,115,'Kolonie');
   outtextxy (80,215,'Load');
   outtextxy (250,215,'Save');
   outtextxy (390,215,'Spiel Beenden');
   settextstyle (1,0,5);
   outtextxy (140,415,'Zug Beenden');
   for lv1:= 0 to 100 DO y[lv1]:=ZUFALL(301,389);
   for lv1:= 0 to 100 DO x[lv1]:=Zufall(31,519);
   for lv1:= 0 to 100 DO rot[lv1]:=RANDOM(4);
   for lv1:= 0 to 100 DO geschwindig[lv1]:=zufall(1,4);
   anders:=false;
  end;
  if (punktx=mousexpos) and (punkty=mouseypos) then begin
   punktx:=0;
   punkty:=0;
  end;
  for lv1:= 0 to 100 DO begin
  if mouseinwindow(20,275,520,395) then mousehide
   else mouseshow;
   if (punktx=mousexpos) and (punkty=mouseypos) then begin
    punktx:=0;
    punkty:=0;
   end;
   if rot [lv1]=1 then putpixel (x[lv1],y[lv1],lightred)
   else putpixel (x[lv1],y[lv1],white);
  end;
  FOR lv1:=0 to 100 DO begin
   xalt[lv1]:=x[lv1];
   yalt[lv1]:=y[lv1];
   if (punktx=mousexpos) and (punkty=mouseypos) then begin
    punktx:=0;
    punkty:=0;
   end;
  end;
  for lv1:= 0 to 100 DO x[lv1]:=x[lv1]+geschwindig[lv1];
  if (punktx=mousexpos) and (punkty=mouseypos) then begin
   punktx:=0;
   punkty:=0;
  end;
  for lv1:=0 to 100 DO begin
   if mouseinwindow(20,275,520,395) then mousehide
   else mouseshow;
   if x[lv1]>=520 then begin
    y[lv1]:=ZUFALL(301,389);
    x[lv1]:=31;
    rot[lv1]:=RANDOM(3);
    geschwindig[lv1]:=zufall(1,4);
   end;
   if (punktx=mousexpos) and (punkty=mouseypos) then begin
    punktx:=0;
    punkty:=0;
   end;
  end;
  if (mouseinwindow(30,400,520,479)) and (zug=false) then begin
   zug:=true;
   setcolor (Darkgray);
   settextstyle(1,0,5);
   mousehide;
   outtextxy (140,415,'Zug Beenden');
   ubutton(30,400,520,479);
   mouseshow;
  end
  else begin
   if (zug=true) and (not(mouseinwindow(30,400,520,479))) then begin
    setcolor (white);
    mousehide;
    settextstyle(1,0,5);
    outtextxy (140,415,'Zug Beenden');
    button(30,400,520,479);
    mouseshow;
    zug:=false;
   end;
  end;
  if (mouseinwindow(376,200,520,250)) and (schus=false) then begin
   schus:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (390,215,'Spiel Beenden');
   ubutton(376,200,520,250);
   mouseshow;
  end
  else begin
   if (schus=true) and (not(mouseinwindow(376,200,520,250))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (390,215,'Spiel Beenden');
    button(376,200,520,250);
    mouseshow;
    schus:=false;
   end;
  end;
  if (mouseinwindow(203,200,346,250)) and (speichern=false) then begin
   speichern:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (250,215,'Save');
   ubutton(203,200,346,250);
   mouseshow;
  end
  else begin
   if (speichern=true) and (not(mouseinwindow(203,200,346,250))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (250,215,'Save');
    button(203,200,346,250);
    mouseshow;
    speichern:=false;
   end;
  end;
  if (punktx=mousexpos) and (punkty=mouseypos) then begin
   punktx:=0;
   punkty:=0;
  end;
  if (mouseinwindow(30,200,173,250)) and (laden=false) then begin
   laden:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (80,215,'Load');
   ubutton(30,200,173,250);
   mouseshow;
  end
  else begin
   if (laden=true) and (not(mouseinwindow(30,200,173,250))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (80,215,'Load');
    button(30,200,173,250);
    mouseshow;
    laden:=false;
   end;
  end;
  if (mouseinwindow (30,1,130,50)) and (statistik=false) then begin
   statistik:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (40,15,'Statistik');
   ubutton(30,1,130,50);
   mouseshow;
  end
  else begin
   if (statistik=true) and (not(mouseinwindow(30,1,130,50))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (40,15,'Statistik');
    button(30,1,130,50);
    mouseshow;
    statistik:=false;
   end;
  end;
  if (punktx=mousexpos) and (punkty=mouseypos) then begin
   punktx:=0;
   punkty:=0;
  end;
  if (mouseinwindow (160,1,260,50)) and (Kauf=false) then begin
   kauf:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (180,15,'Kaufen');
   ubutton(160,1,260,50);
   mouseshow;
  end
  else begin
   if (kauf=true) and (not(mouseinwindow(160,1,260,50))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (180,15,'Kaufen');
    button(160,1,260,50);
    mouseshow;
    kauf:=false;
   end;
  end;
  if (mouseinwindow (290,1,390,50)) and (Verkaufe=false) then begin
   verkaufe:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (300,15,'Verkaufen');
   ubutton(290,1,390,50);
   mouseshow;
  end
  else begin
   if (Verkaufe=true) and (not(mouseinwindow(290,1,390,50))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (300,15,'Verkaufen');
    button(290,1,390,50);
    mouseshow;
    Verkaufe:=false;
   end;
  end;
  if (punktx=mousexpos) and (punkty=mouseypos) then begin
   punktx:=0;
   punkty:=0;
  end;
  if (mouseinwindow (420,1,520,50)) and (forsch=false) then begin
   forsch:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (430,15,'Forschung');
   ubutton(420,1,520,50);
   mouseshow;
  end
  else begin
   if (forsch=true) and (not(mouseinwindow(420,1,520,50))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (430,15,'Forschung');
    button(420,1,520,50);
    mouseshow;
    forsch:=false;
   end;
  end;
  if (mouseinwindow (30,100,130,150)) and (mili=false) then begin
   mili:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (50,115,'Milit„r');
   ubutton(30,100,130,150);
   mouseshow;
  end
  else begin
   if (mili=true) and (not(mouseinwindow(30,100,130,150))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (50,115,'Milit„r');
    button(30,100,130,150);
    mouseshow;
    mili:=false;
   end;
  end;
  if (mouseinwindow (160,100,260,150)) and (new=false) then begin
   new:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (190,115,'News');
   ubutton(160,100,260,150);
   mouseshow;
  end
  else begin
   if (new=true) and (not(mouseinwindow(160,100,260,150))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (190,115,'News');
    button(160,100,260,150);
    mouseshow;
    new:=false;
   end;
  end;
  if (punktx=mousexpos) and (punkty=mouseypos) then begin
   punktx:=0;
   punkty:=0;
  end;
  if (mouseinwindow (290,100,390,150)) and (bau=false) then begin
   bau:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (310,115,'Bauen');
   ubutton(290,100,390,150);
   mouseshow;
  end
  else begin
   if (bau=true) and (not(mouseinwindow(290,100,390,150))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (310,115,'Bauen');
    button(290,100,390,150);
    mouseshow;
    bau:=false;
   end;
  end;
  if (mouseinwindow (420,100,520,150)) and (Kolonie=false) then begin
   Kolonie:=true;
   setcolor (Darkgray);
   settextstyle(2,0,6);
   mousehide;
   outtextxy (435,115,'Kolonie');
   ubutton(420,100,520,150);
   mouseshow;
  end
  else begin
   if (Kolonie=true) and (not(mouseinwindow(420,100,520,150))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (435,115,'Kolonie');
    button(420,100,520,150);
    mouseshow;
    Kolonie:=false;
   end;
  end;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(30,400,520,479)) then Zugende;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(30,1,130,50)) then Statisktik;
  If (mousebutton=mousebuttonleft) and (mouseinwindow(160,1,260,50)) then Kaufen;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(290,1,390,50)) then Verkaufen;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(420,1,520,50)) then Forschung;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(30,100,130,150)) then Militar;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(160,100,260,150)) then News;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(290,100,390,150)) then Bauen;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(420,100,520,150)) then Colonie;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(30,200,173,250)) then Load;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(203,200,346,250)) then Save;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(376,200,520,250)) then Spielende;
  if (punktx=mousexpos) and (punkty=mouseypos) then begin
   punktx:=0;
   punkty:=0;
  end;
  delay(50);
  if (punktx=mousexpos) and (punkty=mouseypos) then begin
   punktx:=0;
   punkty:=0;
  end;
  if pal/60= Round(pal/60) then begin
   pal:=0;
   setpalette(6,Random(65));
  end;
  pal:=pal+1;
  for lv1:= 0 to 100 DO putpixel(xalt[lv1],yalt[lv1],black);
  putpixel(punktx,punkty,color);
  if mousexpos>punktx then punktx:=punktx+1;
  if mousexpos<punktx then punktx:=punktx-1;
  if mouseypos>punkty then punkty:=punkty+1;
  if mouseypos<punkty then punkty:=punkty-1;
 until 2=3;
end;

begin
 menu;
end;

begin
 nameeingeben;
 Planetenname;
 hauptspiel;
end;

Procedure Spielstand;
begin
end;

Procedure Ende;
begin
 closegraph;
 halt;
end;

procedure menu ;
var xy : Word;

Procedure Troja;
begin
 mousehide;
 cleardevice;
 settextstyle (1,0,3);
 outtextxy (5,20,'Kauft indizierte Spiele:');
 outtextxy (5,50,'Es ist doch toll, das Blut');
 outtextxy (5,80,'Und so viel davon.');
 outtextxy (5,110,'Kauft: Quake, Doom 1+2, Martal Kombat 1-3');
 outtextxy (5,140,'Und RAYMAN (aber das ist zu Brutal)');
 waitkey;
 cleardevice;
end;

begin
 video_disable(true);
 ladenmip('Menu');
 for xy:= 1 to 200 do putpixel (random(640),random (240),white);
 button(10,10,630,50);
 button(10,80,630,120);
 setcolor (9);
 settextstyle(2,0,9);
 outtextxy (150,85,'Intro Wiederholen');
 outtextxy (150,15,'Neues Spiel beginnen');
 button (10,150,300,190);
 setcolor (9);
 outtextxy (60,155,'Spiel Laden');
 Button (340,150,630,190);
 setcolor (9);
 outtextxy (450,155,'Ende');
 mouseshow;
 video_disable(false);
 repeat
  If (mouseinwindow (10,10,630,50)) and (mousebutton=mousebuttonleft) then Spiel;
  iF (mouseinwindow (10,150,300,190)) and (mousebutton=mousebuttonleft) then  Spielstand;
  If (mouseinwindow (340,150,630,190)) and (mousebutton=mousebuttonleft) then Ende;
  If (mouseinwindow (1,475,5,480)) and (mousebutton =Mousebuttonright) then begin
   mousehide;
   Troja;
   ladenmip('Menu');
   for xy:= 1 to 200 do putpixel (random(640),random (240),white);
   button(10,10,630,50);
   button(10,80,630,120);
   setcolor (9);
   settextstyle(2,0,9);
   outtextxy (150,85,'Intro Wiederholen');
   outtextxy (150,15,'Neues Spiel beginnen');
   button (10,150,300,190);
   setcolor (9);
   outtextxy (60,155,'Spiel Laden');
   Button (340,150,630,190);
   setcolor (9);
   outtextxy (450,155,'Ende');
   mouseshow;
  end;
  If (mouseinwindow (10,80,630,120)) and (mousebutton=Mousebuttonleft) Then begin
   mousehide;
   storry;
   ladenmip('Menu');
   for xy:= 1 to 200 do putpixel (random(640),random (240),white);
   button(10,10,630,50);
   button(10,80,630,120);
   setcolor (9);
   settextstyle(2,0,9);
   outtextxy (150,85,'Intro Wiederholen');
   outtextxy (150,15,'Neues Spiel beginnen');
   button (10,150,300,190);
   setcolor (9);
   outtextxy (60,155,'Spiel Laden');
   Button (340,150,630,190);
   setcolor (9);
   outtextxy (450,155,'Ende');
   mouseshow;
  end;
 until 2=3;
end;

procedure voreinstellung;

begin
 randomize;
 mouseinit;
 getdir(0,akverz);
 assign(Waffend,akverz+'\data\Waf.for');
 reset(waffend);
 assign(Gebd,akverz+'\data\geb.for');
 reset(gebd);
 assign(Fahrd,akverz+'\data\fahr.for');
 reset(fahrd);
 assign(Ausrd,akverz+'\data\aus.for');
 reset(ausrd);
 akfor.Zeit:=0;
 akfor.Name:='';
 Waffenforb:=true;
 ausrforb:=true;
 Gebforb:=true;
 Fahrforb:=true;
 wasfor:=0;
 geld:=10000+Zufall(200,800);
 einwohner:=60000+Zufall(100,1000);
 jahr:=2644;
 monat:=1;
 nahrungpreis:=Zufall(10,20);
 geratpreis:=zufall(20,47);
 baumatpreis:=zufall(20,54);
 nahrungverpreis:=ROUND(nahrungpreis/3);
 geratverpreis:=ROUND(geratpreis/3);
 baumatverpreis:=round(baumatpreis/3);
 Handlernah:=zufall(20,555);
 handlergerat:=zufall(10,333);
 handlerbau:=zufall(10,222);
 nahrungkaufen:=0;
 geratkaufen:=0;
 baumatkaufen:=0;
 nahrungverkaufen:=0;
 geratverkaufen:=0;
 baumatverkaufen:=0;
 nahrungvorat:=10000;
 geratvorat:=10000;
 baumatvorat:=10000;
 prozentfor:=0;
 grd:=Detect;
 initgraph(grd,grm,akverz+'\data\');
 GetPalette(grundPalette);
end;

begin
{ check;}
 voreinstellung;
{ Titelbild;
 storry;}
 menu;
end.