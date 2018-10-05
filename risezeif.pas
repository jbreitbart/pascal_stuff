uses graph,alles,crt;

type Tdatei = string[8];

var bild : array [1..150,1..100] of Byte;
    akfarbe : Byte;
    Dateiname : TDatei;

procedure zakfarbe;
var x,y : Word;
begin
 mousehide;
 for x:=0 to 630 DO
 for y:=460 to 479 DO putpixel(x,y,akfarbe);
 mouseshow;
end;

procedure anfangzeichnen;
var x,y : Word;
    f : Byte;
begin
 akfarbe:=white;
 for x:= 1 to 150 DO
 for y:=1 to 100 DO bild[x,y]:=akfarbe;
 setfillstyle(1,white);
 bar (10,110,610,410);
 setcolor(black);
 y:=110;
 x:=10;
 repeat
  line(x,y,x,y+400);
  x:=x+4;
 until x=614;
 x:=10;
 y:=110;
 repeat
  line(x,y,x+600,y);
  y:=y+3;
 until y=413;
 x:=5;
 f:=0;
 setcolor(white);
 repeat
  setfillstyle(1,f);
  if f=black then rectangle(x,420,x+30,450)
  else bar (x,420,x+30,450);
  x:=x+39;
  f:=f+1;
 until f = 17;
 zakfarbe;
 setcolor(white);
 settextstyle(10,0,5);
 buttonschrift(2,2,100,30,'Speichern');
 buttonschrift(110,2,208,30,'Laden');
 buttonschrift(542,2,637,30,'Beenden');
 buttonschrift(2,82,50,95,'Linie');
 button(2,42,208,70);
 outtextxy(20,52,Dateiname);
 setfillstyle(1,white);
 bar(220,0,369,99);
 { Speichern, Laden, Beenden}
end;

procedure akfarbeerkennen;

begin
 if (mouseinwindow(5,420,35,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=black;
  zakfarbe;
 end;
 if (mouseinwindow(44,420,74,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=1;
  zakfarbe;
 end;
 if (mouseinwindow(83,420,113,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=2;
  zakfarbe;
 end;
 if (mouseinwindow(122,420,152,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=3;
  zakfarbe;
 end;
 if (mouseinwindow(161,420,191,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=4;
  zakfarbe;
 end;
 if (mouseinwindow(200,420,230,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=5;
  zakfarbe;
 end;
 if (mouseinwindow(239,420,269,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=6;
  zakfarbe;
 end;
 if (mouseinwindow(278,420,308,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=7;
  zakfarbe;
 end;
 if (mouseinwindow(317,420,347,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=8;
  zakfarbe;
 end;
 if (mouseinwindow(356,420,386,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=9;
  zakfarbe;
 end;
 if (mouseinwindow(395,420,425,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=10;
  zakfarbe;
 end;
 if (mouseinwindow(434,420,464,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=11;
  zakfarbe;
 end;
 if (mouseinwindow(473,420,503,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=12;
  zakfarbe;
 end;
 if (mouseinwindow(512,420,542,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=13;
  zakfarbe;
 end;
 if (mouseinwindow(551,420,581,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=14;
  zakfarbe;
 end;
 if (mouseinwindow(590,420,620,450)) and (mousebutton=mousebuttonleft) then begin
  akfarbe:=15;
  zakfarbe;
 end;
end;

procedure zeichnen;
var x,y,z1,z2 : Word;

begin
 x:=10;
 y:=110;
 z1:=1;
 z2:=1;
 repeat
  repeat
   if (mouseinwindow(x,y,x+3,y+2)) and (mousebutton=mousebuttonleft) then begin
    bild[z1,z2]:=akfarbe;
    setfillstyle(1,akfarbe);
    mousehide;
    bar(x+1,y+1,x+3,y+2);
    putpixel(220+z1-1,0+z2-1,akfarbe);
    mouseshow;
   end;
   x:=x+4;
   z1:=z1+1;
  until z1=151;
  y:=y+3;
  z2:=z2+1;
  x:=10;
  z1:=1;
 until z2=101;
end;

procedure readtext(x,y : word; var s : TDatei);

var taste : char;
    zusammen : array [1..8] of char;
    lv1,cursorpos : Laufvar;
    farbealt:byte;
    t : Word;

begin
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 1 to 8 DO zusammen[lv1]:='»';
 lv1:=1;
 for t := 1 to 8 DO begin
  taste:=dateiname[t];
  setcolor (white);
  cursorpos:=cursorpos+1;
  setcolor (black);
  setcolor(farbealt);
  outtextxy(x,y,taste);
  zusammen[lv1]:=taste;
  x:=x+textwidth(taste);
  lv1:=lv1+1;
 end;
 taste:='M';
 repeat
  if keypressed then begin
   cursorpos:=cursorpos+1;
   taste:=readkey;
   setcolor (black);
   if (taste = backspace) and (lv1>1) then begin
    lv1:=lv1-1;
    setcolor(black);
    x:=x-textwidth(zusammen[lv1]);
    outtextxy(x,y,zusammen[lv1]);
    zusammen[lv1]:='»';
   end;
   if (taste <> return) and (taste <> backspace) and (lv1<9) and
   ( ((taste >=#97) and (taste<=#122)) or ((taste>=#65) and (taste<=#90)) or ((taste>=#48) and (taste<=#57)) )then
   begin
    setcolor(farbealt);
    outtextxy(x,y,taste);
    zusammen[lv1]:=taste;
    x:=x+textwidth(taste);
    lv1:=lv1+1;
   end;
  end;
 until (taste=return) and (lv1>0);
 s:='';
 for lv1:= 1 to 8 DO begin
  if zusammen[lv1]='»' then s:=s+' '
  else s:=s+zusammen[lv1];
 end;
 tpl;
end;

procedure speichern;
var f : File;
    a,b : Word;
    ar : array [1..150] of Byte;
    da : Boolean;
    taste : Char;
begin
 mousehide;
 setfillstyle(1,black);
 bar(3,43,207,69);
 setcolor(white);
 readtext(20,52,Dateiname);
 da:=FileExists('c:\pascal\forb\'+dateiname+'.mif');
 if da then begin
  setfillstyle(1,black);
  bar(3,43,207,69);
  setcolor(white);
  outtextxy(10,52,'Datei Åberschreiben (J/N)');
  taste:=readkey;
  taste:=upcase(taste);
  if taste ='J' then begin
   assign(f,'C:\pascal\forb\'+dateiname+'.mif');
   rewrite(f,1);
   for a:= 1 to 100 DO begin
    for b:= 1 to 150 DO ar[b] := bild[b,a];
    blockwrite(f,ar,sizeof(ar));
   end;
   close(f);
  end;
  setfillstyle(1,black);
  bar(3,43,207,69);
  setcolor(white);
  outtextxy(20,52,Dateiname);
 end
 else begin
  assign(f,'C:\pascal\forb\'+dateiname+'.mif');
  rewrite(f,1);
  for a:= 1 to 100 DO begin
   for b:= 1 to 150 DO ar[b] := bild[b,a];
   blockwrite(f,ar,sizeof(ar));
  end;
  close(f);
 end;
 mouseshow;
end;

procedure laden;
var da : Boolean;
    datei : TDatei;
    f : File;
    ar : array [1..150] of byte;
    lv1,lv2,x,y : Laufvar;
begin
 setfillstyle(1,black);
 bar(3,43,207,69);
 setcolor(white);
 mousehide;
 readtext(20,52,Datei);
 da:=fileexists('C:\Pascal\forb\'+datei+'.mif');
 if da=false then begin
  setfillstyle(1,black);
  bar(3,43,207,69);
  setcolor(white);
  outtextxy(20,52,'Datei Existiert nicht');
  delay(20000);
  setfillstyle(1,black);
  bar(3,43,207,69);
  setcolor(white);
  outtextxy(20,52,Dateiname);
 end;
 if da then begin
  setfillstyle(1,black);
  bar(3,43,207,69);
  setcolor(white);
  outtextxy(20,52,Datei);
  assign(f,'C:\pascal\Forb\'+Datei+'.mif');
  reset(f,1);
  lv1:=1;
  lv2:=1;
  x:=10;
  y:=110;
  repeat
   blockread(f,ar,sizeof(ar));
   repeat
    setfillstyle(1,ar[lv1]);
    bar(x+1,y+1,x+3,y+2);
    putpixel(220+lv1-1,0+lv2-1,ar[lv1]);
    bild[lv1,lv2]:=ar[lv1];
    x:=x+4;
    lv1:=lv1+1;
   until lv1=151;
   lv1:=1;
   x:=10;
   y:=y+3;
   lv2:=lv2+1;
  until lv2=101;
  close(f);
  Dateiname:=Datei;
 end;
 mouseshow;
end;

procedure linie;
var x1,y,x2,z1,z2,startx,starty,endex,endey,lv1 : Word;

begin
 mousegotoxy(100,200);
 mousewindow(10,110,609,409);
 mouseshow;
 delay(10000);
 repeat until mousebutton=mousebuttonleft;
 x1:=10;
 y:=110;
 z1:=1;
 z2:=1;
 startx:=0;
 starty:=0;
 endex:=0;
 endey:=0;
 repeat
  repeat
   if mouseinwindow(x1,y,x1+3,y+2) then begin
    startx:=z1;
    starty:=z2;
   end;
   if startx= 0 then begin
    x1:=x1+4;
    z1:=z1+1;
   end;
  until (z1=151) or (startx<>0);
  if startx=0 then begin
   x1:=10;
   y:=y+3;
   z1:=1;
   z2:=z2+1;
  end;
 until (z2=101) or (starty<>0);
 delay(10000);
 repeat
  mousegotoxy(mousexpos,y);
 until mousebutton=mousebuttonleft;
 x2:=10;
 z1:=1;
 endex:=0;
 endey:=starty;
 repeat
  if mouseinwindow(x2,y,x2+3,y+2) then begin
   endex:=z1;
  end;
  x2:=x2+4;
  z1:=z1+1;
 until (z1=151) or (endex<>0);
 writeln(startx,' ',starty);
 writeln(endex,' ',endey);
 if x1>x2 then begin
  lv1:=endex;
  endex:=startx;
  startx:=lv1;
  lv1:=x2;
  x2:=x1;
  x1:=lv1;
 end;
 z1:=startx;
 mousehide;
 repeat
  setfillstyle(1,akfarbe);
  bild[z1,z2]:=akfarbe;
  bar(x1+1,y+1,x1+3,y+2);
  putpixel(220+z1-1,0+z2-1,akfarbe);
  x1:=x1+4;
  z1:=z1+1;
 until (z1=endex+1) or (x1>606);
 mouseshow;
 mousewindow(0,0,getmaxx,getmaxy);
end;

begin
 grd:=detect;
 initgraph(grd,grm,'');
 mouseinit;
 mousewindow(0,0,getmaxx,getmaxy);
 dateiname:='12345678';
 anfangzeichnen;
 mouseshow;
 repeat
  akfarbeerkennen;
  if (mouseinwindow(2,82,50,95)) and (mousebutton=mousebuttonleft) then linie;
  if (mouseinwindow(10,110,610,410)) and (mousebutton=mousebuttonleft) then zeichnen;
  if (mouseinwindow(2,2,100,30)) and (mousebutton=mousebuttonleft) then speichern;
  if (mouseinwindow(110,2,208,30)) and (mousebutton=mousebuttonleft) then laden;
 until (mouseinwindow(542,2,637,30)) and (mousebutton=mousebuttonleft);
 closegraph;
end.