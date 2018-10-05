{$A-,B-,D+,E+,F-,G+,I+,L+,N+,O-,R+,S+,V+,X-}
{$M 16384,0,655360}
Program Rising_Earth;

uses crt,alles,graph,risetpu;

type TPreise=0..54;
     TForschung = record
      Name : String[41];
      Zeit : Word;
     end;

var geld,einwohner,nahrungvorat,geratvorat,baumatvorat : Longint;
    Nahrungkaufen,geratkaufen,baumatkaufen,nahrungverkaufen,geratverkaufen,baumatverkaufen:Word;
    handlernah,handlergerat,handlerbau : LongInt;
    Nahrungpreis,nahrungverpreis,geratpreis,geratverpreis,baumatpreis,baumatverpreis : TPreise;
    Jahr                          : 2643..6001;
    monat                         : 1..12;
    akFor                         : TForschung;
    WasFor                        : 0..4;
    Waffend,Ausrd,Gebd,Fahrd      : file of TForschung;

Procedure Spiel;

procedure hauptspiel;

procedure menu;
var lv1 : Laufvar;
    x,y,xalt,yalt : array [0..100] of word;
    rot, geschwindig : array [0..100] of byte;
    statistik,laden,speichern,schus,kauf,verkaufe,new,mili,forsch,kolonie,bau,zug,anders : Boolean;
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

Procedure Kaufen;
var altnahkauf,altgeratkauf,altbaukauf,altgeld,althannah,althangerat,althanbau : LONGINT;

begin
 mousehide;
 cleardevice;
 delay(100);
 button (40,10,600,50);
 setcolor(yellow);
 settextstyle (1,0,5);
 outtextxy (200,5,'kauf. Markt');
 button (40,80,60,120);
 setcolor (9);
 settextstyle (2,0,9);
 outtextxy (43,85,'+');
 button (80,80,560,120);
 button(580,80,600,120);
 setcolor (red);
 outtextxy (583,85,'-');
 setcolor (white);
 outtextxy (100,85,'Nahrung (');
 outtextxy (255,85,inttostr(nahrungpreis));
 outtextxy (290,85,'ND) :');
 Button (40,170,60,210);
 setcolor (9);
 outtextxy (43,175,'+');
 button (80,170,560,210);
 button (580,170,600,210);
 setcolor (red);
 outtextxy (583,175,'-');
 setcolor (white);
 outtextxy (90,175,'Landwirt.Ger. (');
 outtextxy (335,175,inttostr(geratpreis));
 outtextxy (380,175,'ND) :');
 button (40,260,60,300);
 setcolor (9);
 outtextxy (43,265,'+');
 button (80,260,560,300);
 Button (580,260,600,300);
 setcolor (red);
 outtextxy (583,265,'-');
 setcolor (white);
 outtextxy (100,265,'Baumaterial (');
 outtextxy (315,265,inttostr(baumatpreis));
 outtextxy (355,265,'ND) :');
 Button (80,440,560,479);
 setcolor (13);
 outtextxy (280,445,'O.k.');
 button (80,370,280,410);
 button (360,370,560,410);
 setcolor(white);
 outtextxy(380,85,inttostr(Nahrungkaufen));
 outtextxy(480,175,inttostr(geratkaufen));
 outtextxy(440,265,inttostr(baumatkaufen));
 settextstyle(2,0,5);
 outtextxy(100,385,'Geld :');
 outtextxy(155,385,inttostr(geld));
 outtextxy(370,385,'Einwohner :');
 outtextxy(460,385,inttostr(einwohner));
 button (80,130,560,150);
 outtextxy(176,133,'H�ndlervorrat (Nahrung) :');
 outtextxy(380,133,inttostr(handlernah));
 button (80,220,560,240);
 outtextxy(128,223,'H�ndlervorrat (Landwirtschaftliche Ger�te) :');
 outtextxy(480,223,inttostr(handlergerat));
 button (80,310,560,330);
 outtextxy(215,313,'H�ndlervorrat (Baumaterial) :');
 outtextxy(440,313,inttostr(handlerbau));
 mouseshow;
 repeat
 if (mousebutton=mousebuttonleft) and (mouseinwindow(80,260,560,300)) then begin
   altgeld:=geld;
   altbaukauf:=baumatkaufen;
   althanbau:=handlerbau;
   mousehide;
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar (440,261,559,299);
   readint(440,265,baumatkaufen);
   if baumatkaufen>altbaukauf then geld:=geld-(baumatkaufen-altbaukauf)*baumatpreis;
   if baumatkaufen<altbaukauf then geld:=geld+(altbaukauf-baumatkaufen)*baumatpreis;
   if baumatkaufen>altbaukauf then handlerbau:=handlerbau-(baumatkaufen-altbaukauf);
   if baumatkaufen<altbaukauf then handlerbau:=handlerbau+(altbaukauf-baumatkaufen);
   if (geld<0) or (handlerbau<0) then begin
    baumatkaufen:=altbaukauf;
    geld:=altgeld;
    handlerbau:=althanbau;
   end;
   bar (440,261,559,299);
   setcolor(white);
   outtextxy(440,265,inttostr(Baumatkaufen));
   bar (150,371,279,409);
   settextstyle(2,0,5);
   SETCOLOR(white);
   outtextxy(155,385,inttostr(geld));
   bar (439,311,500,329);
   outtextxy(440,313,inttostr(handlerbau));
   mouseshow;
  end;
 if (mousebutton=mousebuttonleft) and (mouseinwindow(80,170,560,210)) then begin
   altgeld:=geld;
   altgeratkauf:=geratkaufen;
   althangerat:=handlergerat;
   mousehide;
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar (480,171,640,209);
   button (580,170,600,210);
   setcolor (red);
   outtextxy (583,175,'-');
   setcolor (white);
   outtextxy (90,175,'Landwirt.Ger. (');
   outtextxy (335,175,inttostr(geratpreis));
   outtextxy (380,175,'ND) :');
   button (80,170,560,210);
   readint(480,175,geratkaufen);
   if geratkaufen>altgeratkauf then geld:=geld-(geratkaufen-altgeratkauf)*geratpreis;
   if geratkaufen<altgeratkauf then geld:=geld+(altgeratkauf-geratkaufen)*geratpreis;
   if geratkaufen>altgeratkauf then handlergerat:=handlergerat-(geratkaufen-altgeratkauf);
   if geratkaufen<altgeratkauf then handlergerat:=handlergerat+(altgeratkauf-geratkaufen);
   if (geld<0) or (handlergerat<0) then begin
    geratkaufen:=altgeratkauf;
    geld:=altgeld;
    handlergerat:=althangerat;
   end;
   bar (480,171,640,209);
   button (580,170,600,210);
   setcolor (red);
   outtextxy (583,175,'-');
   setcolor (white);
   outtextxy (90,175,'Landwirt.Ger. (');
   outtextxy (335,175,inttostr(geratpreis));
   outtextxy (380,175,'ND) :');
   button (80,170,560,210);
   setcolor(white);
   outtextxy(480,175,inttostr(geratkaufen));
   bar (150,371,279,409);
   settextstyle(2,0,5);
   SETCOLOR(white);
   outtextxy(155,385,inttostr(geld));
   bar (479,221,550,239);
   outtextxy(480,223,inttostr(handlergerat));
   mouseshow;
  end;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(80,80,560,120)) then begin
   altgeld:=geld;
   altnahkauf:=nahrungkaufen;
   althannah:=handlernah;
   mousehide;
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar (370,81,500,119);
   readint(380,85,nahrungkaufen);
   if nahrungkaufen>altnahkauf then geld:=geld-(nahrungkaufen-altnahkauf)*nahrungpreis;
   if nahrungkaufen<altnahkauf then geld:=geld+(altnahkauf-nahrungkaufen)*nahrungpreis;
   if nahrungkaufen>altnahkauf then handlernah:=handlernah-(nahrungkaufen-altnahkauf);
   if nahrungkaufen<altnahkauf then handlernah:=handlernah+(altnahkauf-nahrungkaufen);
   if (geld<0) or (handlernah<0) then begin
    nahrungkaufen:=altnahkauf;
    geld:=altgeld;
    handlernah:=althannah;
   end;
   bar (370,81,500,119);
   setcolor(white);
   outtextxy(380,85,inttostr(Nahrungkaufen));
   bar (150,371,279,409);
   settextstyle(2,0,5);
   SETCOLOR(white);
   outtextxy(155,385,inttostr(geld));
   bar (375,131,500,149);
   outtextxy(376,133,inttostr(handlernah));
   mouseshow;
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(40,80,60,120)) and (Handlernah>0) and (geld-nahrungpreis>=0) then
  begin
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar (370,81,500,119);
   Nahrungkaufen:=nahrungkaufen+1;
   outtextxy(380,85,inttostr(Nahrungkaufen));
   geld:=geld-nahrungpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   outtextxy(155,385,inttostr(geld));
   handlernah:=handlernah-1;
   bar (375,131,500,149);
   outtextxy(376,133,inttostr(handlernah));
   delay(400);
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(580,80,600,120)) and (Nahrungkaufen>=1) then begin
   setcolor(white);
   settextstyle (2,0,9);
   setfillstyle(0,0);
   bar (370,81,500,119);
   Nahrungkaufen:=nahrungkaufen-1;
   outtextxy(380,85,inttostr(Nahrungkaufen));
   geld:=geld+nahrungpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   outtextxy(155,385,inttostr(geld));
   handlernah:=handlernah+1;
   bar (375,131,500,149);
   outtextxy(376,133,inttostr(handlernah));
   delay(400);
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(40,170,60,210)) and (handlergerat>0) and (geld-geratpreis>=0)
  then begin
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar (480,171,540,209);
   geratkaufen:=geratkaufen+1;
   outtextxy(480,175,inttostr(geratkaufen));
   geld:=geld-geratpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   handlergerat:=handlergerat-1;
   outtextxy(155,385,inttostr(geld));
   bar (479,221,550,239);
   outtextxy(480,223,inttostr(handlergerat));
   delay(400);
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(580,170,600,210)) and (Geratkaufen>=1) then begin
   setcolor(white);
   settextstyle (2,0,9);
   setfillstyle(0,0);
   bar (480,171,540,209);
   Geratkaufen:=geratkaufen-1;
   outtextxy(480,175,inttostr(geratkaufen));
   geld:=geld+geratpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   outtextxy(155,385,inttostr(geld));
   handlergerat:=handlergerat+1;
   bar (479,221,550,239);
   outtextxy(480,223,inttostr(handlergerat));
   delay(400);
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(40,260,60,300)) and (Handlerbau>0) and (geld-baumatpreis>=0) then
  begin
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar(440,261,540,299);
   baumatkaufen:=baumatkaufen+1;
   outtextxy(440,265,inttostr(baumatkaufen));
   geld:=geld-baumatpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   outtextxy(155,385,inttostr(geld));
   handlerbau:=handlerbau-1;
   bar (439,311,500,329);
   outtextxy(440,313,inttostr(handlerbau));
   delay(400);
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(580,260,600,300)) and (Baumatkaufen>=1) then begin
   setcolor(white);
   settextstyle (2,0,9);
   setfillstyle(0,0);
   bar (440,261,540,299);
   Baumatkaufen:=Baumatkaufen-1;
   outtextxy(440,265,inttostr(Baumatkaufen));
   geld:=geld+baumatpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   outtextxy(155,385,inttostr(geld));
   handlerbau:=handlerbau+1;
   bar (439,311,500,329);
   outtextxy(440,313,inttostr(handlerbau));
   delay(400);
  end;
 until (mousebutton=mousebuttonleft) and (mouseinwindow(80,440,560,479));
 mousehide;
 cleardevice;
 anders:=true;
 mouseshow;
end;

Procedure Verkaufen;
var altnahverkauf,altgeratverkauf,altbauverkauf,altgeld,altnah,altbau,altgerat : LONGINT;

begin
 mousehide;
 cleardevice;
 delay(100);
 button (40,10,600,50);
 setcolor(yellow);
 settextstyle (1,0,5);
 outtextxy (180,5,'verkauf. Markt');
 button (40,80,60,120);
 setcolor (9);
 settextstyle (2,0,9);
 outtextxy (43,85,'+');
 button (80,80,560,120);
 button(580,80,600,120);
 setcolor (red);
 outtextxy (583,85,'-');
 setcolor (white);
 outtextxy (100,85,'Nahrung (');
 outtextxy (255,85,inttostr(nahrungverpreis));
 outtextxy (290,85,'ND) :');
 Button (40,170,60,210);
 setcolor (9);
 outtextxy (43,175,'+');
 button (80,170,560,210);
 button (580,170,600,210);
 setcolor (red);
 outtextxy (583,175,'-');
 setcolor (white);
 outtextxy (90,175,'Landwirt.Ger. (');
 outtextxy (335,175,inttostr(geratverpreis));
 outtextxy (380,175,'ND) :');
 button (40,260,60,300);
 setcolor (9);
 outtextxy (43,265,'+');
 button (80,260,560,300);
 Button (580,260,600,300);
 setcolor (red);
 outtextxy (583,265,'-');
 setcolor (white);
 outtextxy (100,265,'Baumaterial (');
 outtextxy (315,265,inttostr(baumatverpreis));
 outtextxy (355,265,'ND) :');
 Button (80,440,560,479);
 setcolor (13);
 outtextxy (280,445,'O.k.');
 button (80,370,280,410);
 button (360,370,560,410);
 setcolor(white);
 outtextxy(380,85,inttostr(Nahrungverkaufen));
 outtextxy(480,175,inttostr(geratverkaufen));
 outtextxy(440,265,inttostr(baumatverkaufen));
 settextstyle(2,0,5);
 outtextxy(100,385,'Geld :');
 outtextxy(155,385,inttostr(geld));
 outtextxy(370,385,'Einwohner :');
 outtextxy(460,385,inttostr(einwohner));
 button (80,130,560,150);
 outtextxy(230,133,'Vorrat (Nahrung) :');
 outtextxy(380,133,inttostr(nahrungvorat));
 button (80,220,560,240);
 outtextxy(182,223,'Vorrat (Landwirtschaftliche Ger�te) :');
 outtextxy(480,223,inttostr(geratvorat));
 button (80,310,560,330);
 outtextxy(270,313,'Vorrat (Baumaterial) :');
 outtextxy(440,313,inttostr(baumatvorat));
 mouseshow;
 repeat
  if (mousebutton=mousebuttonleft) and (mouseinwindow(80,260,560,300)) then begin
   altgeld:=geld;
   altbauverkauf:=baumatverkaufen;
   altbau:=baumatvorat;
   mousehide;
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar (440,261,559,299);
   readint(440,265,baumatverkaufen);
   if baumatverkaufen<altbauverkauf then geld:=geld-(altbauverkauf-baumatverkaufen)*baumatverpreis;
   if Baumatverkaufen>altbauverkauf then geld:=geld+(baumatverkaufen-altbauverkauf)*baumatverpreis;
   if baumatverkaufen>altbauverkauf then baumatvorat:=baumatvorat-(baumatverkaufen-altbauverkauf);
   if baumatverkaufen<altbauverkauf then baumatvorat:=baumatvorat+(altbauverkauf-baumatverkaufen);
   if (geld<0) or (baumatvorat<0) then begin
    baumatverkaufen:=altbauverkauf;
    geld:=altgeld;
    baumatvorat:=altbau;
   end;
   bar (440,261,559,299);
   setcolor(white);
   outtextxy(440,265,inttostr(Baumatverkaufen));
   bar (150,371,279,409);
   settextstyle(2,0,5);
   SETCOLOR(white);
   outtextxy(155,385,inttostr(geld));
   bar (439,311,500,329);
   outtextxy(440,313,inttostr(baumatvorat));
   mouseshow;
  end;
 if (mousebutton=mousebuttonleft) and (mouseinwindow(80,170,560,210)) then begin
   altgeld:=geld;
   altgeratverkauf:=geratverkaufen;
   altgerat:=geratvorat;
   mousehide;
   settextstyle (2,0,9);
   setfillstyle(0,0);
   bar (480,171,640,209);
   button (580,170,600,210);
   setcolor (red);
   outtextxy (583,175,'-');
   setcolor (white);
   outtextxy (90,175,'Landwirt.Ger. (');
   outtextxy (335,175,inttostr(geratverpreis));
   outtextxy (380,175,'ND) :');
   button (80,170,560,210);
   setcolor(white);
   readint(480,175,geratverkaufen);
   if geratverkaufen<altgeratverkauf then geld:=geld-(altgeratverkauf-geratverkaufen)*geratverpreis;
   if geratverkaufen>altgeratverkauf then geld:=geld+(geratverkaufen-altgeratverkauf)*geratverpreis;
   if geratverkaufen>altgeratverkauf then geratvorat:=geratvorat-(geratverkaufen-altgeratverkauf);
   if geratverkaufen<altgeratverkauf then geratvorat:=geratvorat+(altgeratverkauf-geratverkaufen);
   if (geld<0) or (geratvorat<0) then begin
    geratverkaufen:=altgeratverkauf;
    geld:=altgeld;
    geratvorat:=altgerat;
   end;
   bar (480,171,640,209);
   button (580,170,600,210);
   setcolor (red);
   outtextxy (583,175,'-');
   setcolor (white);
   outtextxy (90,175,'Landwirt.Ger. (');
   outtextxy (335,175,inttostr(geratverpreis));
   outtextxy (380,175,'ND) :');
   button (80,170,560,210);
   setcolor(white);
   outtextxy(480,175,inttostr(geratverkaufen));
   bar (150,371,279,409);
   settextstyle(2,0,5);
   SETCOLOR(white);
   outtextxy(155,385,inttostr(geld));
   bar (479,221,550,239);
   outtextxy(480,223,inttostr(geratvorat));
   mouseshow;
  end;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(80,80,560,120)) then begin
   altgeld:=geld;
   altnahverkauf:=nahrungverkaufen;
   altnah:=nahrungvorat;
   mousehide;
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar (370,81,500,119);
   readint(380,85,nahrungverkaufen);
   if nahrungverkaufen<altnahverkauf then geld:=geld-(altnahverkauf-nahrungverkaufen)*nahrungverpreis;
   if nahrungverkaufen>altnahverkauf then geld:=geld+(nahrungverkaufen-altnahverkauf)*nahrungverpreis;
   if nahrungverkaufen>altnahverkauf then nahrungvorat:=nahrungvorat-(nahrungverkaufen-altnahverkauf);
   if nahrungverkaufen<altnahverkauf then nahrungvorat:=nahrungvorat+(altnahverkauf-nahrungverkaufen);
   if (geld<0) or (nahrungvorat<0) then begin
    nahrungverkaufen:=altnahverkauf;
    geld:=altgeld;
    nahrungvorat:=altnah;
   end;
   bar (370,81,500,119);
   setcolor(white);
   outtextxy(380,85,inttostr(Nahrungverkaufen));
   bar (150,371,279,409);
   settextstyle(2,0,5);
   SETCOLOR(white);
   outtextxy(155,385,inttostr(geld));
   bar (375,131,500,149);
   outtextxy(376,133,inttostr(nahrungvorat));
   mouseshow;
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(40,80,60,120)) and (nahrungvorat>0) then
  begin
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar (370,81,500,119);
   Nahrungverkaufen:=nahrungverkaufen+1;
   outtextxy(380,85,inttostr(Nahrungverkaufen));
   geld:=geld+nahrungverpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   outtextxy(155,385,inttostr(geld));
   nahrungvorat:=nahrungvorat-1;
   bar (375,131,500,149);
   outtextxy(376,133,inttostr(nahrungvorat));
   delay(400);
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(580,80,600,120)) and (Nahrungverkaufen>=1) and (geld-nahrungverpreis>=0)
  then begin
   setcolor(white);
   settextstyle (2,0,9);
   setfillstyle(0,0);
   bar (370,81,500,119);
   Nahrungverkaufen:=nahrungverkaufen-1;
   outtextxy(380,85,inttostr(Nahrungverkaufen));
   geld:=geld-nahrungverpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   outtextxy(155,385,inttostr(geld));
   nahrungvorat:=nahrungvorat+1;
   bar (375,131,500,149);
   outtextxy(376,133,inttostr(nahrungvorat));
   delay(400);
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(40,170,60,210)) and (geratvorat>0) then begin
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar (480,171,540,209);
   geratverkaufen:=geratverkaufen+1;
   outtextxy(480,175,inttostr(geratverkaufen));
   geld:=geld+geratverpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   geratvorat:=geratvorat-1;
   outtextxy(155,385,inttostr(geld));
   bar (479,221,550,239);
   outtextxy(480,223,inttostr(geratvorat));
   delay(400);
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(580,170,600,210)) and (Geratverkaufen>=1) and (geld-geratverpreis>=0)
  then begin
   setcolor(white);
   settextstyle (2,0,9);
   setfillstyle(0,0);
   bar (480,171,540,209);
   Geratverkaufen:=geratverkaufen-1;
   outtextxy(480,175,inttostr(geratverkaufen));
   geld:=geld-geratverpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   outtextxy(155,385,inttostr(geld));
   geratvorat:=geratvorat+1;
   bar (479,221,550,239);
   outtextxy(480,223,inttostr(geratvorat));
   delay(400);
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(40,260,60,300)) and (baumatvorat>0) then
  begin
   settextstyle (2,0,9);
   setfillstyle(0,0);
   setcolor(white);
   bar(440,261,540,299);
   baumatverkaufen:=baumatverkaufen+1;
   outtextxy(440,265,inttostr(baumatverkaufen));
   geld:=geld+baumatverpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   outtextxy(155,385,inttostr(geld));
   baumatvorat:=baumatvorat-1;
   bar (439,311,500,329);
   outtextxy(440,313,inttostr(baumatvorat));
   delay(400);
  end;
  if (mousebutton=mousebuttonleft) and (Mouseinwindow(580,260,600,300)) and (Baumatverkaufen>=1) and (geld-baumatverpreis>=0)
  then begin
   setcolor(white);
   settextstyle (2,0,9);
   setfillstyle(0,0);
   bar (440,261,540,299);
   Baumatverkaufen:=Baumatverkaufen-1;
   outtextxy(440,265,inttostr(Baumatverkaufen));
   geld:=geld-baumatverpreis;
   bar (150,371,279,409);
   settextstyle(2,0,5);
   outtextxy(155,385,inttostr(geld));
   baumatvorat:=baumatvorat+1;
   bar (439,311,500,329);
   outtextxy(440,313,inttostr(baumatvorat));
   delay(400);
  end;
 until (mousebutton=mousebuttonleft) and (mouseinwindow(80,440,560,479));
 mousehide;
 cleardevice;
 handlernah:=handlernah+nahrungverkaufen;
 handlergerat:=handlergerat+geratverkaufen;
 handlerbau:=handlerbau+baumatverkaufen;
 nahrungverkaufen:=0;
 geratverkaufen:=0;
 baumatverkaufen:=0;
 anders:=true;
 mouseshow;
end;

Procedure Forschung;
var waf,wirt,fahr,ge,zu : Boolean;

Procedure Waffenonline;
begin
 if wasfor = 0 then begin
  setcolor(4);
  settextstyle(3,0,2);
  Zentertext(255,85,595,455,'Wird zur Zeit nicht erforscht !');
 end;
 anders:=true;
 waf:=true;
end;

Procedure Ausronline;
begin
 if wasfor = 0 then begin
  setcolor(4);
  settextstyle(3,0,2);
  Zentertext(255,85,595,455,'Wird zur Zeit nicht erforscht !');
 end;
 anders:=true;
 wirt:=true;
end;

Procedure Fahrzeugonline;
begin
 if wasfor = 0 then begin
  setcolor(4);
  settextstyle(3,0,2);
  Zentertext(255,85,595,455,'Wird zur Zeit nicht erforscht !');
 end;
 fahr:=true;
 anders:=true;
end;

Procedure Gebaudeonline;
begin
 if wasfor = 0 then begin
  setcolor(4);
  settextstyle(3,0,2);
  Zentertext(255,85,595,455,'Wird zur Zeit nicht erforscht !');
 end;
 anders:=true;
 ge:=true;
end;

begin
 waf:=false;
 wirt:=false;
 fahr:=false;
 ge:=false;
 zu:=false;
 mousehide;
 cleardevice;
 setcolor (9);
 rectangle (0,0,getmaxx,getmaxy);
 Buttonschrift (100,100,200,150,'Waffen');
 Buttonschrift (100,200,200,250,'Ausr�stung');
 buttonschrift (100,300,200,350,'Fahrzeuge');
 buttonschrift (100,400,200,450,'Geb�ude');
 button (5,5,60,475);
 settextstyle (1,0,6);
 outtextxy (150,10,'Forschung');
 line (150,65,400,65);
 settextstyle (2,0,6);
 Outtextxy (30,150,'Z');
 Outtextxy (30,180,'U');
 outtextxy (30,210,'R');
 outtextxy (30,240,'�');
 outtextxy (30,270,'C');
 outtextxy (30,300,'K');
 Rectangle (250,80,600,460);
 Rectangle (255,85,595,455);
 setfillstyle(0,black);
 mouseshow;
 repeat
  settextstyle(2,0,6);
  if mouseinwindow(5,5,60,475) then begin
   if zu = false then begin
    mousehide;
    zu:=true;
    settextstyle (2,0,6);
    ubutton(5,5,60,475);
    setcolor(blue);
    Outtextxy (30,150,'Z');
    Outtextxy (30,180,'U');
    outtextxy (30,210,'R');
    outtextxy (30,240,'�');
    outtextxy (30,270,'C');
    outtextxy (30,300,'K');
    mouseshow;
   end;
  end;
  If mouseinwindow(100,100,200,150) then begin
   if waf =false then begin
    mousehide;
    setcolor(blue);
    ubuttonschrift(100,100,200,150,'Waffen');
    Waffenonline;
    mouseshow;
   end;
  end;
  If mouseinwindow(100,200,200,250) then begin
   if wirt =false then begin
    mousehide;
    setcolor(blue);
    ubuttonschrift(100,200,200,250,'Ausr�stung');
    ausronline;
    mouseshow;
   end;
  end;
  If mouseinwindow(100,300,200,350) then begin
   if fahr =false then begin
    mousehide;
    setcolor(blue);
    ubuttonschrift(100,300,200,350,'Fahrzeuge');
    Fahrzeugonline;
    mouseshow;
   end;
  end;
  If mouseinwindow(100,400,200,450) then begin
   if ge =false then begin
    mousehide;
    setcolor(blue);
    ubuttonschrift(100,400,200,450,'Geb�ude');
    Gebaudeonline;
    mouseshow;
   end;
  end;
  if (waf=true) and (not(mouseinwindow(100,100,200,150))) then begin
   mousehide;
   setcolor(lightblue);
   buttonschrift(100,100,200,150,'Waffen');
   bar (256,86,594,454);
   waf:=false;
   mouseshow;
  end;
  if (wirt=true) and (not(mouseinwindow(100,200,200,250))) then begin
   mousehide;
   bar (256,86,594,454);
   setcolor(lightblue);
   buttonschrift(100,200,200,250,'Ausr�stung');
   wirt:=false;
   mouseshow;
  end;
  if (ge=true) and (not(mouseinwindow(100,400,200,450))) then begin
   mousehide;
   bar (256,86,594,454);
   setcolor(lightblue);
   buttonschrift(100,400,200,450,'Geb�ude');
   ge:=false;
   mouseshow;
  end;
  if (fahr=true) and (not(mouseinwindow(100,300,200,350))) then begin
   mousehide;
   setcolor(lightblue);
   buttonschrift(100,300,200,350,'Fahrzeuge');
   bar (256,86,594,454);
   fahr:=false;
   mouseshow;
  end;
  if (zu=true) and (not(mouseinwindow(5,5,60,475))) then begin
   mousehide;
   zu:=false;
   button(5,5,60,475);
   settextstyle (2,0,6);
   setcolor(lightblue);
   Outtextxy (30,150,'Z');
   Outtextxy (30,180,'U');
   outtextxy (30,210,'R');
   outtextxy (30,240,'�');
   outtextxy (30,270,'C');
   outtextxy (30,300,'K');
   mouseshow;
  end;
 until (mouseinwindow(5,5,60,475)) and (mousebutton=mousebuttonleft);
 mousehide;
 cleardevice;
 anders:=true;
 mouseshow;
end;

Procedure Militar;
begin
end;

Procedure News;
begin
end;

Procedure Colonie;
begin
end;

Procedure bauen;
begin
end;

Procedure Load;
begin
end;

Procedure Save;
begin
end;

Procedure Zugende;
begin
end;

procedure spielende;
var ja,nein : Boolean;
begin
 nein:=false;
 ja:=false;
 mousehide;
 cleardevice;
 setcolor (9);
 rectangle (0,0,getmaxx,getmaxy);
 settextstyle (1,0,5);
 outtextxy (50,100,'Das Spiel wirklich beenden?');
 settextstyle (2,0,5);
 buttonschrift (220,250,270,300,'Ja');
 buttonschrift (340,250,390,300,'Nein');
 mouseshow;
 repeat
  if mouseinwindow(340,250,390,300) then begin
   if nein=false then begin
    mousehide;
    setcolor(blue);
    ubuttonschrift(340,250,390,300,'Nein');
    nein:=true;
    mouseshow;
   end;
  end;
  if (nein=true) and (not(mouseinwindow(340,250,390,300))) then begin
   nein:=false;
   mousehide;
   setcolor(lightblue);
   buttonschrift(340,250,390,300,'Nein');
   nein:=false;
   mouseshow;
  end;
  if mouseinwindow(220,250,270,300) then begin
   if ja=false then begin
    mousehide;
    setcolor(blue);
    ubuttonschrift(220,250,270,300,'Ja');
    ja:=true;
    mouseshow;
   end;
  end;
  if (ja=true) and (not(mouseinwindow(220,250,270,300))) then begin
   ja:=false;
   mousehide;
   setcolor(lightblue);
   buttonschrift(220,250,270,300,'Ja');
   mouseshow;
  end;
  If (mouseinwindow(220,250,270,300)) and (mousebutton=mousebuttonleft) then Begin
    closegraph;
    halt;
   end;
 until (mouseinwindow(340,250,390,300)) and (mousebutton=mousebuttonleft);
 mousehide;
 cleardevice;
 mouseshow;
 anders:=true;
end;

begin
 mousehide;
 cleardevice;
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
 settextstyle (1,90,4);
 outtextxy (550,10,'(C) by Jensman & Benflash');
 settextstyle(2,0,6);
 setcolor(white);
 outtextxy(40,15,'Statistik');
 outtextxy(180,15,'Kaufen');
 outtextxy(300,15,'Verkaufen');
 outtextxy (430,15,'Forschung');
 outtextxy (50,115,'Milit�r');
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
   outtextxy (550,10,'(C) by Jensman & Benflash');
   settextstyle(2,0,6);
   setcolor(white);
   outtextxy(40,15,'Statistik');
   outtextxy(180,15,'Kaufen');
   outtextxy(300,15,'Verkaufen');
   outtextxy (430,15,'Forschung');
   outtextxy (50,115,'Milit�r');
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
   outtextxy (50,115,'Milit�r');
   ubutton(30,100,130,150);
   mouseshow;
  end
  else begin
   if (mili=true) and (not(mouseinwindow(30,100,130,150))) then begin
    setcolor (white);
    mousehide;
    settextstyle(2,0,6);
    outtextxy (50,115,'Milit�r');
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
  If (mousebutton=mousebuttonleft) and (mouseinwindow(160,1,260,50)) then begin
   mousehide;
   buttonvoll(160,1,260,50);
   delay(200);
   mouseshow;
   Kaufen;
  end;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(290,1,390,50)) then begin
   mousehide;
   buttonvoll(290,1,390,50);
   delay(200);
   mouseshow;
   Verkaufen;
  end;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(420,1,520,50)) then Forschung;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(30,100,130,150)) then Militar;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(160,100,260,150)) then News;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(290,100,390,150)) then Bauen;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(420,100,520,150)) then Colonie;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(30,200,173,250)) then Load;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(203,200,346,250)) then Save;
  if (mousebutton=mousebuttonleft) and (mouseinwindow(376,200,520,250)) then begin
   mousehide;
   buttonvoll(376,200,520,250);
   delay(200);
   mouseshow;
   Spielende;
  end;
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
 menu;
end;

Procedure Wiederhol;
 begin
           mousehide;
           cleardevice;
           settextstyle (2,0,7);
           setcolor (9);
           outtextxy (10,10, 'Als die Erde vor dem Untergang stand,');
           outtextxy (10,30, 'flohen einige Menschen vor der Katastrophe.');
           outtextxy (10,50, 'Sie fanden einen Planeten, der ihnen');
           outtextxy (10,70, 'Lebensraum Bot,es war die letzte Hoffnung.');
           outtextxy (10,90, 'Sie lie�en sich dort nieder.');
           outtextxy (10,110,'Der Planet wurde NEW HOME getauft.');
           outtextxy (10,130,'Doch nach ein paar Jahren waren die Leute');
           outtextxy (10,150,'nicht mehr mit der Politik der Siedlungs-');
           outtextxy (10,170,'f�hrung zufrieden und begann sich zu wehren.');
           outtextxy (10,190,'Die Siedlungsf�hrung, erkl�rte darauf KRIEG.  ');
           outtextxy (10,210,'Der Krieg dauerte viele Jahre, und viele');
           outtextxy (10,230,'Menschen  fiehlen ihm zum Opfer. ');
           outtextxy (10,250,'Die Kolonie verwandelte sich zu eine M�llhalde.');
           Outtextxy (200,400,'Bitte Taste dr�cken');
           waitkey;
           cleardevice;
           outtextxy (10,10, 'Nach Jahren des Elents, war die Regierung ge-');
           outtextxy (10,30, 'schlagen. Doch nun war von der Kolonie nicht mehr');
           outtextxy (10,50, 'viel �brig, die Menschen standen vor dem Nichts.');
           outtextxy (10,70, 'Immer noch starben viele Menschen, an Hunger und ');
           outtextxy (10,90, 'Seuchen, eine Folge des Krieges.');
           outtextxy (10,110,'Viele Jahre nach dem gro�en Krieg,');
           outtextxy (10,130,'stellte man sich der Herausforderung, die Menschenheit ');
           outtextxy (10,150,'zu retten. Man baute neue Unterk�nfte, bestellte ');
           outtextxy (10,170,'Felder und f�hrte eine W�hrung ein.');
           outtextxy (10,190,'Die Kolonie wurde wieder aufgebaut.Alle halfen,');
           outtextxy (10,210,'das einstige Paradies zu neuem Leben zu erwecken. ');
           outtextxy (10,230,'Doch bis dahin wird es noch ein weiter Weg.');
           outtextxy (10,250,'Man began notd�rftig �rtzte auszubilden und besiegte');
           outtextxy (10,270,'die Seuchen.');
           outtextxy (10,290,'In der Kolonie leben nun noch rund 60.000 Menschen.');
           outtextxy (10,310,'Es gibt nur wenige funktionst�chtige Maschinen,aber');
           outtextxy (10,330,'daf�r genug Waffen und Medikamente.');
           outtextxy (200,400,'Bitte Taste dr�cken');
           waitkey;
           cleardevice;
           Outtextxy (10,10,'Wir schreiben das Jahr 2644, das Jahr ');
           outtextxy (10,30,'in dem die Menschen eine neue Chance bekamen!');
           Outtextxy (200,400,'Bitte Taste dr�cken');
           waitkey;
           cleardevice;
           menu;
          end;

begin
 ladenmip('Menu',1);
 ladenmip('menu',2);
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
 mouseinit;
 mouseshow;
 repeat
  If (mouseinwindow (10,10,630,50)) and (mousebutton=mousebuttonleft) then Spiel;
  iF (mouseinwindow (10,150,300,190)) and (mousebutton=mousebuttonleft) then  Spielstand;
  If (mouseinwindow (340,150,630,190)) and (mousebutton=mousebuttonleft) then Ende;
  If (mouseinwindow (1,475,5,480)) and (mousebutton =Mousebuttonright) then Troja;
  If (mouseinwindow (10,80,630,120)) and (mousebutton=Mousebuttonleft) Then wiederhol;
 until 2=3;
end;


Procedure Storry;
var farbe : array [0..2000] of BYTE;
    x : Integer;
    lvy,lvx,lv1 : Laufvar;

Begin
 cleardevice;
 settextstyle (2,0,7);
 setcolor (9);
 outtextxy (10,10, 'Als die Erde vor dem Untergang stand,');
 outtextxy (10,30, 'flohen einige Menschen vor der Katastrophe.');
 outtextxy (10,50, 'Sie fanden einen Planeten, der ihnen');
 outtextxy (10,70, 'Lebensraum Bot,es war die letzte Hoffnung.');
 outtextxy (10,90, 'Sie lie�en sich dort nieder.');
 outtextxy (10,110,'Der Planet wurde NEW HOME getauft.');
 outtextxy (10,130,'Doch nach ein paar Jahren waren die Leute');
 outtextxy (10,150,'nicht mehr mit der Politik der Siedlungs-');
 outtextxy (10,170,'f�hrung zufrieden und begann sich zu wehren.');
 outtextxy (10,190,'Die Siedlungsf�hrung, erkl�rte darauf KRIEG.  ');
 outtextxy (10,210,'Der Krieg dauerte viele Jahre, und viele');
 outtextxy (10,230,'Menschen  fiehlen ihm zum Opfer. ');
 outtextxy (10,250,'Die Kolonie verwandelte sich zu eine M�llhalde.');
 Outtextxy (200,400,'Bitte Taste dr�cken');
 x:=10;
 repeat
  lv1:=0;
  for lvx:=x to x+2 DO
  for lvy:=0 to 480 DO begin
   farbe[lv1]:=getpixel(lvx,lvy);
   lv1:=lv1+1;
  end;
  lv1:=0;
  for lvx:=x to x+2 DO
  for lvy:=0 to 480 DO begin
   if farbe[lv1] <> black then begin
    putpixel(lvx,lvy,yellow);
   end;
   lv1:=lv1+1;
  end;
  delay(100);
  lv1:=0;
  x:=x+2;
  for lvx:= x-2 to x DO
  for lvy := 0 to 480 DO begin
   putpixel(lvx,lvy,farbe[lv1]);
   lv1:=lv1+1;
  end;
  if x=640 then x:=10;
 until keypressed;
 waitkey;
 cleardevice;
 outtextxy (10,10, 'Nach Jahren des Elents, war die Regierung ge-');
 outtextxy (10,30, 'schlagen. Doch nun war von der Kolonie nicht mehr');
 outtextxy (10,50, 'viel �brig, die Menschen standen vor dem Nichts.');
 outtextxy (10,70, 'Immer noch starben viele Menschen, an Hunger und ');
 outtextxy (10,90, 'Seuchen, eine Folge des Krieges.');
 outtextxy (10,110,'Viele Jahre nach dem gro�en Krieg,');
 outtextxy (10,130,'stellte man sich der Herausforderung, die Menschenheit ');
 outtextxy (10,150,'zu retten. Man baute neue Unterk�nfte, bestellte ');
 outtextxy (10,170,'Felder und f�hrte eine W�hrung ein.');
 outtextxy (10,190,'Die Kolonie wurde wieder aufgebaut.Alle halfen,');
 outtextxy (10,210,'das einstige Paradies zu neuem Leben zu erwecken. ');
 outtextxy (10,230,'Doch bis dahin wird es noch ein weiter Weg.');
 outtextxy (10,250,'Man began notd�rftig �rtzte auszubilden und besiegte');
 outtextxy (10,270,'die Seuchen.');
 outtextxy (10,290,'In der Kolonie leben nun noch rund 60.000 Menschen.');
 outtextxy (10,310,'Es gibt nur wenige funktionst�chtige Maschinen,aber');
 outtextxy (10,330,'daf�r genug Waffen und Medikamente.');
 outtextxy (200,400,'Bitte Taste dr�cken');
 x:=10;
 repeat
  lv1:=0;
  for lvx:=x to x+2 DO
  for lvy:=0 to 480 DO begin
   farbe[lv1]:=getpixel(lvx,lvy);
   lv1:=lv1+1;
  end;
  lv1:=0;
  for lvx:=x to x+2 DO
  for lvy:=0 to 480 DO begin
   if farbe[lv1] <> black then begin
    putpixel(lvx,lvy,yellow);
   end;
   lv1:=lv1+1;
  end;
  delay(100);
  lv1:=0;
  x:=x+2;
  for lvx:= x-2 to x DO
  for lvy := 0 to 480 DO begin
   putpixel(lvx,lvy,farbe[lv1]);
   lv1:=lv1+1;
  end;
  if x=640 then x:=10;
 until keypressed;
 waitkey;
 cleardevice;
 Outtextxy (10,10,'Wir schreiben das Jahr 2644, das Jahr ');
 outtextxy (10,30,'in dem die Menschen eine neue Chance bekamen!');
 Outtextxy (200,400,'Bitte Taste dr�cken');
 x:=10;
 repeat
  lv1:=0;
  for lvx:=x to x+2 DO
  for lvy:=0 to 480 DO begin
   farbe[lv1]:=getpixel(lvx,lvy);
   lv1:=lv1+1;
  end;
  lv1:=0;
  for lvx:=x to x+2 DO
  for lvy:=0 to 480 DO begin
   if farbe[lv1] <> black then begin
    putpixel(lvx,lvy,yellow);
   end;
   lv1:=lv1+1;
  end;
  delay(100);
  lv1:=0;
  x:=x+2;
  for lvx:= x-2 to x DO
  for lvy := 0 to 480 DO begin
   putpixel(lvx,lvy,farbe[lv1]);
   lv1:=lv1+1;
  end;
  if x=640 then x:=10;
 until keypressed;
 waitkey;
 cleardevice;
end;

procedure voreinstellung;

begin
 randomize;
 getdir(0,akverz);
 assign(Waffend,akverz+'\data\Waf.for');
 assign(Gebd,akverz+'\data\geb.for');
 assign(Fahrd,akverz+'\data\fahrd.for');
 assign(Ausrd,akverz+'\data\aus.for');
 akfor.Zeit:=0;
 akfor.Name:='';
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
end;

begin
{ check;}
 grd:=Detect;
 initgraph(grd,grm,'');
 Titelbild;
 storry;
 voreinstellung;
 menu;
end.