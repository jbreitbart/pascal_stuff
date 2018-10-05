Unit RiseTpu;

interface

uses crt,graph,dos,alles;

type TPreise=0..54;
     TDatei = String[8];
     TForschung = record
      Name : String[28];
      Zeit : Word;
      Text1,text2,text3,text4 : String [41];
      datei : string [8];
     end;
	color=RECORD        { A palette 'cell' }
		r,g,b: byte
	END;
	palette=ARRAY[0..255] OF color;   { a complete, 256-color palette }

CONST
	background=0; { index of palette corresponding to background }
	grey10:     color=(r: 6;  g: 6;  b: 6 );
	grey20:     color=(r: 13; g: 13; b: 13); { grayscale -- percentages }
	grey30:     color=(r: 19; g: 19; b: 19);
	grey40:     color=(r: 25; g: 25; b: 25);
	grey50:     color=(r: 32; g: 32; b: 32);
	grey60:     color=(r: 38; g: 38; b: 38);
	grey70:     color=(r: 45; g: 45; b: 45);
	grey80:     color=(r: 51; g: 51; b: 51);
	grey90:     color=(r: 57; g: 57; b: 57);
	white1:      color=(r: 63; g: 63; b: 63); { maximum intensity }
	red1:        color=(r: 63; g: 0;  b: 0 ); { primary colors }
	green1:      color=(r: 0;  g: 63; b: 0 );
	blue1:       color=(r: 0;  g: 0;  b: 63);
	yellow1:     color=(r: 63; g: 63; b: 0 ); { secondary colors }
	cyan1:       color=(r: 0;  g: 63; b: 63);
	purple1:     color=(r: 63; g: 0;  b: 63);
	orange1:     color=(r: 63; g: 32; b: 0 ); { tertiary colors }
	chartreuse1: color=(r: 32; g: 63; b: 0 ); { quite uncommon... }
	jade1:       color=(r: 0;  g: 63; b: 32);
	robin1:      color=(r: 0;  g: 32; b: 63);
	periwinkle1: color=(r: 32; g: 0;  b: 63);
	magenta1:    color=(r: 63; g: 0;  b: 32); { not typical, but accurate }
	black1:      color=(r: 0;  g: 0;  b: 0 ); { list of standard colors }

	color16map: ARRAY[0..15] OF byte =
	(0,1,2,3,4,5,20,7,56,57,58,59,60,61,62,63);


var Name,Planet,akverz :String;
    anders             : Boolean;
    geld,einwohner,nahrungvorat,geratvorat,baumatvorat : Longint;
    Nahrungkaufen,geratkaufen,baumatkaufen,nahrungverkaufen,geratverkaufen,baumatverkaufen:Word;
    handlernah,handlergerat,handlerbau : LongInt;
    Nahrungpreis,nahrungverpreis,geratpreis,geratverpreis,baumatpreis,baumatverpreis : TPreise;
    grundPalette : PaletteType;
    Waffend,Ausrd,Gebd,Fahrd         : file of TForschung;
    Waffenforb,ausrforb,Gebforb,Fahrforb : Boolean;
    akFor                            : TForschung;
    WasFor                           : 0..4;
    prozentfor                       : Real;

procedure Titelbild;
procedure ladenmip(s : String);
Procedure Sterneb;
Procedure Ray;
Procedure Nameeingeben;
Procedure Planetenname;
procedure spielende;
Procedure Kaufen;
Procedure Verkaufen;
Procedure Storry;
procedure ladenfor(x,y : Word;verz : String;Name : Tdatei);
procedure Forschungwahlen;
Procedure Forschung;
procedure sylvester;

IMPLEMENTATION

procedure sylvester;
VAR
	r: Registers;

PROCEDURE AssignColor(index: byte; c: color);
BEGIN
	r.ax:=$1010;
	r.bh:=0;
	r.bl:=index;
	r.dh:=c.r;
	r.ch:=c.g;
	r.cl:=c.b;
	intr($10,r)
END;

PROCEDURE Assign16Color(index: byte; c: color);
BEGIN
	r.ax:=$1010;
	r.bh:=0;
	r.bl:=color16map[index];
	r.dh:=c.r;
	r.ch:=c.g;
	r.cl:=c.b;
	intr($10,r)
END;

PROCEDURE SetColors(p: palette; i,c: byte; n: word);
BEGIN
	r.ax:=$1012;
	r.bh:=0;
	r.bl:=c;
	r.cx:=n;
	r.es:=Seg(p);
	r.dx:=Ofs(p[0])+i*3;
	intr($10,r)
END;

PROCEDURE Set16Colors(p: palette; i,c: byte; n: word);
VAR t: Palette;
	 j: integer;
BEGIN
	FOR j:=1 TO n DO
		t[color16map[j+c-1]]:=p[j+i-1];
	SetColors(t,color16map[i],color16map[c],color16map[c+n-1]-color16map[c]+1)
END;

{$I-}
PROCEDURE LoadColors(fn: STRING; VAR p: palette);
VAR f: Text;
	 i,r,g,b: byte;
BEGIN
	Assign(f,fn);
	Reset(f);
	FOR i:=0 TO 255 DO
	BEGIN
		readln(f,r,g,b);
		p[i].r:=r div 4;
		p[i].g:=g div 4;
		p[i].b:=b div 4
	END;
	Close(f)
END;

PROCEDURE SaveColors(fn: STRING; p: palette);
VAR f: Text;
	 i: byte;
BEGIN
	Assign(f,fn);
	Rewrite(f);
	FOR i:=0 TO 255 DO
		writeln(f,p[i].r*4,p[i].g*4,p[i].b*4);
	Close(f)
END;
{$I+}

PROCEDURE SetRGB(VAR c: color; r,g,b: byte);
BEGIN
	c.r:=r*63 div 100;  { rather simple, really -- just convert % into }
	c.g:=g*63 div 100;  { BIOS mapping 0-63 }
	c.b:=b*63 div 100
END;

PROCEDURE GetRGB(c: color; VAR r,g,b: byte);

BEGIN
	r:=c.r*100 div 63;
	g:=c.g*100 div 63;
	b:=c.b*100 div 63
END;

PROCEDURE SetHSI(VAR c: color; h: word; s,i: byte);
{ Completely self-explanatory, in my opinion }
VAR r,g,b,t: real;
BEGIN
	t:=Pi*H/180;
	r:=1+s/100*sin(t-2*pi/3);
	g:=1+s/100*sin(t);
	b:=1+s/100*sin(t+2*pi/3);
	t:=63.999*i/200;
	c.r:=trunc(r*t);
	c.g:=trunc(g*t);
	c.b:=trunc(b*t)
END;

PROCEDURE Mix(VAR p,c1: color; p1: byte; c2: color; p2: byte);
BEGIN
	p.r:=(c1.r*p1+c2.r*p2) div 100; { just do a weighted average }
	p.g:=(c1.g*p1+c2.g*p2) div 100;
	p.b:=(c1.b*p1+c2.b*p2) div 100
END;

PROCEDURE Tint(VAR p: color; c,t: color);
BEGIN
	p.r:=c.r*t.r div 63;   { brings out components, really }
	p.g:=c.g*t.g div 63;
	p.b:=c.b*t.b div 63
END;

FUNCTION Intensity(c: color): byte;
BEGIN
	Intensity:=(c.r+c.g+c.b)*100 div 191 { really dumb function }
END;

PROCEDURE Contrast(VAR p: color; c: color; pt: byte);
VAR i: byte;
BEGIN
	i:=Intensity(c)*63 div 100;
	p.r:=c.r+(i-c.r)*pt div 100;  { just moves away/closer to grey }
	p.g:=c.g+(i-c.g)*pt div 100;
	p.b:=c.b+(i-c.b)*pt div 100
END;

PROCEDURE Range(VAR p: palette; i1,i2: byte);
VAR i: byte;
BEGIN
	FOR i:=i1 TO i2 DO { simple averaging loop }
		Mix(p[i],p[i1],(i2-i)*100 div (i2-i1),p[i2],(i-i1)*100 div (i2-i1))
END;

PROCEDURE SetBorder(c: byte);
BEGIN
	r.ax:=$1001;
	r.bh:=c;
	intr($10,r);
END;

type
	ppack=^pack;
	pload=^load;
	pack=record
		num: integer;
		vary: integer;
		stuff: pload;
		boost: integer;
		next: ppack;
	end;
	load=record
		name: string[30];
		flash: boolean;
		cont: ppack;
		cset: byte;
		decay: byte;
		grav: longint;
		next: pload;
		gnext: pload;
	end;
	ppix=^pix;
	pix=record
		x,y,dx,dy: longint;
		k: byte;
		l: pload;
		last,next: ppix;
	end;
const
	sh=16;
	mul=65536;
	csize=64;
        LineMode   = $00;
        FillMode   = $40;
        ImageMode  = $C0;
        BackColor  = 24;
        Mode480    = 2;  {640x480x256}
        driver: integer = 0;
        mode: integer = 0;
        result: integer = 0;

var
	disp: ppix;
	batt: pload;
	parts: pload;
	count,loads: integer;
	sina,cosa: array[0..360] of longint;
	test,spark: load;
	testpack: pack;
	launch: pix;
	maxx,maxy: integer;
	f: text;

procedure addpix(d: pix);
var p: ppix;
begin
	new(p);
	p^:=d;
	p^.last:=nil;
	p^.next:=disp;
	if disp<>nil then
		disp^.last:=p;
	disp:=p;
	inc(count);
end;

procedure rempix(p: ppix);
begin
	if p^.last<>nil then
		p^.last^.next:=p^.next
	else
		disp:=p^.next;
	if p^.next<>nil then
		p^.next^.last:=p^.last;
	dispose(p);
	dec(count);
end;

procedure gentrig;
var i: integer;
begin
	for i:=0 to 360 do
	begin
		cosa[i]:=round(cos(pi*i/180)*mul);
		sina[i]:=round(sin(pi*i/180)*mul);
	end;
end;

procedure initpix(from: ppix);
var i: integer;
	 p: pix;
	 th: integer;
	 pp: ppack;
begin
	with from^,from^.l^ do
	begin
		if flash then
		begin
			assigncolor(1,black1);
			assigncolor(0,black1);
    		end;
		p.x:=x;
		p.y:=y;
		pp:=cont;
		while pp<>nil do
		with pp^ do
		begin
			p.l:=stuff;
			for i:=1 to num+random(vary+1)*2-vary do
			with p do
			begin
				k:=random(p.l^.decay);
				th:=random(360);
				dx:=round(cosa[th]*k*boost/p.l^.decay)+from^.dx;
				dy:=round(sina[th]*k*boost/p.l^.decay)+from^.dy;
				addpix(p);
			end;
			pp:=pp^.next;
		end;
	end;
end;

procedure fire;
var i: integer;
begin
	with launch do
	begin
		x:=longint(random(maxx)) shl sh;
		y:=longint(maxy) shl sh;
		if	x>longint(maxx) shl (sh-1) then
			dx:=-round(random*mul)
		else
			dx:=round(random*mul);
		dy:=longint(-5)*mul;
		l:=batt;
		for i:=1 to random(loads) do l:=l^.next;
		k:=0;
		addpix(launch);
	end;
end;

procedure disppix;
var p,q: ppix;
	 xl, yl: longint;
begin
	xl:=longint(maxx) shl sh;
	yl:=longint(maxy) shl sh;
	p:=disp;
	while p<>nil do
	with p^,p^.l^ do
	begin
		q:=p^.next;
		putpixel(x shr sh,y shr sh,1);
		inc(x,dx*maxx div 640);
		inc(y,dy*maxy div 480);
		inc(dy,grav);
		inc(k);
		if (k=decay) or (x<0) or (x>xl) or (y<0) or (y>yl) then
		begin
			if (x>0) and (x<xl) and (y>0) and (y<yl) then
				initpix(p);
			rempix(p);
		end else
		putpixel(x shr sh,y shr sh,(integer(k)*csize div decay)+cset*csize);
		p:=q;
	end;
	delay(20);
	if count=0 then
		fire;
end;

procedure init;
var
	o,m,mm,i: integer;
	s: string;
	col: palette;
begin
        grd:=installuserdriver('vesa',nil);
        grm:=0;
        initgraph(grd,grm,akverz+'\data\');
	setGraphMode(getMaxMode);
	randomize;
	gentrig;
	o:=getmaxmode;
	s:=getmodename(o);
        setgraphmode(2);
	maxx:=getmaxx;
	maxy:=getmaxy;
	count:=0;
	loads:=0;
	col[1]:=grey10;
	col[2]:=white1;
	col[csize-1]:=orange1;
	range(col,2,csize-1);
	col[csize]:=white1;
	col[2*csize-1]:=blue1;
	range(col,csize,2*csize-1);
	col[2*csize]:=white1;
	col[3*csize-1]:=red1;
	range(col,2*csize,3*csize-1);
	col[3*csize]:=white1;
	col[4*csize-1]:=jade1;
	range(col,3*csize,4*csize-1);
	setcolors(col,1,1,4*csize-1);
	disp:=nil;
	parts:=nil;
end;

procedure addload(l: load);
var p: pload;
begin
	new(p);
	p^:=l;
	p^.next:=batt;
	p^.cont:=nil;
	batt:=p;
	p^.gnext:=parts;
	parts:=p;
	inc(loads);
end;
procedure addpart(l: load);
var p: pload;
begin
	new(p);
	p^:=l;
	p^.next:=nil;
	p^.gnext:=parts;
	p^.cont:=nil;
	parts:=p;
end;
procedure addpack(l: pload; k: pack);
var p: ppack;
begin
	new(p);
	p^:=k;
	p^.next:=l^.cont;
	l^.cont:=p;
end;

function findload(n: string): pload;
var p: pload;
begin
	p:=parts;
	n:=copy(n,1,30);
	while (p<>nil) and (p^.name<>n) do
		p:=p^.gnext;
	findload:=p;
end;

{$I-}
function getstr: string;
var s: string;
	 i: integer;
begin
	s:='';
	while ((s='') or (s[1]=' ')) and (not eof(f)) do
	begin
		readln(f,s);
	end;
	for i:=1 to length(s) do
		s[i]:=upcase(s[i]);
	getstr:=s;
end;

function getnum: integer;
var n,nn: integer;
begin
	val(getstr,n,nn);
	getnum:=n;
end;
procedure readfile;
var l: load;
	 p: pack;
	 s,t: string;
begin
	assign(f,akverz+'\data\sylv.J&B');
	reset(f);
	while not eof(f) do
	begin
		s:=getstr;
		l.name:=getstr;
		t:=getstr;
		l.flash:=(t='FLASH');
		t:=getstr;
		if t='RED' then l.cset:=2;
		if t='YELLOW' then l.cset:=0;
		if t='GREEN' then l.cset:=3;
		if t='BLUE' then l.cset:=1;
		l.decay:=getnum;
		l.grav:=getnum;
		l.grav:=l.grav*mul div 100;
		if s='FIREWORK' then addload(l) else addpart(l);
		s:=getstr;
		while s<>'END' do
		begin
			p.stuff:=findload(s);
			p.num:=getnum;
			p.vary:=getnum;
			p.boost:=getnum;
			addpack(parts,p);
			s:=getstr;
		end;
	end;
	close(f);
end;
{$I+}

begin
 closegraph;
	init;
	readfile;
	repeat
		cleardevice;
		while not keypressed do disppix;
	until keypressed;
        closegraph;
        grd:=detect;
        initgraph(grd,grm,'');
end;

Procedure Forschung;
var waf,wirt,fahr,ge,zu : Boolean;

Procedure Waffenonline;
begin
 if wasfor <> 1 then begin
  setcolor(4);
  settextstyle(3,0,2);
  Zentertext(255,85,595,455,'Wird zur Zeit nicht erforscht !');
 end;
 if wasfor = 1 then begin
  ladenfor(350,280,akverz,akfor.datei);
  setcolor(9);
  rectangle (260,420,590,440);
  prozentfor:=50;
  setfillstyle(1,14);
  prozentbar (261,421,589,439,prozentfor);
  setfillstyle(1,0);
  verzierrechteck (349,279,500,380);
  ladenfor(350,280,akverz,akfor.datei);
  setcolor(red);
  zentertext(260,420,590,440,realtostr(prozentfor)+' %');
  settextstyle(2,0,7);
  Zentertext(255,90,595,120,akfor.name);
  settextstyle(2,0,5);
  outtextxy(260,140,akfor.text1); {41 Zeichen}
  outtextxy(260,160,akfor.text2);
  outtextxy(260,180,akfor.text3);
  outtextxy(260,200,akfor.text4);
 end;
 anders:=true;
 waf:=true;
end;

Procedure Ausronline;
begin
 if wasfor <> 2 then begin
  setcolor(4);
  settextstyle(3,0,2);
  Zentertext(255,85,595,455,'Wird zur Zeit nicht erforscht !');
 end;
 if wasfor = 2 then begin
  ladenfor(350,280,akverz,akfor.datei);
  setcolor(9);
  rectangle (260,420,590,440);
  verzierrechteck (350,280,500,380);
  setfillstyle(1,14);
  prozentbar (261,421,589,439,prozentfor);
  setfillstyle(1,0);
  setcolor(red);
  zentertext(260,420,590,440,realtostr(prozentfor)+' %');
  ladenfor(350,280,akverz,akfor.datei);
  settextstyle(2,0,7);
  Zentertext(255,90,595,120,akfor.name);
  settextstyle(2,0,5);
  outtextxy(260,140,akfor.text1); {41 Zeichen}
  outtextxy(260,160,akfor.text2);
  outtextxy(260,180,akfor.text3);
  outtextxy(260,200,akfor.text4);
 end;
 anders:=true;
 wirt:=true;
end;

Procedure Fahrzeugonline;
begin
 if wasfor <> 3 then begin
  setcolor(4);
  settextstyle(3,0,2);
  Zentertext(255,85,595,455,'Wird zur Zeit nicht erforscht !');
 end;
 if wasfor = 3 then begin
  ladenfor(350,280,akverz,akfor.datei);
  setfillstyle(1,14);
  prozentbar (261,421,589,439,prozentfor);
  setfillstyle(1,0);
  setcolor(9);
  zentertext(260,420,590,440,realtostr(prozentfor)+' %');
  rectangle (260,420,590,440);
  verzierrechteck (350,280,500,380);
  setcolor(red);
  settextstyle(2,0,7);
  Zentertext(255,90,595,120,akfor.name);
  settextstyle(2,0,5);
  outtextxy(260,140,akfor.text1); {41 Zeichen}
  outtextxy(260,160,akfor.text2);
  outtextxy(260,180,akfor.text3);
  outtextxy(260,200,akfor.text4);
 end;
 fahr:=true;
 anders:=true;
end;

Procedure Gebaudeonline;
begin
 if wasfor <> 4 then begin
  setcolor(4);
  settextstyle(3,0,2);
  Zentertext(255,85,595,455,'Wird zur Zeit nicht erforscht !');
 end;
 if wasfor = 4 then begin
  ladenfor(350,280,akverz,akfor.datei);
  setcolor(9);
  rectangle (260,420,590,440);
  verzierrechteck (350,280,500,380);
  setfillstyle(1,14);
  prozentbar (261,421,589,439,prozentfor);
  setfillstyle(1,0);
  setcolor(red);
  zentertext(260,420,590,440,realtostr(prozentfor)+' %');
  settextstyle(2,0,7);
  Zentertext(255,90,595,120,akfor.name);
  settextstyle(2,0,5);
  outtextxy(260,140,akfor.text1); {41 Zeichen}
  outtextxy(260,160,akfor.text2);
  outtextxy(260,180,akfor.text3);
  outtextxy(260,200,akfor.text4);
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
 settextstyle(2,0,6);
 Buttonschrift (100,100,200,150,'Waffen');
 Buttonschrift (100,200,200,250,'AusrÅstung');
 buttonschrift (100,300,200,350,'Fahrzeuge');
 buttonschrift (100,400,200,450,'GebÑude');
 button (5,5,60,475);
 settextstyle (1,0,6);
 outtextxy (150,10,'Forschung');
 line (150,65,400,65);
 settextstyle (2,0,6);
 Outtextxy (30,150,'Z');
 Outtextxy (30,180,'U');
 outtextxy (30,210,'R');
 outtextxy (30,240,'ö');
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
    outtextxy (30,240,'ö');
    outtextxy (30,270,'C');
    outtextxy (30,300,'K');
    mouseshow;
   end;
  end;
  If mouseinwindow(100,100,200,150) then begin
   if waf =false then begin
    mousehide;
    setcolor(blue);
    settextstyle(2,0,6);
    ubuttonschrift(100,100,200,150,'Waffen');
    Waffenonline;
    mouseshow;
   end;
  end;
  If mouseinwindow(100,200,200,250) then begin
   if wirt =false then begin
    mousehide;
    setcolor(blue);
    settextstyle(2,0,6);
    ubuttonschrift(100,200,200,250,'AusrÅstung');
    ausronline;
    mouseshow;
   end;
  end;
  If mouseinwindow(100,300,200,350) then begin
   if fahr =false then begin
    mousehide;
    setcolor(blue);
    settextstyle(2,0,6);
    ubuttonschrift(100,300,200,350,'Fahrzeuge');
    Fahrzeugonline;
    mouseshow;
   end;
  end;
  If mouseinwindow(100,400,200,450) then begin
   if ge =false then begin
    mousehide;
    setcolor(blue);
    settextstyle(2,0,6);
    ubuttonschrift(100,400,200,450,'GebÑude');
    Gebaudeonline;
    mouseshow;
   end;
  end;
  if (waf=true) and (not(mouseinwindow(100,100,200,150))) then begin
   mousehide;
   setcolor(lightblue);
   settextstyle(2,0,6);
   buttonschrift(100,100,200,150,'Waffen');
   bar (256,86,594,454);
   waf:=false;
   mouseshow;
  end;
  if (wirt=true) and (not(mouseinwindow(100,200,200,250))) then begin
   mousehide;
   bar (256,86,594,454);
   settextstyle(2,0,6);
   setcolor(lightblue);
   buttonschrift(100,200,200,250,'AusrÅstung');
   wirt:=false;
   mouseshow;
  end;
  if (ge=true) and (not(mouseinwindow(100,400,200,450))) then begin
   mousehide;
   bar (256,86,594,454);
   settextstyle(2,0,6);
   setcolor(lightblue);
   buttonschrift(100,400,200,450,'GebÑude');
   ge:=false;
   mouseshow;
  end;
  if (fahr=true) and (not(mouseinwindow(100,300,200,350))) then begin
   mousehide;
   setcolor(lightblue);
   settextstyle(2,0,6);
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
   outtextxy (30,240,'ö');
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


procedure Forschungwahlen;
var Waffenfor,Ausrfor,Gebfor,Fahrfor : TForschung;
    feld1,feld2,feld3,feld4 : Boolean;

begin
 if (NOT(eof(waffend))) and (NOT(eof(ausrd))) and (NOT(eof(gebd))) and (NOT(eof(fahrd))) then begin
  feld1:=false;
  feld2:=false;
  feld3:=false;
  feld4:=false;
  mousehide;
  cleardevice;
  setcolor(white);
  settextstyle(3,0,4);
  zentertext(0,0,639,100,'Wahl der Forschung');
  if Waffenforb=true then begin
   read(waffend,waffenfor);
   seek(waffend,filepos(waffend)-1);
   settextstyle(2,0,6);
   setcolor(white);
   buttonschrift(9,378,149,478,waffenfor.Name);
  end
  else begin
   ubutton(9,378,149,478);
  end;
  if ausrforb=true then begin
   read(ausrd,ausrfor);
   seek(ausrd,filepos(ausrd)-1);
   settextstyle(2,0,6);
   setcolor(white);
   buttonschrift(172,378,312,478,ausrfor.name);
  end
  else begin
   ubutton(172,378,312,478);
  end;
  if Gebforb=true then begin
   read(gebd,gebfor);
   seek(gebd,filepos(gebd)-1);
   settextstyle(2,0,6);
   setcolor(white);
   buttonschrift(335,378,475,478,gebfor.Name);
  end
  else begin
   ubutton(335,378,475,478);
  end;
  if Fahrforb=true then begin
   read(fahrd,fahrfor);
   seek(fahrd,filepos(fahrd)-1);
   settextstyle(2,0,6);
   setcolor(white);
   buttonschrift(498,378,638,478,fahrfor.Name);
  end
  else begin
   ubutton(498,378,638,478);
  end;
  setcolor(9);
  rectangle(9,110,638,350);
  repeat
   mouseshow;
   if (mouseinwindow(9,378,149,478)) and (feld1=false) and (waffenforb=true) then begin
    setfillstyle(0,black);
    bar(10,111,637,349);
    setcolor(9);
    settextstyle(2,0,8);
    outtextxy (18,114,waffenfor.text1);
    outtextxy (18,144,waffenfor.text2);
    outtextxy (18,174,waffenfor.text3);
    outtextxy (18,204,waffenfor.text4);
    setcolor(lightgray);
    settextstyle(2,0,6);
    mousehide;
    ubuttonschrift(9,378,149,478,waffenfor.Name);
    mouseshow;
    feld1:=true;
   end;
   if (NOT(mouseinwindow(9,378,149,478))) and (feld1=true) and (waffenforb=true) then begin
    setfillstyle(0,black);
    bar(10,111,637,349);
    setcolor(white);
    settextstyle(2,0,6);
    mousehide;
    buttonschrift(9,378,149,478,waffenfor.Name);
    mouseshow;
    feld1:=false;
   end;
   if (mouseinwindow(9,378,149,478)) and (waffenforb=true) and (mousebutton=mousebuttonleft) then begin
    akfor:=waffenfor;
    wasfor:=1;
    waffenforb:=false;
    prozentfor:=0;
   end;
   if (mouseinwindow(172,378,312,478)) and (feld2=false) and (ausrforb=true) then begin
    setcolor(9);
    setfillstyle(0,black);
    bar(10,111,637,349);
    settextstyle(2,0,8);
    outtextxy (18,114,ausrfor.text1);
    outtextxy (18,144,ausrfor.text2);
    outtextxy (18,174,ausrfor.text3);
    outtextxy (18,204,ausrfor.text4);
    settextstyle(2,0,6);
    setcolor(lightgray);
    mousehide;
    ubuttonschrift(172,378,312,478,ausrfor.name);
    mouseshow;
    feld2:=true;
   end;
   if (NOT(mouseinwindow(172,378,312,478))) and (feld2=true) and (ausrforb=true) then begin
    setfillstyle(0,black);
    bar(10,111,637,349);
    settextstyle(2,0,6);
    setcolor(white);
    mousehide;
    buttonschrift(172,378,312,478,ausrfor.name);
    mouseshow;
    feld2:=false;
   end;
   if (mouseinwindow(172,378,312,478)) and (mousebutton=mousebuttonleft) and (ausrforb=true) then begin
    akfor:=ausrfor;
    wasfor:=2;
    ausrforb:=false;
    prozentfor:=0;
   end;
   if (mouseinwindow(335,378,475,478)) and (feld3=false) and (gebforb=true) then begin
    setfillstyle(0,black);
    bar(10,111,637,349);
    setcolor(9);
    settextstyle(2,0,8);
    outtextxy (18,114,gebfor.text1);
    outtextxy (18,144,gebfor.text2);
    outtextxy (18,174,gebfor.text3);
    outtextxy (18,204,gebfor.text4);
    settextstyle(2,0,6);
    setcolor(lightgray);
    mousehide;
    ubuttonschrift(335,378,475,478,gebfor.name);
    mouseshow;
    feld3:=true;
   end;
   if (NOT(mouseinwindow(335,378,475,478))) and (feld3=true) and (gebforb=true) then begin
    setfillstyle(0,black);
    bar(10,111,637,349);
    settextstyle(2,0,6);
    setcolor(white);
    mousehide;
    buttonschrift(335,378,475,478,gebfor.name);
    mouseshow;
    feld3:=false;
   end;
   if (mouseinwindow(335,378,475,478)) and (mousebutton=mousebuttonleft) and (gebforb=true) then begin
    akfor:=gebfor;
    wasfor:=4;
    ausrforb:=false;
    prozentfor:=0;
   end;
   if (mouseinwindow(498,378,638,478)) and (feld4=false) and (fahrforb=true) then begin
    setfillstyle(0,black);
    bar(10,111,637,349);
    setcolor(9);
    settextstyle(2,0,8);
    outtextxy (18,114,fahrfor.text1);
    outtextxy (18,144,fahrfor.text2);
    outtextxy (18,174,fahrfor.text3);
    outtextxy (18,204,fahrfor.text4);
    settextstyle(2,0,6);
    setcolor(lightgray);
    mousehide;
    ubuttonschrift(498,378,638,478,fahrfor.name);
    mouseshow;
    feld4:=true;
   end;
   if (NOT(mouseinwindow(498,378,638,478))) and (feld4=true) and (fahrforb=true) then begin
    setfillstyle(0,black);
    bar(10,111,637,349);
    settextstyle(2,0,6);
    setcolor(white);
    mousehide;
    buttonschrift(498,378,638,478,fahrfor.name);
    mouseshow;
    feld4:=false;
   end;
   if (mouseinwindow(498,378,638,478)) and (mousebutton=mousebuttonleft) and (fahrforb=true) then begin
    akfor:=fahrfor;
    wasfor:=3;
    fahrforb:=false;
    prozentfor:=0;
   end;
  until wasfor <> 0;
  if (fahrforb=false) and (gebforb=false) and (ausrforb=false) and (waffenforb=false) then begin
   seek(fahrd,(filepos(fahrd))+1);
   seek(gebd,(filepos(gebd))+1);
   seek(ausrd,(filepos(ausrd))+1);
   seek(waffend,(filepos(waffend))+1);
   fahrforb:=true;
   gebforb:=true;
   ausrforb:=true;
   waffenforb:=true;
  end;
  mousehide;
  cleardevice;
 end;
end;


procedure ladenfor(x,y : Word;verz : String;Name : tdatei);
var farbe : Byte;
    x1,y1,starty,startx : Word;
    f : File;
    ar : Array [0..149] of Byte;
    lv1 : Laufvar;
begin
 setallpalette(grundpalette);
 assign(f,verz+'\data\'+name+'.mif');
 reset(f,1);
 starty:=y;
 startx:=x;
 x1:=x;
 y1:=y;
 lv1:=0;
 farbe:=30;
 blockread(f,ar,sizeof(ar));
 repeat
  repeat
   if lv1=0 then farbe:=ar[0];
   if (ar[lv1]=farbe) then x1:=x1+1;
   if lv1 <> 149 then lv1:=lv1+1;
  until (lv1=149) or (ar[lv1]<>farbe);
  if lv1=149 then begin
   setcolor(farbe);
   line(x,y,x1,y1);
   x:=startx;
   lv1:=0;
   x1:=x;
   y:=y+1;
   y1:=y;
   blockread(f,ar,sizeof(ar));
  end
  else begin
   setcolor(farbe);
   line(x,y,x1,y1);
   x:=x1;
   x1:=x1;
   farbe:=ar[lv1];
  end;
 until y=starty+99;
 close(f);
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
 outtextxy (10,90, 'Sie lie·en sich dort nieder.');
 outtextxy (10,110,'Der Planet wurde NEW HOME getauft.');
 outtextxy (10,130,'Doch nach ein paar Jahren waren die Leute');
 outtextxy (10,150,'nicht mehr mit der Politik der Siedlungs-');
 outtextxy (10,170,'fÅhrung zufrieden und begann sich zu wehren.');
 outtextxy (10,190,'Die SiedlungsfÅhrung, erklÑrte darauf KRIEG.  ');
 outtextxy (10,210,'Der Krieg dauerte viele Jahre, und viele');
 outtextxy (10,230,'Menschen  fiehlen ihm zum Opfer. ');
 outtextxy (10,250,'Die Kolonie verwandelte sich zu eine MÅllhalde.');
 Outtextxy (200,400,'Bitte Taste drÅcken');
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
 tpl;
 cleardevice;
 outtextxy (10,10, 'Nach Jahren des Elents, war die Regierung ge-');
 outtextxy (10,30, 'schlagen. Doch nun war von der Kolonie nicht mehr');
 outtextxy (10,50, 'viel öbrig, die Menschen standen vor dem Nichts.');
 outtextxy (10,70, 'Immer noch starben viele Menschen, an Hunger und ');
 outtextxy (10,90, 'Seuchen, eine Folge des Krieges.');
 outtextxy (10,110,'Viele Jahre nach dem gro·en Krieg,');
 outtextxy (10,130,'stellte man sich der Herausforderung, die Menschenheit ');
 outtextxy (10,150,'zu retten. Man baute neue UnterkÅnfte, bestellte ');
 outtextxy (10,170,'Felder und fÅhrte eine WÑhrung ein.');
 outtextxy (10,190,'Die Kolonie wurde wieder aufgebaut.Alle halfen,');
 outtextxy (10,210,'das einstige Paradies zu neuem Leben zu erwecken. ');
 outtextxy (10,230,'Doch bis dahin wird es noch ein weiter Weg.');
 outtextxy (10,250,'Man began notdÅrftig értzte auszubilden und besiegte');
 outtextxy (10,270,'die Seuchen.');
 outtextxy (10,290,'In der Kolonie leben nun noch rund 60.000 Menschen.');
 outtextxy (10,310,'Es gibt nur wenige funktionstÅchtige Maschinen,aber');
 outtextxy (10,330,'dafÅr genug Waffen und Medikamente.');
 outtextxy (200,400,'Bitte Taste drÅcken');
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
 tpl;
 cleardevice;
 Outtextxy (10,10,'Wir schreiben das Jahr 2644, das Jahr ');
 outtextxy (10,30,'in dem die Menschen eine neue Chance bekamen!');
 Outtextxy (200,400,'Bitte Taste drÅcken');
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
 tpl;
 cleardevice;
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
 Button (80,440,560,478);
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
 outtextxy(182,223,'Vorrat (Landwirtschaftliche GerÑte) :');
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
 until (mousebutton=mousebuttonleft) and (mouseinwindow(80,440,560,478));
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
 Button (80,440,560,478);
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
 outtextxy(176,133,'HÑndlervorrat (Nahrung) :');
 outtextxy(380,133,inttostr(handlernah));
 button (80,220,560,240);
 outtextxy(128,223,'HÑndlervorrat (Landwirtschaftliche GerÑte) :');
 outtextxy(480,223,inttostr(handlergerat));
 button (80,310,560,330);
 outtextxy(215,313,'HÑndlervorrat (Baumaterial) :');
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
 until (mousebutton=mousebuttonleft) and (mouseinwindow(80,440,560,478));
 mousehide;
 cleardevice;
 anders:=true;
 mouseshow;
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


Procedure Planetenname;
var a : word;

begin
 cleardevice;
 video_disable(true);
 ladenmip('Planet');
 for a:= 1 to 250 do Putpixel (random (640),random (240),white);
 setcolor(9);
 settextstyle(2,0,6);
 Outtextxy (10,30,'Neuer Planetenname :');
 video_disable(false);
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

procedure ladenmip(s : String);
var farbe : Byte;
    x,y,x1,y1 : Word;
    f : File;
    ar : Array [0..639] of Byte;
    lv1 : Laufvar;
begin
 if s='Planet' then begin
  assign(f,akverz+'\data\planet.mip');
  reset(f,1);
  x:=0;
  y:=220;
  x1:=x;
  y1:=y;
  lv1:=0;
  farbe:=30;
  blockread(f,ar,sizeof(ar));
  repeat
   repeat
    if lv1=0 then farbe:=ar[0];
    if (ar[lv1]=farbe) then x1:=x1+1;
    if lv1 <> 639 then lv1:=lv1+1;
   until (lv1=639) or (ar[lv1]<>farbe);
   if lv1=639 then begin
    setcolor(farbe);
    line(x,y,x1,y1);
    x:=0;
    lv1:=0;
    x1:=x;
    y:=y+1;
    y1:=y;
    blockread(f,ar,sizeof(ar));
   end
   else begin
    setcolor(farbe);
    line(x,y,x1,y1);
    x:=x1;
    x1:=x1;
    farbe:=ar[lv1];
   end;
  until y=getmaxy;
 end;
 if s='Menu' then begin
  assign(f,akverz+'\data\menu.mip');
  reset(f,1);
  x:=0;
  y:=220;
  x1:=x;
  y1:=y;
  lv1:=0;
  farbe:=30;
  reset(f,1);
  blockread(f,ar,sizeof(ar));
  repeat
   repeat
    if lv1=0 then farbe:=ar[0];
    if (ar[lv1]=farbe) then x1:=x1+1;
    if lv1 <> 639 then lv1:=lv1+1;
   until (lv1=639) or (ar[lv1]<>farbe);
   if lv1=639 then begin
    setcolor(farbe);
    line(x,y,x1,y1);
    x:=0;
    lv1:=0;
    x1:=x;
    y:=y+1;
    y1:=y;
   blockread(f,ar,sizeof(ar));
   end
   else begin
    setcolor(farbe);
    line(x,y,x1,y1);
    x:=x1;
    x1:=x1;
    farbe:=ar[lv1];
   end;
  until y=getmaxy;
 end;
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