{PLANETEN NAMEN}

uses alles,graph,crt;

type TRasse    = (Erdallianz,Schatten,Vorlonen,Mimbari,Naren,Zentauri,keine);
     TStimmung = (wutend,freundlich,neutral);
     TKlasse   = 1..10;
     TFracht   = (Geld,Menschen,Dilizium,gold,nuscht);
     TBevolk   = Record
                  Anzahl : Longint;
                  Stimmung : TStimmung;
                 end;
     TUrbevolk = record
                  janein   : Boolean;
                  Anzahl   : Longint;
                  Stimmung : TStimmung;
                 end;
     TNahrung  = record
                  wieviel     : Longint;
                  Nachwachsen : 0..20;
                 end;
     TJager    = record
                  Klasse    : TKlasse;
                  beschadig : 0..100;
                 end;
     TMineral  = record
                  anzahl : Longint;
                 end;
     TShip     = record
                  Antrieb    : TKlasse;
                  maxwaffen  : 0..20;
                  anzwaffen  : 0..20;
                  waffen     : array [0..20] of TKlasse;
                  maxfracht  : 0..150;
                  anzfracht  : 0..150;
                  Frachtraum : array [0..150] of TFracht;
                  beschadigt : 0..100;
                 end;
     TRaumst   = record
                  janein     : Boolean;
                  anzJa      : 0..100;
                  Jager      : array [0..100] of TJager;
                  anzWaf     : 0..30;
                  Waffen     : array [0..30] of TKlasse;
                  janeinbau  : Boolean;
                  bauen      : TShip;
                  beschadigt : 0..100;
                 end;
     TPlanet   = record
                  X,Y         : Word;
                  Rasse       : TRasse;
                  Urbevolk    : TUrbevolk;
                  Bevolk      : TBevolk;
                  Nahrung     : TNahrung;
                  Steuern     : 0..40;
                  Dilizium    : TMineral;
                  Gold        : TMineral;
                  Raumstation : TRaumst;
                 end;
     TString  = string[8];
     TSpieler = record
                 Rasse : TRasse;
                 Name  : TString;
                 passwort : TString;
                end;

var akspieler : TSpieler;
    nummer    : 1..6;
    karte     : file of Tplanet;
    x         : array [0..499] of word;
    y         : array [0..499] of word;
    akverz    : String;

procedure readtext(x,y : word; var s : Tstring);

var taste : char;
    zusammen : array [0..255] of char;
    lv1,cursorpos : Laufvar;
    farbealt:byte;

begin
 tpl;
 s:='';
 cursorpos:=0;
 farbealt:=getcolor;
 for lv1 := 0 to 255 DO zusammen[lv1]:='È';
 lv1:=0;
 taste:='M';
 repeat
  setcolor (white);
  if (taste <>Backspace) and (taste <> return) and (lv1<8) then
   line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
  else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
  if keypressed then begin
    cursorpos:=cursorpos+1;
    taste:=readkey;
    setcolor (black);
    if (taste <>Backspace) and (taste <> return) and (lv1<8) then
     line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
    else line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
    delay(300);
  if (taste = backspace) and (lv1>=1) then begin
   lv1:=lv1-1;
   setcolor(black);
   line (x,y+textheight(zusammen[lv1]),x+TextWidth(zusammen[lv1]),y+textheight(zusammen[lv1]));
   x:=x-textwidth(zusammen[lv1]);
   outtextxy(x,y,zusammen[lv1]);
   zusammen[lv1]:='È';
  end;
  if (taste <> return) and (taste <> backspace) and (lv1<8) then
  begin
   setcolor(farbealt);
   outtextxy(x,y,taste);
   zusammen[lv1]:=taste;
   x:=x+textwidth(taste);
   lv1:=lv1+1;
  end;
 end;
 delay(600);
 setcolor (black);
 if (taste <>Backspace) and (taste <> return) and (lv1<8) then
  line (x,y+textheight(taste),x+textwidth(taste),y+textheight(taste))
 else line (x,y+textheight('M'),x+TextWidth('M'),y+textheight('M'));
 delay(300);
 setpalette(brown,RANDOM(65));
 until taste=return;
 for lv1:= 0 to 255 DO begin
  if zusammen[lv1]='È' then exit;
  s:=s+zusammen[lv1];
 end;
 tpl;
end;

procedure spielerwahlen;
var pal : Word;
    taste : Char;
    eins,zwei,drei,vier,funf,sechs : Boolean;
begin
 eins:=NOT(fileexists(akverz+'\babylon\spieler.1'));
 zwei:=NOT(fileexists(akverz+'\babylon\spieler.2'));
 drei:=NOt(fileexists(akverz+'\babylon\spieler.3'));
 vier:=Not(fileexists(akverz+'\babylon\spieler.4'));
 funf:=Not(fileexists(akverz+'\babylon\spieler.5'));
 sechs:=not(fileexists(akverz+'\babylon\spieler.6'));
 if eins then begin
  setfillstyle(1,darkgray);
  bar (10,100,30,130);
  setcolor(white);
  settextstyle(0,0,1);
  buttonschrift(10,100,30,130,'1');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,100,30,130);
  setcolor(darkgray);
  settextstyle(0,0,1);
  ubuttonschrift(10,100,30,130,'1');
 end;
 if zwei then begin
  setfillstyle(1,darkgray);
  bar (10,163,30,193);
  setcolor(white);
  buttonschrift(10,163,30,193,'2');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,163,30,193);
  setcolor(darkgray);
  settextstyle(0,0,1);
  ubuttonschrift(10,163,30,193,'2');
 end;
 if drei then begin
  setfillstyle(1,darkgray);
  bar (10,226,30,256);
  setcolor(white);
  buttonschrift(10,226,30,256,'3');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,226,30,256);
  setcolor(darkgray);
  settextstyle(0,0,1);
  ubuttonschrift(10,226,30,256,'3');
 end;
 if vier then begin
  setfillstyle(1,darkgray);
  bar (10,289,30,319);
  setcolor(white);
  buttonschrift(10,289,30,319,'4');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,289,30,319);
  setcolor(darkgray);
  settextstyle(0,0,1);
  ubuttonschrift(10,289,30,319,'4');
 end;
 if funf then begin
  setfillstyle(1,darkgray);
  bar (10,352,30,382);
  setcolor(white);
  buttonschrift(10,352,30,382,'5');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,352,30,382);
  setcolor(darkgray);
  settextstyle(0,0,1);
  ubuttonschrift(10,352,30,382,'5');
 end;
 if sechs then begin
  setfillstyle(1,darkgray);
  bar (10,415,30,445);
  setcolor(white);
  buttonschrift(10,415,30,445,'6');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,415,30,445);
  setcolor(darkgray);
  settextstyle(0,0,1);
  ubuttonschrift(10,415,30,445,'6');
 end;
 settextstyle(3,0,5);
 outtextxy(100,180,'Name :');
 outtextxy(100,310,'Passwort :');
 settextstyle(1,0,5);
 setcolor(brown);
 zentertext(0,0,getmaxx,100,'Spieler-Nummer w„hlen');
 pal:=0;
 repeat
  if pal=20000 then begin
   pal:=0;
   setpalette(brown,random(65));
  end;
  if keypressed then begin
   taste :=readkey;
   if (taste='1') and (eins) then begin
    setfillstyle(1,lightgray);
    bar (10,100,30,130);
    setcolor(darkgray);
    settextstyle(0,0,1);
    ubuttonschrift(10,100,30,130,'1');
    setcolor(white);
    settextstyle(3,0,5);
    readtext(250,180,akspieler.name);
    setcolor(white);
    readtext(320,310,akspieler.passwort);
    pal:=40000;
    nummer:=1;
   end;
   if (taste='2') and (zwei) then begin
    setfillstyle(1,lightgray);
    setcolor(darkgray);
    settextstyle(0,0,1);
    bar (10,163,30,193);
    ubuttonschrift(10,163,30,193,'2');
    setcolor(white);
    settextstyle(3,0,5);
    readtext(250,180,akspieler.name);
    setcolor(white);
    readtext(320,310,akspieler.passwort);
    pal:=40000;
    nummer:=2;
   end;
   if (taste='3') and (drei) then begin
    setfillstyle(1,lightgray);
    setcolor(darkgray);
    settextstyle(0,0,1);
    bar (10,226,30,256);
    ubuttonschrift(10,226,30,256,'3');
    setcolor(white);
    settextstyle(3,0,5);
    readtext(250,180,akspieler.name);
    setcolor(white);
    readtext(320,310,akspieler.passwort);
    pal:=40000;
    nummer:=3;
   end;
   if (taste='4') and (vier) then begin
    setfillstyle(1,lightgray);
    setcolor(darkgray);
    settextstyle(0,0,1);
    bar (10,289,30,319);
    setcolor(white);
    ubuttonschrift(10,289,30,319,'4');
    setcolor(white);
    settextstyle(3,0,5);
    readtext(250,180,akspieler.name);
    setcolor(white);
    readtext(320,310,akspieler.passwort);
    pal:=40000;
    nummer:=4;
   end;
   if (taste='5') and (funf) then begin
    setfillstyle(1,lightgray);
    setcolor(darkgray);
    settextstyle(0,0,1);
    bar (10,352,30,382);
    setcolor(white);
    ubuttonschrift(10,352,30,382,'5');
    setcolor(white);
    settextstyle(3,0,5);
    readtext(250,180,akspieler.name);
    setcolor(white);
    readtext(320,310,akspieler.passwort);
    pal:=40000;
    nummer:=5;
   end;
   if (taste='6') and (sechs) then begin
    setfillstyle(1,lightgray);
    setcolor(darkgray);
    settextstyle(0,0,1);
    bar (10,415,30,445);
    setcolor(white);
    ubuttonschrift(10,415,30,445,'6');
    setcolor(white);
    settextstyle(3,0,5);
    readtext(250,180,akspieler.name);
    setcolor(white);
    readtext(320,310,akspieler.passwort);
    pal:=40000;
    nummer:=6;
   end;
  end;
  pal:=pal+1;
 until pal=40001;
end;

procedure rassewahlen;
var pal : Word;
    taste : Char;
    Erd,Scha,Vor,Mim,Nar,Zent : Boolean;
    sp : TSpieler;
    f  : file of Tspieler;

begin
 erd:=true;
 scha:=true;
 vor:=true;
 mim:=true;
 nar:=true;
 zent:=true;
 if fileexists(akverz+'\babylon\spieler.1') then begin
  assign(f,akverz+'\babylon\spieler.1');
  reset(f);
  read(f,sp);
  if sp.rasse=erdallianz then erd:=false;
  if sp.rasse=schatten then scha:=false;
  if sp.rasse=vorlonen then vor:=false;
  if sp.rasse=mimbari then mim:=false;
  if sp.rasse=naren then nar:=false;
  if sp.rasse=zentauri then zent:=false;
  close(f);
 end;
 if fileexists(akverz+'\babylon\spieler.2') then begin
  assign(f,akverz+'\babylon\spieler.2');
  reset(f);
  read(f,sp);
  if sp.rasse=erdallianz then erd:=false;
  if sp.rasse=schatten then scha:=false;
  if sp.rasse=vorlonen then vor:=false;
  if sp.rasse=mimbari then mim:=false;
  if sp.rasse=naren then nar:=false;
  if sp.rasse=zentauri then zent:=false;
  close(f);
 end;
 if fileexists(akverz+'\babylon\spieler.2') then begin
  assign(f,akverz+'\babylon\spieler.2');
  reset(f);
  read(f,sp);
  if sp.rasse=erdallianz then erd:=false;
  if sp.rasse=schatten then scha:=false;
  if sp.rasse=vorlonen then vor:=false;
  if sp.rasse=mimbari then mim:=false;
  if sp.rasse=naren then nar:=false;
  if sp.rasse=zentauri then zent:=false;
  close(f);
 end;
 if fileexists(akverz+'\babylon\spieler.3') then begin
  assign(f,akverz+'\babylon\spieler.3');
  reset(f);
  read(f,sp);
  if sp.rasse=erdallianz then erd:=false;
  if sp.rasse=schatten then scha:=false;
  if sp.rasse=vorlonen then vor:=false;
  if sp.rasse=mimbari then mim:=false;
  if sp.rasse=naren then nar:=false;
  if sp.rasse=zentauri then zent:=false;
  close(f);
 end;
 if fileexists(akverz+'\babylon\spieler.4') then begin
  assign(f,akverz+'\babylon\spieler.4');
  reset(f);
  read(f,sp);
  if sp.rasse=erdallianz then erd:=false;
  if sp.rasse=schatten then scha:=false;
  if sp.rasse=vorlonen then vor:=false;
  if sp.rasse=mimbari then mim:=false;
  if sp.rasse=naren then nar:=false;
  if sp.rasse=zentauri then zent:=false;
  close(f);
 end;
 if fileexists(akverz+'\babylon\spieler.5') then begin
  assign(f,akverz+'\babylon\spieler.5');
  reset(f);
  read(f,sp);
  if sp.rasse=erdallianz then erd:=false;
  if sp.rasse=schatten then scha:=false;
  if sp.rasse=vorlonen then vor:=false;
  if sp.rasse=mimbari then mim:=false;
  if sp.rasse=naren then nar:=false;
  if sp.rasse=zentauri then zent:=false;
  close(f);
 end;
 if fileexists(akverz+'\babylon\spieler.6') then begin
  assign(f,akverz+'\babylon\spieler.6');
  reset(f);
  read(f,sp);
  if sp.rasse=erdallianz then erd:=false;
  if sp.rasse=schatten then scha:=false;
  if sp.rasse=vorlonen then vor:=false;
  if sp.rasse=mimbari then mim:=false;
  if sp.rasse=naren then nar:=false;
  if sp.rasse=zentauri then zent:=false;
  close(f);
 end;
 cleardevice;
 settextstyle(0,0,1);
 if erd then begin
  setfillstyle(1,darkgray);
  bar (10,100,30,130);
  setcolor(white);
  buttonschrift(10,100,30,130,'1');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,100,30,130);
  setcolor(darkgray);
  buttonschrift(10,100,30,130,'1');
 end;
 if scha then begin
  setfillstyle(1,darkgray);
  bar (10,163,30,193);
  setcolor(white);
  buttonschrift(10,163,30,193,'2');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,163,30,193);
  setcolor(darkgray);
  buttonschrift(10,163,30,193,'2');
 end;
 if vor then begin
  setfillstyle(1,darkgray);
  bar (10,226,30,256);
  setcolor(white);
  buttonschrift(10,226,30,256,'3');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,226,30,256);
  setcolor(darkgray);
  buttonschrift(10,226,30,256,'3');
 end;
 if mim then begin
  setfillstyle(1,darkgray);
  bar (10,289,30,319);
  setcolor(white);
  buttonschrift(10,289,30,319,'4');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,289,30,319);
  setcolor(darkgray);
  buttonschrift(10,289,30,319,'4');
 end;
 if nar then begin
  setfillstyle(1,darkgray);
  bar (10,352,30,382);
  setcolor(white);
  buttonschrift(10,352,30,382,'5');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,352,30,382);
  setcolor(darkgray);
  buttonschrift(10,352,30,382,'5');
 end;
 if zent then begin
  setfillstyle(1,darkgray);
  bar (10,415,30,445);
  setcolor(white);
  buttonschrift(10,415,30,445,'6');
 end
 else begin
  setfillstyle(1,lightgray);
  bar (10,415,30,445);
  setcolor(darkgray);
  buttonschrift(10,415,30,445,'6');
 end;
 settextstyle(2,0,5);
 if erd then begin
  setcolor(white);
  outtextxy(50,109,'Erdallianz'); {Schatten aufhalten, guter Anfang}
 end
 else begin
  setcolor(lightgray);
  outtextxy(50,109,'Erdallianz');
 end;
 if scha then begin
  setcolor(white);
  outtextxy(50,170,'Schatten'); {Jeden besiegen, keine Alianz auáer mit}
 end                            {Zentauri, schlechter Anfang}
 else begin
  setcolor(lightgray);
  outtextxy(50,170,'Schatten');
 end;
 if vor then begin
  setcolor(white);
  outtextxy(50,232,'Vorlonen'); {schwer Anlianz (Schiffbergabe), schlechter}
 end                            {Anfang}
 else begin
  setcolor(lightgray);
  outtextxy(50,232,'Vorlonen');
 end;
 if mim then begin
  setcolor(white);
  outtextxy(50,295,'Mimbari'); {Schatten aufhalten, guter Anfang}
 end
 else begin
  setcolor(lightgray);
  outtextxy(50,295,'Mimbari');
 end;
 if nar then begin
  setcolor(white);
  outtextxy(50,359,'Naren'); {Zentauri aufhalten, mittlerer Anfang}
 end
 else begin
  setcolor(lightgray);
  outtextxy(50,359,'Naren');
 end;
 if zent then begin
  setcolor(white);
  outtextxy(50,421,'Zentauri'); {Jeden besiegen, keine Alianz auáer Schatten}
 end                            {guter Anfang}
 else begin
  setcolor(lightgray);
  outtextxy(50,421,'Zentauri');
 end;
 settextstyle(1,0,5);
 setcolor(brown);
 zentertext(0,0,getmaxx,100,'Rasse w„hlen');
 pal:=0;
 repeat
  if pal=20000 then begin
   pal:=0;
   setpalette(brown,random(65));
  end;
  if keypressed then begin
   taste:=readkey;
   if taste=escape then pal:=30000;
   if (taste='1') and (erd) then begin
    akspieler.rasse:=Erdallianz;
    pal:=30000;
   end;
   if (taste='2') and (scha) then begin
    akspieler.rasse:=Schatten;
    pal:=30000;
   end;
   if (taste='3') and (vor) then begin
    akspieler.rasse:=Vorlonen;
    pal:=30000;
   end;
   if (taste='4') and (mim) then begin
    akspieler.rasse:=Mimbari;
    pal:=30000;
   end;
   if (taste='5') and (nar) then begin
    akspieler.rasse:=Naren;
    pal:=30000;
   end;
   if (taste='6') and (zent) then begin
    akspieler.rasse:=Zentauri;
    pal:=30000;
   end;
  end;
  pal:=pal+1;
 until pal=30001;
 cleardevice;
end;

procedure speichern;
var f : file of TSpieler;

begin
 if nummer=1 then assign(f,akverz+'\babylon\spieler.1');
 if nummer=2 then assign(f,akverz+'\babylon\spieler.2');
 if nummer=3 then assign(f,akverz+'\babylon\spieler.3');
 if nummer=4 then assign(f,akverz+'\babylon\spieler.4');
 if nummer=5 then assign(f,akverz+'\babylon\spieler.5');
 if nummer=6 then assign(f,akverz+'\babylon\spieler.6');
 rewrite(f);
 write(f,akspieler);
 close(f);
end;

procedure planetwahlen;
var lv1,nummer: Laufvar;
    pl : TPlanet;
begin
 lv1:=0;
 cleardevice;
 repeat
  read(karte,pl);
  x[lv1]:=pl.x;
  y[lv1]:=pl.y;
  putpixel(x[lv1],y[lv1],white);
  lv1:=lv1+1;
 until eof(karte);
 nummer:=600;
 mouseinit;
 mouseshow;
 repeat
  for lv1:=0 to 499 DO begin
   If (Mousexpos=x[lv1]) and (mouseypos=y[lv1]) and (mousebutton=mousebuttonleft) then begin
    if pl.rasse=keine then nummer:=lv1;
   end;
  end;
 until nummer<>600;
 pl.bevolk.anzahl:=1000000;
 pl.bevolk.stimmung:=freundlich;
 seek(karte,nummer);
 read(karte,pl);
 pl.rasse:=akspieler.rasse;
 seek(karte,nummer);
 write(karte,pl);
end;

begin
 getdir(0,akverz);
 assign(karte,akverz+'\babylon\karte');
 reset(karte);
 grd:=detect;
 initgraph(grd,grm,'');
 Spielerwahlen;
 Rassewahlen;
 planetwahlen;
 speichern;
 close(karte);
 closegraph;
end.