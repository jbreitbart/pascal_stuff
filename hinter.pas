{$A-,B-,D+,E+,F-,G+,I+,L+,N+,O-,R+,S+,V+,X-}
{$M 56384,0,655360}
Program Jensman_und_Benflashs_Hintergrundmaker;

Uses crt,dos,graph,alles,editor;

var pixel:array [0..15999] of byte;
    grm,grd :integer;
    aktuellef : Byte;
    ymin,xm,ym,aktuellerp,zaehlen : WORD;
    buh,leisteoben : Boolean;

procedure kaesten;                             

var x,y : Integer;

begin
 setactivepage(1);
 mousehide;
 for x := 0 to getmaxx DO
 for y := 0 to getmaxy DO
 Begin
  putpixel(x,y,white);
 end;
 for x := 0 to getmaxx DO
 for y := 0 to 20 DO
 begin
  putpixel(x,y,black);
 end;
 for x := 0 to 20 DO
 for y := 0 to getmaxy DO
 begin
  putpixel(x,y,black);
 end;
 for x := 0 to getmaxx DO
 for y := (getmaxy - 27) to getmaxy DO
 begin
  putpixel(x,y,black);
 end;
 for x := (getmaxx- 22) to getmaxx DO
 for y := 0 to getmaxy DO
 begin
  putpixel(x,y,black);
 end;
 y:= 30;
 zaehlen :=0;
 setcolor(25);
 repeat
  line(30,y,getmaxx-33,y);
  y := y + 7;
  zaehlen := zaehlen +1;
 until zaehlen=101;
 x:= 30;
 zaehlen := 0;
 repeat {runter}
  line (x,30,x,getmaxy-37);
  x := x + 6;
  zaehlen := zaehlen +1;
 until zaehlen=161;
 setvisualpage(1);
 mouseshow;
end;

procedure leer;
var a : word;

begin
 a:=0;
 repeat
  pixel[a] := aktuellef;
  a:= a + 1;
 until a = 15999+1;
end;

procedure leisteu;

var untenx,unteny : Word;
begin
 mousehide;
 for untenx := 20 to (getmaxx-22) DO
 for unteny := (getmaxy - 26) to getmaxy DO putpixel(untenx,unteny,aktuellef);
 mouseshow;
end;

procedure leisteo;

var a,b,x,y,zaehlen : Integer;

label ende;

procedure save;

var i : word;
    f : file of byte;
    name : String;
    janein:String;
    dirinfo:Searchrec;

label a,b;

begin
 mousehide;
 textmode(3);
 a:
 write('Bitte geben sie den Datei Namen ein (ohne Erweiterung) : ');
 write('         .mip');
 gotoxy(58,1);
 window(58,1,58+8,1);
 readln(Name);
 name:=name+'.mip';
 findfirst(name,archive,dirinfo);
 if Doserror = 0 then begin
                       write('Datei existier bereits Åberschreiben(j/n) ');
                       readln(janein);
                       gross(janein);
                       if janein='N' then goto a;
                       if janein='J' then goto b;
                      end
  else
  begin
   b:
   assign(f,'Bild.MIP'); {Mirrow Imitation Picture}
   rewrite(f);
   for i:=0 to 15999 DO
   begin
    write(f,pixel[i]);
   end;
   close(f);
  end;
 grd:= InstallUserDriver('vesa', nil);
 grm:= 4;
 initgraph(grd,grm,'');
 aktuellef:=white;
 kaesten;
 mouseshow;
end;

procedure load;

var i : word;
    f : file of byte;
    name : String;
    dirinfo : Searchrec;

begin
 mousehide;
 textmode(3);
 write('Bitte geben sie den Datei Namen ein (ohne Erweiterung) : ');
 write('         .mip');
 gotoxy(58,1);
 window(58,1,58+8,1);
 readln(name);
 name:=name+'.mip';
 findfirst(name,archive,dirinfo);
 if Doserror <> 0 then begin
                        writeln ('Datei nicht gefunden');
                        grd:= InstallUserDriver('vesa', nil);
                        grm:= 4;
                        initgraph(grd,grm,'');
                        kaesten;
                        leer;
                       end
 else
 begin
  grd:= InstallUserDriver('vesa', nil);
  grm:= 4;
  initgraph(grd,grm,'');
  kaesten;
  assign(f,name);
  reset(f);
  for i:=0 to 15999 DO
  begin
   read(f,pixel[i]);
   pixelf(i,pixel[i]);
  end;
  close(f);
 end;
 mouseshow;
end;


procedure weck;

var i,x,y : Word;

begin
 mousehide;
 for x:=0  to getmaxx DO
 for y:=0  to 20 DO putpixel(x,y,black);
 FOR x:=21 to getmaxx-25 DO
 for y:=21 to 29 DO putpixel(x,y,white);
 FOR x:=21 to 29 DO
 FOR y:=29 to 60 DO putpixel(x,y,white);
 FOR x:=getmaxx-33 to getmaxx-23 DO
 FOR y:=21 to 60 DO Putpixel(x,y,white);
 FOR x:=0 to 20 DO
 for y:=21 to 60 DO putpixel(x,y,black);
 FOR x:=getmaxx-22 to getmaxx DO
 FOR y:=21 to 60 DO Putpixel(x,y,black);
 y:= 30;
 zaehlen :=0;
 setcolor(25);
 repeat
  line(30,y,getmaxx-33,y);
  y := y + 7;
  zaehlen := zaehlen +1;
 until zaehlen=101;
 x:= 30;
 zaehlen := 0;
 repeat {runter}
  line (x,30,x,getmaxy-37);
  x := x + 6;
  zaehlen := zaehlen +1;
 until zaehlen=161;
 mouseshow;
end;

begin
 if leisteoben=false then begin
  leisteoben:=true;
  mousehide;
  rectangle (1,1,getmaxx,60);
  FOR a:= 1 to getmaxx DO
  for b:= 1 to 60 DO putpixel(a,b,28);
  settextstyle(2,0,9);
  setcolor(0);
  outtextxy (22,17,'LOAD');
  rectangle (10,14,100,56);
  outtextxy (122,17,'SAVE');
  rectangle (110, 14, 200, 56);
  outtextxy (230,17,'NEW');
  rectangle (210,14,300,56);
  outtextxy (320,17,'WERBUNG');
  rectangle (310,14,449,56);
  outtextxy (469,17,'ERHEITERUNG');
  rectangle (459,14,670,56);
  outtextxy (922,17,'QUIT');
  rectangle (910,14,1000,56);
 end;
 mousewindow(0,0,getmaxx,60);
 mouseshow;
 repeat
  if mouseinwindow(10,14,100,56) and (MOUSEBUTTON=MOUSEBUTTONLEFT) then begin {Laden}
                                                                         load;
                                                                         mousewindow(0,0,getmaxx,getmaxy);
                                                                         goto ende;
                                                                        end;
  if Mouseinwindow(110,14,200,56) and (Mousebutton=mousebuttonleft) then begin {Speichern}
                                                                          save;
                                                                          mousewindow(0,0,getmaxx,getmaxy);
                                                                          goto ende;
                                                                         end;
  if mouseinwindow(210,14,300,56) and (mousebutton=mousebuttonleft) then begin {Neu}
                                                                          aktuellef:=white;
                                                                          leer;
                                                                          kaesten;
                                                                          mousewindow(0,0,getmaxx,getmaxy);
                                                                          leisteu;
                                                                          goto ende;
                                                                         end;
  if mouseinwindow(310,14,423,56) and (mousebutton=mousebuttonleft) then halt; {Werbung}
  if Mouseinwindow(459,14,670,56) and (Mousebutton=mousebuttonleft)  then halt; {Erheiterung}
  if mouseinwindow(910,14,1000,56) and (mousebutton=mousebuttonleft) then begin {Beenden}
                                                                           closegraph;
                                                                           halt;
                                                                          end;
 until 2=3;
 ende:
 leisteoben:=false;
 mouseshow;
end;

procedure pixelf (nummer : Word;c:Byte);

var q,w : Byte;
    startx,starty,a,min,max,b,y,l : Word;
    stop,ganz : Boolean;

begin
 if nummer < 16001 then begin
  stop:=false;
  startx:=0;
  starty:=0;
  a:=31;
  min:=0;
  max:=160;
  y:=0;
  repeat
   repeat
    if (y=nummer) then startx:=a;
    a:=a+6;
    y:=y+1;
    if y>=max then stop:=true;
   until (startx <> 0) or stop;
  stop:=false;
  max:=max+160;
  a:=31;
  until startx <> 0 ;
  a:=0;
  l:=0;
  ganz:=false;
  repeat
   b:=31;
   repeat
    if (nummer = a) then starty:=b;
    a:=a+160;
    b:=b+7;
    if (starty <> 0) or (a>=16000) then stop := true;
   until stop;
   l:=l+1;
   a:=l;
   stop:=false;
   ganz:=false;
  if (starty <> 0) then ganz := true;
  until ganz;
  pixel[nummer]:=c;
  mousehide;
  q:=0;
  w:=0;
  FOR q := 0 to 4 DO
  for w := 0 to 5 DO putpixel (startx+q,starty+w,c);
  mouseshow;
 end;
end;

procedure test;

var z : Word;
    c : Byte;

begin
 z:=0;
 c:=0;
 FOR z := 0 to 16000 DO
 begin
  if c = 255 then c:=0;
  c := c+1;
  if round(z/160) = z/160 then
  pixelf(z,c);
  if keypressed then exit;
 end;
 mousehide;
 mouseshow;
 z:=0;
end;

procedure pixelbestimmen (var pix:WORD);

var ix,iy : Integer;
    xmin,xmax,ymin,ymax,pixold,zaehler :WORD;

begin
 pixold:=pix;
 ymin:=30;
 ymax:=36;
 xmin:=30;
 xmax:=35;
 zaehler:=0;
 iy:=0;
  repeat
   if (zaehler<>0) and (ROUND(ZAEHLER/160)=(ZAEHLER/160)) then begin
                                                                xmin:=30;
                                                                xmax:=35;
                                                                ymin:=ymin+7;
                                                                ymax:=ymin+6;
                                                                ix:=0;
                                                               end;
   if (xm>=xmin) and (xm<=xmax) and (ym>=ymin) and (ym<=ymax) then pix:=zaehler
   else
   begin
    xmin:=xmin+6;
    xmax:=xmin+5;
   end;
   if pix<>pixold then exit;
   zaehler:=zaehler+1;
   ix:=ix+1;
  until ix = 161;
end;

procedure farbpallette;

var a,b : Integer;
    d,c,alt : word;
    ba : Boolean;

procedure weck;

var x,y : word;

begin
 mousehide;
 for x := 0 to 20 DO
 for y := 0 to getmaxy DO putpixel(x,y,black);
 for x:= 0 to 60 DO
 for y:= 0 to 20 DO putpixel(x,y,black);
 for x := 21 to 30 DO
 for y := 21 to getmaxy-28 DO putpixel(x,y,white);
 for x:= 21 to 60 DO
 for y:= getmaxy-37 to getmaxy-28 DO putpixel(x,y,white);
 for x:= 21 to 60 DO
 for y:= 21 to 30 DO putpixel(x,y,white);
 setcolor(black);
 line(20,getmaxy-27,getmaxx,getmaxy-27);
 x:=0;
 y:=0;
 repeat
  for y:= 0 to 6 DO pixelf(x+y,pixel[x+y]);
  x:=x+160;
  y:=0;
 until x>15900;
 x:=0;
 y:=30;
 zaehlen:=0;
 setcolor(25);
 repeat
  line(30,y,getmaxx-33,y);
  y := y + 7;
  zaehlen := zaehlen +1;
 until zaehlen=101;
 x:= 30;
 zaehlen := 0;
 repeat {runter}
  line (x,30,x,getmaxy-37);
  x := x + 6;
  zaehlen := zaehlen +1;
 until zaehlen=161;
 mouseshow;
end;

procedure farbebestimmen;

var xmin,xmax,ymin,ymax,f : Word;

begin
 mousewindow(0,0,60,getmaxy);
 xmin:=0;
 xmax:=60;
 ymin:=45;
 ymax:=ymin+5;
 f:=0;
 repeat
  if mousebutton=mousebuttonleft then begin
  repeat
    if mouseinwindow(xmin,ymin,xmax,ymax) and (mousebutton=mousebuttonleft) then begin
                                                                                   aktuellef:=f;
                                                                                   exit;
                                                                                  end;
    if f <= 16 then f:=f+1
    else f:=f+3;
    ymin:=ymin+7;
    ymax:=ymin+5;
  until f >=255;
 end;
 until f >=255;
end;

begin
 ba:=false;
 mousewindow(0,0,60,getmaxy);
 alt:=aktuellef;
 mousehide;
 for a:=0 to 60 DO
 for b:=0 to getmaxy DO putpixel (a,b,28);
 c:=0;
 d:=45;
 repeat
  for a:= 10 to 50 DO
  for b:= d to d+5 DO putpixel (a,b,c);
  if c <= 16 then c:=c+1
  else c:=c+3;
  d:=d+7;
 until c >= 255;
 mouseshow;
 repeat
  if mouseinwindow(0,0,60,getmaxy) and (mousebutton=mousebuttonleft) then begin
                                                                           farbebestimmen;
                                                                           ba:=true;
                                                                          end;
 until ba;
 mousewindow(0,0,getmaxx,getmaxy);
 weck;
 leisteu;
 mouseshow;
end;

begin
  checkbreak:=false;
  aktuellef:=white;
  aktuellerp:=16001;
  leer;
  leisteoben:=false;
  grd:= InstallUserDriver('vesa', nil);
  grm:= 4;
  initgraph (grd,grm, '');
  Mouseinit;
  mousegotoxy(30,30);
  mousehide;
  intro;
  delay (4500);
  mouseshow;
  kaesten;
  leisteu;
  mouseshow;
  repeat
   xm:=mousexpos;
   ym:=mouseypos;
   if mouseinwindow(0,0,getmaxx,20) and (MOUSEBUTTON=Mousebuttonright) then leisteo;
   if (mouseinwindow(0,20,20,getmaxy-20)) and (mousebutton=mousebuttonright) then farbpallette;
   if (mousebutton=mousebuttonleft) and mouseinwindow(30,30,getmaxx-32,getmaxy-36) then
                                                begin
                                                 pixelbestimmen(aktuellerp);
                                                 pixelf(aktuellerp,aktuellef);
                                                 aktuellerp:=16001;
                                                end;
   if (mousebutton=mousebuttonright) and (aktuellef=255) then begin
                                                               aktuellef :=0;
                                                               leisteu;
                                                               buh:=true;
                                                              end;
   if (mousebutton=mousebuttonright) and (buh=false) then begin
                                                           aktuellef:=aktuellef+1;
                                                           leisteu;
                                                          end;

   buh:=false;
  until 2=3;
  mousehide;
  closegraph;
end.
spÑter programmieren mit
Treiber:=InstallUserDriver('SVGA256',NIL);
modus:=0;

ERROR 202