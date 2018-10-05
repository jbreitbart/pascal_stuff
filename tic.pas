Program TicTacToh;

uses crt,graph,alles;

type TFeld = (frei,X,O);

var Feld                           : array [1..3,1..3] of TFeld;
    lv1,lv2                        : Laufvar;
    Name1, Name2, janein           : String;
    Siege1, Siege2, anzahl         : Word;
    Scherz, Sieg1, Sieg2, Draw     : Boolean;

procedure feldzeichnen;

begin
 settextstyle(1,0,5);
 setcolor(white);
 zentertext(0,0,getmaxx,100,'Tic Tac Toh');
 settextstyle(2,0,6);
 setcolor(red);
 zentertext(10,200,140,230,Name1);
 zentertext(10,230,140,250,inttostr(Siege1));
 setcolor(blue);
 zentertext(500,200,630,230,Name2);
 zentertext(500,230,630,250,inttostr(Siege2));
 setcolor(white);
 rectangle(170,150,470,450);
 rectangle(270,150,370,450);
 rectangle(170,250,470,350);
end;

procedure akfeld;

var lv1,lv2 : Laufvar;

procedure kreuz (x,y : Byte);

begin
 setlinestyle(0,0,3);
 setcolor(red);
 line(80+(x*100),60+(y*100),160+(x*100),140+(y*100));
 line(160+(x*100),60+(y*100),80+(x*100),140+(y*100));
 setlinestyle(0,1,1);
end;

procedure penta (x,y : Byte);

begin
 setlinestyle(0,0,3);
 setcolor(red);
 line(100+(x*100),70+(y*100),120+(x*100),130+(y*100));
 line(120+(x*100),130+(y*100),140+(x*100),70+(y*100));
 line(140+(x*100),70+(y*100),85+(x*100),110+(y*100));
 line(85+(x*100),110+(y*100),155+(x*100),110+(y*100));
 line(100+(x*100),70+(y*100),155+(x*100),110+(y*100));
 setlinestyle(0,1,1);
end;


procedure kreis (x,y : Byte);

var xmitte,ymitte : Word;

begin
 setcolor(blue);
 setlinestyle(0,0,3);
 xmitte:=round(((160+(x*100))-(80+(x*100)))/2+(80+(x*100)));
 ymitte:=round(((140+(y*100))-(60+(y*100)))/2+(60+(y*100)));
 circle(xmitte,ymitte,40);
 setlinestyle(0,1,1);
end;

procedure kr (x,y : Byte);

begin
 setcolor(blue);
 setlinestyle(0,0,3);
 line(105+(x*100),60+(y*100),135+(x*100),60+(y*100));
 line(105+(x*100),60+(y*100),105+(x*100),85+(y*100));
 line(135+(x*100),60+(y*100),135+(x*100),85+(y*100));
 line(105+(x*100),85+(y*100),80+(x*100),85+(y*100));
 line(135+(x*100),85+(y*100),160+(x*100),85+(y*100));
 line(80+(x*100),85+(y*100),80+(x*100),105+(y*100));
 line(160+(x*100),85+(y*100),160+(x*100),105+(y*100));
 line(80+(x*100),105+(y*100),105+(x*100),105+(y*100));
 line(160+(x*100),105+(y*100),135+(x*100),105+(y*100));
 line(105+(x*100),105+(y*100),105+(x*100),140+(y*100));
 line(135+(x*100),105+(y*100),135+(x*100),140+(y*100));
 line(105+(x*100),140+(y*100),135+(x*100),140+(y*100));
 setlinestyle(0,1,1);
end;

begin
 mousehide;
 if scherz then begin
  for lv1:=1 to 3 DO
  for lv2:=1 to 3 DO begin
   if feld[lv1,lv2]=O then kr(lv1,lv2);
   if feld[lv1,lv2]=X then penta(lv1,lv2);
  end;
 end;
 if scherz=false then begin
  for lv1:=1 to 3 DO
  for lv2:=1 to 3 DO begin
   if feld[lv1,lv2]=O then kreis(lv1,lv2);
   if feld[lv1,lv2]=X then kreuz(lv1,lv2);
  end;
 end;
 mouseshow;
end;

procedure spieler1;

var xm, ym, x1, y : Word;
    lv1, lv2      : Laufvar;
    weiter        : Boolean;

begin
 repeat
  mouseshow;
  x1:=170;
  y:=150;
  lv1:=1;
  lv2:=1;
  weiter:=false;
  repeat until mousebutton=mousebuttonleft;
  xm:=mousexpos;
  ym:=mouseypos;
  repeat
   repeat
    if ((xm>=x1) and (xm<=x1+99)) and ((ym>=y) and (ym<=y+99)) and (feld[lv1,lv2]=frei)then begin
     feld[lv1,lv2]:=X;
     weiter:=true;
    end;
    x1:=x1+100;
    lv1:=lv1+1;
   until (lv1=4) or weiter;
   lv1:=1;
   x1:=170;
   y:=y+100;
   lv2:=lv2+1;
  until (lv2=4) or weiter;
 until weiter;
end;

procedure spieler2;

var xm, ym, x1, y : Word;
    lv1, lv2      : Laufvar;
    weiter        : Boolean;
    anz           : Word;

begin
 if anzahl = 2 then begin
  repeat
   mouseshow;
   x1:=170;
   y:=150;
   lv1:=1;
   lv2:=1;
   weiter:=false;
   repeat until mousebutton=mousebuttonleft;
   xm:=mousexpos;
   ym:=mouseypos;
   repeat
    repeat
     if ((xm>=x1) and (xm<=x1+99)) and ((ym>=y) and (ym<=y+99)) and (feld[lv1,lv2]=frei)then begin
      feld[lv1,lv2]:=O;
      weiter:=true;
     end;
     x1:=x1+100;
     lv1:=lv1+1;
    until (lv1=4) or weiter;
    lv1:=1;
    x1:=170;
    y:=y+100;
    lv2:=lv2+1;
   until (lv2=4) or weiter;
  until weiter;
 end;
 if anzahl = 1 then begin
  anz:=0;
  lv1:=1;
  lv2:=1;
  weiter:=false;
  repeat
   repeat
    if feld[lv1,lv2]=O then anz:=anz+1;
    if (anz=2) then begin
     weiter:=true;
     for lv1:=1 to 3 DO begin
      if feld[lv1,lv2]=frei then begin
       feld[lv1,lv2]:=O;
       exit;
      end;
     end;
    end;
    lv1:=lv1+1;
   until (lv1=4) or weiter;
   anz:=0;
   lv1:=1;
   lv2:=lv2+1;
   weiter:=false;
  until lv2=4;
  anz:=0;
  lv1:=1;
  lv2:=1;
  weiter:=false;
  repeat
   repeat
    if feld[lv1,lv2]=O then anz:=anz+1;
    if (anz=2) then begin
     weiter:=true;
     for lv2:= 1 to 3 DO begin
      if feld[lv1,lv2]=frei then begin
       feld[lv1,lv2]:=O;
       exit;
      end;
     end;
    end;
    lv2:=lv2+1;
   until (lv2=4) or weiter;
   anz:=0;
   lv2:=1;
   lv1:=lv1+1;
   weiter:=false;
  until lv1=4;
  anz:=0;
  lv1:=1;
  lv2:=1;
  weiter:=false;
  if feld[1,1]=O then anz:=anz+1;
  if feld[2,2]=O then anz:=anz+1;
  if feld[3,3]=O then anz:=anz+1;
  if anz=2 then begin
   repeat
    if feld[lv1,lv2]=frei then begin
     feld[lv1,lv2]:=O;
     exit;
    end;
    lv1:=lv1+1;
    lv2:=lv2+1;
   until lv1=4;
  end;
  anz:=0;
  lv1:=3;
  lv2:=1;
  weiter:=false;
  if feld[3,1]=O then anz:=anz+1;
  if feld[2,2]=O then anz:=anz+1;
  if feld[1,3]=O then anz:=anz+1;
  if anz=2 then begin
   repeat
    if feld[lv1,lv2]=frei then begin
     feld[lv1,lv2]:=O;
     exit;
    end;
    lv1:=lv1-1;
    lv2:=lv2+1;
   until lv1=0;
  end;
  anz:=0;
  lv1:=1;
  lv2:=1;
  weiter:=false;
  repeat
   repeat
    if feld[lv1,lv2]=X then anz:=anz+1;
    if (anz=2) then begin
     weiter:=true;
     for lv1:=1 to 3 DO begin
      if feld[lv1,lv2]=frei then begin
       feld[lv1,lv2]:=O;
       exit;
      end;
     end;
    end;
    lv1:=lv1+1;
   until (lv1=4) or weiter;
   anz:=0;
   lv1:=1;
   lv2:=lv2+1;
   weiter:=false;
  until lv2=4;
  anz:=0;
  lv1:=1;
  lv2:=1;
  weiter:=false;
  repeat
   repeat
    if feld[lv1,lv2]=X then anz:=anz+1;
    if (anz=2) then begin
     weiter:=true;
     for lv2:= 1 to 3 DO begin
      if feld[lv1,lv2]=frei then begin
       feld[lv1,lv2]:=O;
       exit;
      end;
     end;
    end;
    lv2:=lv2+1;
   until (lv2=4) or weiter;
   anz:=0;
   lv2:=1;
   lv1:=lv1+1;
   weiter:=false;
  until lv1=4;
  anz:=0;
  lv1:=1;
  lv2:=1;
  weiter:=false;
  if feld[1,1]=X then anz:=anz+1;
  if feld[2,2]=X then anz:=anz+1;
  if feld[3,3]=X then anz:=anz+1;
  if anz=2 then begin
   repeat
    if feld[lv1,lv2]=frei then begin
     feld[lv1,lv2]:=O;
     exit;
    end;
    lv1:=lv1+1;
    lv2:=lv2+1;
   until lv1=4;
  end;
  anz:=0;
  lv1:=3;
  lv2:=1;
  weiter:=false;
  if feld[3,1]=X then anz:=anz+1;
  if feld[2,2]=X then anz:=anz+1;
  if feld[1,3]=X then anz:=anz+1;
  if anz=2 then begin
   repeat
    if feld[lv1,lv2]=frei then begin
     feld[lv1,lv2]:=O;
     exit;
    end;
    lv1:=lv1-1;
    lv2:=lv2+1;
   until lv1=0;
  end;
  anz:=0;
  lv1:=3;
  lv2:=1;
  weiter:=false;
  repeat
   lv1:=zufall(1,3);
   lv2:=zufall(1,3);
   if feld[lv1,lv2]=frei then begin
    feld[lv1,lv2]:=O;
    weiter:=true;
   end;
  until weiter;
 end;
end;

procedure sieg1test;

var anz      : Word;
    lv1, lv2 : Laufvar;

begin
 anz:=0;
 lv1:=1;
 lv2:=1;
 repeat
  repeat
   if feld[lv1,lv2]=X then anz:=anz+1;
   if (anz=3) then begin
    sieg1:=true;
    siege1:=siege1+1;
    exit;
   end;
   lv1:=lv1+1;
  until (lv1=4);
  anz:=0;
  lv1:=1;
  lv2:=lv2+1;
 until lv2=4;
 anz:=0;
 lv1:=1;
 lv2:=1;
 repeat
  repeat
   if feld[lv1,lv2]=X then anz:=anz+1;
   if (anz=3) then begin
    sieg1:=true;
    siege1:=siege1+1;
    exit;
   end;
   lv2:=lv2+1;
  until (lv2=4);
  anz:=0;
  lv2:=1;
  lv1:=lv1+1;
 until lv1=4;
 anz:=0;
 lv1:=1;
 lv2:=1;
 if feld[1,1]=X then anz:=anz+1;
 if feld[2,2]=X then anz:=anz+1;
 if feld[3,3]=X then anz:=anz+1;
 if anz=3 then begin
  sieg1:=true;
  siege1:=siege1+1;
  exit;
 end;
 anz:=0;
 lv1:=3;
 lv2:=1;
 if feld[3,1]=X then anz:=anz+1;
 if feld[2,2]=X then anz:=anz+1;
 if feld[1,3]=X then anz:=anz+1;
 if anz=3 then begin
  sieg1:=true;
  siege1:=siege1+1;
  exit;
 end;
end;

procedure sieg2test;

var anz      : Word;
    lv1, lv2 : Laufvar;

begin
 anz:=0;
 lv1:=1;
 lv2:=1;
 repeat
  repeat
   if feld[lv1,lv2]=O then anz:=anz+1;
   if (anz=3) then begin
    sieg2:=true;
    siege2:=siege2+1;
    exit;
   end;
   lv1:=lv1+1;
  until (lv1=4);
  anz:=0;
  lv1:=1;
  lv2:=lv2+1;
 until lv2=4;
 anz:=0;
 lv1:=1;
 lv2:=1;
 repeat
  repeat
   if feld[lv1,lv2]=O then anz:=anz+1;
   if (anz=3) then begin
    sieg2:=true;
    siege2:=siege2+1;
    exit;
   end;
   lv2:=lv2+1;
  until (lv2=4);
  anz:=0;
  lv2:=1;
  lv1:=lv1+1;
 until lv1=4;
 anz:=0;
 lv1:=1;
 lv2:=1;
 if feld[1,1]=O then anz:=anz+1;
 if feld[2,2]=O then anz:=anz+1;
 if feld[3,3]=O then anz:=anz+1;
 if anz=3 then begin
  sieg2:=true;
  siege2:=siege2+1;
  exit;
 end;
 anz:=0;
 lv1:=3;
 lv2:=1;
 if feld[3,1]=O then anz:=anz+1;
 if feld[2,2]=O then anz:=anz+1;
 if feld[1,3]=O then anz:=anz+1;
 if anz=3 then begin
  sieg2:=true;
  siege2:=siege2+1;
  exit;
 end;
end;

procedure drawtest;

var lv1,lv2 : Laufvar;

begin
 for lv1:=1 to 3 DO
 for lv2:=1 to 3 DO if feld[lv1,lv2]=frei then exit;
 draw:=true;
end;

procedure Spiel;

begin
 repeat
  spieler1;
  akfeld;
  sieg1test;
  drawtest;
  if sieg1 then begin
   settextstyle(2,0,6);
   setcolor(red);
   zentertext(100,110,540,130,Name1+' hat gewonnen !');
   delay(40000);
   exit;
  end;
  if draw then begin
   settextstyle(2,0,6);
   setcolor(white);
   zentertext(100,110,540,130,'Unentschieden !');
   delay(40000);
   exit;
  end;
  spieler2;
  akfeld;
  sieg2test;
  drawtest;
  if sieg2 then begin
   settextstyle(2,0,6);
   setcolor(red);
   zentertext(100,110,540,130,Name2+' hat gewonnen !');
   delay(40000);
   exit;
  end;
  if draw then begin
   settextstyle(2,0,6);
   setcolor(white);
   zentertext(100,110,540,130,'Unentschieden !');
   delay(40000);
   exit;
  end;
 until 1=2;
end;

begin
 grd:=detect;
 initgraph(grd,grm,'');
 mouseinit;
 mousewindow(170,150,470,450);
 for lv1:= 1 to 3 DO
 for lv2:= 1 to 3 DO feld[lv1,lv2]:=frei;
 Name1:='';
 Name2:='Computer';
 Siege1:=0;
 Siege2:=0;
 anzahl:=0;
 scherz:=false;
 Sieg1:=false;
 draw:=false;
 sieg2:=false;
 settextstyle(2,0,6);
 outtextxy(100,100,'Bitte die Anzahl der Spieler eingeben (1 oder 2) :');
 repeat
  readint(580,100,anzahl);
  if (anzahl<>1) and (anzahl<>2) then begin
   setfillstyle(1,black);
   bar (580,100,getmaxx,getmaxy);
  end;
  setcolor(white);
 until (anzahl=1) or (anzahl=2);
 outtextxy(100,200,'Gib deinen Namen ein, Spieler 1 :');
 setcolor(red);
 readtextlange(420,200,Name1,8);
 if name1='Jensman' then scherz:=true;
 if anzahl=2 then begin
  setcolor(white);
  outtextxy(100,300,'Gib deinen Namen ein, Spieler 2 :');
  setcolor(blue);
  readtextlange(420,300,Name2,8);
 end;
 cleardevice;
 feldzeichnen;
 lv1:=zufall(1,2);
 if lv1=2 then begin
  spieler2;
  akfeld;
 end;
 repeat
  spiel;
  for lv1:= 1 to 3 DO
  for lv2:= 1 to 3 DO feld[lv1,lv2]:=frei;
  mousehide;
  cleardevice;
  setcolor(white);
  outtextxy(100,100,'Noch ein Spiel (J/N) ?');
  repeat
   setfillstyle(1,black);
   bar (300,100,getmaxx,getmaxy);
   readtext(300,100,janein);
   gross(janein);
  until (janein[1]='J') or (janein[1]='N');
  if janein[1]='J' then begin
   cleardevice;
  end;
  if janein[1]='N' then begin
   closegraph;
   writeln(Name1+' hat '+inttostr(siege1)+' Siege !');
   writeln(Name2+' hat '+inttostr(siege2)+' Siege !');
   halt;
  end;
  feldzeichnen;
  Sieg1:=false;
  draw:=false;
  sieg2:=false;
  mouseshow;
 until 2=3;
end.

setlinestyle(0,1,1);