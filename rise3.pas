{$A-,B-,D+,E+,F-,G+,I+,L+,N-,O-,R+,S+,V+,X-}
{$M 16384,0,655360}
Program Rising_Earth;

uses crt,alles,graph;

var grd, grm : Integer;
    Name :String;

Procedure Menu;
Var x,y :integer;
Begin
 cleardevice;
 setbkcolor (darkgray);
 waitkey;
end;

Procedure Nameeingeben;
Procedure Ray;
var a : Integer;

begin
 a:=  0;
 repeat
  line (a,0,round(getmaxx/2),round(getmaxy));
  a:= a +15;
 until a > 640;
 a:=0;
 repeat
  line (320,0,a,480);
  a:= a +15;
 until a > 640;
 a:=0;
 repeat
  line(0,240,640,a);
  a:=a+15;
 until a > 480;
 a:=0;
 repeat
  line(640,240,0,a);
  a:=a+15;
 until a > 480;
end;

Begin
 Cleardevice;
 setcolor (9);
 Rectangle (0,0,getmaxx,getmaxy);
 settextstyle (2,0,10);
 setfillstyle (0,0);
 ray;
 bar (1,190+20,638,250+20);
 Outtextxy (10,200+20,'Name :');
 setcolor(white);
 Readtext3d (150,200+20,name);
end;

Procedure Sterneb;
Var Lv1:laufvar;
Begin
 for lv1 := 1 to 50 do putpixel (random(640), random (480),yellow);
 for lv1 := 1 to 15 do putpixel (random(640),random(480),red);
 for lv1 := 1 to 15 do putpixel (random(640),random(480),cyan);
end;

Procedure Storry;
Begin
 cleardevice;
 settextstyle (2,0,7);
 setcolor (9);
 outtextxy (10,10, 'Als die Erde vor dem Untergang stand,');
 outtextxy (10,30, 'floh die Menschheit vor der Katastrophe.');
 outtextxy (10,50, 'Sie fanden einen Planeten, der ihren');
 outtextxy (10,70, 'AnsprÅchen genÅgte.');
 outtextxy (10,90, 'Dort lie·en sie sich nieder.');
 outtextxy (10,110,'Sie nannten den Planten NEW HOME');
 outtextxy (10,130,'Doch nach ein paar Jahren waren die Leute');
 outtextxy (10,150,'nicht mehr mit der Politik der Siedlungs-');
 outtextxy (10,170,'fÅhrung zufrieden und eine Revolution begann');
 outtextxy (10,190,'Die Colonie verfiehl dem Chaos.');
 outtextxy (10,210,'Der Krieg zog sich Åber Jahre hinweg, und viele');
 outtextxy (10,230,'Menschen starben. Die Colonie war nur noch eine');
 outtextxy (10,250,'MÅllhalde.');
 Outtextxy (200,300,'Taste DrÅcken');
 Waitkey;
 cleardevice;
 outtextxy (10,10, 'Nach Åber 6 Jahren Kampf, war die Regierung ge-');
 outtextxy (10,30, 'schlagen. Doch nun war von der Colonie nicht mehr');
 outtextxy (10,50, 'viel öbrig, die Menschen standen vor dem Nichts.');
 outtextxy (10,70, 'Auch nun starben viele Menschen an Hunger und ');
 outtextxy (10,90, 'Seuchen.');
 outtextxy (10,110,'Doch Jahre lang nach dem Krieg gegen die Regierung');
 outtextxy (10,130,'stellte sich der Herausforderung, die Menschheit zu');
 outtextxy (10,150,'retten. Man baute neue UnterkÅnfte und bestellte ');
 outtextxy (10,170,'Felder und man fÅhrte eine WÑhrung ein.');
 outtextxy (10,190,'Man baute die Kolonie wieder auf, und jeder Mann');
 outtextxy (10,210,'half. Es soll wieder ein Paradies werden.');
 outtextxy (10,230,'Doch bis dahin ist es noch ein weiter Weg.');
 waitkey;
end;

procedure Titelbild;
var Sterne : Laufvar;
    taste : char;
procedure Kreisnaherkommen;
var color,radius,xmittelpunkt,ymittelpunkt,x, y,sonnex,sonney: integer;
    winkel, xekreis, yekreis, xkreis, ykreis,swinkel   : real;
    lv1,sonnelv,zaehler : Laufvar;
begin
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
   if keypressed then taste := readkey;
   if taste = escape then exit;
   if ((sonnelv/2) = round(sonnelv/2)) then swinkel:=swinkel+0.005;
  end;
  zaehler:=zaehler+1;
  if (zaehler/3) = round(zaehler/3) then sonnelv:=sonnelv+1;
 end;
end;
begin
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 sterneb;
 kreisnaherkommen;
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(150,5,'Rising Earth');
  delay(sterne*150);
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
  delay(sterne*150);
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
  delay(sterne*150);
  if sterne <> 8 then begin
   setcolor(black);
   outtextxy(220,50,'The Begining');
  end;
 end;
 delay(30000);
 cleardevice;
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 sterneb;
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(250,200,' by');
  delay(sterne*150);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(250,200,' by');
  end;
 end;
 delay (30000);
 cleardevice;
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 sterneb;
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(80,200,'Jensman and Benflash');
  delay(sterne*150);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(80,200,'Jensman and Benflash');
  end;
 end;
 delay (30000);
 cleardevice;
 sterneb;
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(80,200,' Programed in 1997');
  delay(sterne*150);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(80,200,' Programed in 1997');
  end;
 end;
 delay (30000);
 cleardevice;
 sterneb;
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
    setcolor(9);
  outtextxy(200,200,'in Germany');
  delay(sterne*150);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(200,200,'in Germany');
  end;
 end;
 delay (30000);
 cleardevice;
 for sterne := 1 to 600 DO putpixel(Random(640),Random(480),white);
 sterneb;
 for sterne:=1 to 10 DO begin
  if keypressed then taste := readkey;
  if taste = escape then exit;
  settextstyle(2,0,sterne);
  setcolor(9);
  outtextxy(170,200,'(c)`Stupid Two');
  delay(sterne*150);
  if sterne <> 10 then begin
   setcolor(black);
   outtextxy(170,200,'(c)`Stupid Two');
  end;
  end;
 delay(20000);
 cleardevice;
end;

begin
 grd:=DETECT;
 initgraph(grd,grm,'');
 delay(10);
{ Titelbild;
 storry;}
 menu;
 nameeingeben;
 closegraph;
end.