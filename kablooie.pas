program kablooie;
uses crt,bgi256,graph,colour;

const
	sh=16;
	mul=65536;
	csize=64;
	works: string[30] = 'kablooie.kab';

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
			assigncolor(0,white);
			assigncolor(1,grey90);
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
		if flash then
		begin
			assigncolor(0,black);
			assigncolor(1,grey10);
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
		for i:=1 to random(loads) do
			l:=l^.next;
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
	randomize;
	gentrig;
	o:=getmaxmode;
	s:=getmodename(o);
	if paramcount=0 then
	begin
		restorecrtmode;
		writeln('Kablooie (c) 1991 Daniel Egnor -- The Complete Fireworks Simulator!');
		writeln('Requires VGA/MCGA/SVGA');
		writeln;
		writeln('to start: kablooie [kablfile.kab] [m]');
		writeln;
		writeln('[kablfile.kab] is the file name containing firework info.');
		writeln('the default is ',works,'.');
		writeln;
		writeln('[m] is the mode number:');
		writeln;
		writeln('0: 320x200x256,  1: 640x400x256');
		writeln('2: 640x480x256,  3: 800x600x256');
		writeln('4: 1024x768x256, 5: 2048x1025x256 (wow!)');
		writeln;
		writeln('For SVGA modes a VESA-standard BIOS or TSR is required.');
		writeln('Default: ',o,': ',s);
		writeln;
		write('Hit return to continue; <esc> stops it . . .');
		readln;
		setgraphmode(o);
	end else
	begin
		for i:=1 to paramcount do
		begin
			val(paramstr(1),m,mm);
			if (mm=0) and (m>=0) and (m<=o) then
				setgraphmode(m)
			else
				works:=paramstr(i);
		end;
	end;
	maxx:=getmaxx;
	maxy:=getmaxy;
	count:=0;
	loads:=0;
	col[1]:=grey10;
	col[2]:=white;
	col[csize-1]:=orange;
	range(col,2,csize-1);
	col[csize]:=white;
	col[2*csize-1]:=blue;
	range(col,csize,2*csize-1);
	col[2*csize]:=white;
	col[3*csize-1]:=red;
	range(col,2*csize,3*csize-1);
	col[3*csize]:=white;
	col[4*csize-1]:=jade;
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
procedure err(s: string);
begin
	closegraph;
	writeln('Error in file: ',works,': ',s);
	close(f);
	halt(1);
end;

function getstr: string;
var s: string;
	 i: integer;
begin
	s:='';
	while ((s='') or (s[1]=' ')) and (not eof(f)) do
	begin
		readln(f,s);
	end;
	if (s='') or (s[1]=' ') then
		err('premature EOF.');
	for i:=1 to length(s) do
		s[i]:=upcase(s[i]);
	getstr:=s;
end;

function getnum: integer;
var n,nn: integer;
begin
	val(getstr,n,nn);
	if nn<>0 then
		err('invalid number.');
	getnum:=n;
end;
procedure readfile;
var l: load;
	 p: pack;
	 s,t: string;
begin
	assign(f,works);
	reset(f);
	if ioresult<>0 then
		err('cannot be opened.');
	while not eof(f) do
	begin
		s:=getstr;
		if (s<>'FIREWORK') and (s<>'PACKING') then
			err('FIREWORK or PACKING expected.');
		l.name:=getstr;
		t:=getstr;
		if (t<>'FLASH') and (t<>'NOFLASH') then
			err('FLASH or NOFLASH expected.');
		l.flash:=(t='FLASH');
		t:=getstr;
		if (t<>'RED') and (t<>'YELLOW') and (t<>'GREEN') and (t<>'BLUE') then
			err('color name expected.');
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
			if p.stuff=nil then
				err('packing not found.');
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
	init;
	readfile;
	repeat
		cleardevice;
		while not keypressed do
			disppix;
	until readkey=#27;
	closegraph;
end.