Program TicTacToh;

uses crt,graph,alles;

type TFeld = (frei,X,O);

var Feld                   : array [1..3,1..3] of TFeld;
    lv1,lv2                : Laufvar;
    Name1, Name2           : String;
    Siege1, Siege2, anzahl : Word;
    Scherz                 : Boolean;

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

procedure kreis (x,y : Byte);

var xmitte,ymitte : Word;

begin
 setcolor(blue);
 setlinestyle(0,0,3);
 xmitte:=round(((160+(x*100))-(80+(x*100)))/2+(80+(x*100)));
 ymitte:=round(((140+(y*100))-(60+(y*100)))/2+(60+(y*100)));
 circle(xmitte,ymitte,40);
end;

begin
 feld[1,1]:=O;
 feld[3,3]:=X;
 for lv1:=1 to 3 DO
 for lv2:=1 to 3 DO begin
  if feld[lv1,lv2]=O then kreis(lv1,lv2);
  if feld[lv1,lv2]=X then kreuz(lv1,lv2);
 end;
 readln;
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
 akfeld;
 closegraph;
end.

setlinestyle(0,1,1);