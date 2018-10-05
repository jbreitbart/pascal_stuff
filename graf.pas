program Graphic;
uses crt, graph,alles;

var treiber, modus,x,geldx,geldy,geldxalt,geldyalt: Integer;
    geld : array [1..9] of LONGINT;
    lv1 : Laufvar;

procedure skala;
var dabei,x,y,lv1 : word;
begin
 dabei:=450;
 settextstyle(2,0,4);
 outtextxy(20,469,'Vor x Runden');
 outtextxy(103,470,'8');
 outtextxy(178,470,'7');
 outtextxy(253,470,'6');
 outtextxy(328,470,'5');
 outtextxy(403,470,'4');
 outtextxy(478,470,'3');
 outtextxy(553,470,'2');
 outtextxy(628,470,'1');
 x:=0;
 y:=0;
 lv1:=dabei*46;
 repeat
  lv1:=lv1-dabei;
  outtextxy(x,y,inttostr(lv1));
  y:=y+10;
 until lv1=0;
end;

begin
  treiber:=detect;
  initgraph(treiber,modus,'');
  setcolor(white);
  line(30,11,30,461);
  line(30,461,630,461);
  x:=30;
  repeat
   x:=x+75;
   line(x,451,x,471);
  until x=630;
  x:=1;
  lv1:=0;
  repeat
   x:=x+10;
   line(25,x,35,x);
   lv1:=lv1+1;
  until x = 451;
  skala;
  geld[9]:=10000;
  geld[8]:=2000;
  geld[7]:=900;
  geld[6]:=10000;
  geld[5]:=5000;
  geld[4]:=20000;
  geld[3]:=1000;
  geld[2]:=1000;
  geld[1]:=9999;
  geldx:=30;
  geldy:=10;
  geldxalt:=30;
  geldyalt:=round(geld[9]/45);
  for lv1:= 8 downto 1 DO begin;
   geldx:=geldx+75;
   geldy:=round(geld[lv1]/45);
   line(geldxalt,geldyalt,geldx,geldy);
   geldxalt:=geldx;
   geldyalt:=geldy;
  end;
  readln;
  CloseGraph;
end.