UNIT colour;

INTERFACE

TYPE
	color=RECORD        { A palette 'cell' }
		r,g,b: byte
	END;
	palette=ARRAY[0..255] OF color;   { a complete, 256-color palette }

CONST
	background=0; { index of palette corresponding to background }
	black:      color=(r: 0;  g: 0;  b: 0 ); { list of standard colors }
	grey10:     color=(r: 6;  g: 6;  b: 6 );
	grey20:     color=(r: 13; g: 13; b: 13); { grayscale -- percentages }
	grey30:     color=(r: 19; g: 19; b: 19);
	grey40:     color=(r: 25; g: 25; b: 25);
	grey50:     color=(r: 32; g: 32; b: 32);
	grey60:     color=(r: 38; g: 38; b: 38);
	grey70:     color=(r: 45; g: 45; b: 45);
	grey80:     color=(r: 51; g: 51; b: 51);
	grey90:     color=(r: 57; g: 57; b: 57);
	white:      color=(r: 63; g: 63; b: 63); { maximum intensity }
	red:        color=(r: 63; g: 0;  b: 0 ); { primary colors }
	green:      color=(r: 0;  g: 63; b: 0 );
	blue:       color=(r: 0;  g: 0;  b: 63);
	yellow:     color=(r: 63; g: 63; b: 0 ); { secondary colors }
	cyan:       color=(r: 0;  g: 63; b: 63);
	purple:     color=(r: 63; g: 0;  b: 63);
	orange:     color=(r: 63; g: 32; b: 0 ); { tertiary colors }
	chartreuse: color=(r: 32; g: 63; b: 0 ); { quite uncommon... }
	jade:       color=(r: 0;  g: 63; b: 32);
	robin:      color=(r: 0;  g: 32; b: 63);
	periwinkle: color=(r: 32; g: 0;  b: 63);
	magenta:    color=(r: 63; g: 0;  b: 32); { not typical, but accurate }

	color16map: ARRAY[0..15] OF byte =
	(0,1,2,3,4,5,20,7,56,57,58,59,60,61,62,63);

	{ AssignColor -- sets color INDEX to C }
PROCEDURE AssignColor(index: byte; c: color);
	{ SetColors -- mass version of AssignColor...
	 Sets n colors, starting at index I and location C in palette P }
PROCEDURE Assign16Color(index: byte; c: color);
PROCEDURE SetColors(p: palette; i,c: byte; n: word);
	{ Loads a FractINT-style .MAP file into a palette
	 fn is the filename, p is the palette to place it in }
PROCEDURE Set16Colors(p: palette; i,c: byte; n: word);
PROCEDURE LoadColors(fn: STRING; VAR p: palette);
	{ Saves a FractINT-style .MAP file from a palette
	 fn is the filename, p is the palette to place it in }
PROCEDURE SaveColors(fn: STRING; p: palette);
	{ Sets an element by red, green, and blue components...
	 c=color to set, r,g,b are % components 0-100 }
PROCEDURE SetRGB(VAR c: color; r,g,b: byte);
	{ Sets color by Hue, Saturation, Intensity scale,
	 c=color to set, h=hue 0-360, s=saturation 0-100 (100=pure, 0=grey)
	 i=intensity 0-100 (0=black, 100=max) }
PROCEDURE SetHSI(VAR c: color; h: word; s,i: byte);
	{ Returns the red, green, and blue components,
	 c=color to get, r,g,b=red, green, and blue returns }
PROCEDURE GetRGB(c: color; VAR r,g,b: byte);
	{ Averages two colors, weighted with percentages.
	 p=resulting color
	 c1,c2=colors to mix
	 p1,p2=percentages of each color. }
PROCEDURE Mix(VAR p,c1: color; p1: byte; c2: color; p2: byte);
	{ Rather an odd procedure...
	 p=resulting color
	 c=color to alter
	 t=color to tint c with
	 pt=percentage of tint }
PROCEDURE Tint(VAR p: color; c,t: color);
	{ Gets the intensity of a color }
FUNCTION Intensity(c: color): byte;
	{ Sets the contrast of a color c by pt relative to grey }
PROCEDURE Contrast(VAR p: color; c: color; pt: byte);
	{ Uses mix to average over a selection of colors in a palette }
PROCEDURE Range(VAR p: palette; i1,i2: byte);
	{ Sets overscan border color to c }
PROCEDURE SetBorder(c: byte);

IMPLEMENTATION

USES DOS;

VAR
	r: Registers;

PROCEDURE AssignColor;
BEGIN
	r.ax:=$1010;
	r.bh:=0;
	r.bl:=index;
	r.dh:=c.r;
	r.ch:=c.g;
	r.cl:=c.b;
	intr($10,r)
END;

PROCEDURE Assign16Color;
BEGIN
	r.ax:=$1010;
	r.bh:=0;
	r.bl:=color16map[index];
	r.dh:=c.r;
	r.ch:=c.g;
	r.cl:=c.b;
	intr($10,r)
END;

PROCEDURE SetColors;
BEGIN
	r.ax:=$1012;
	r.bh:=0;
	r.bl:=c;
	r.cx:=n;
	r.es:=Seg(p);
	r.dx:=Ofs(p[0])+i*3;
	intr($10,r)
END;

PROCEDURE Set16Colors;
VAR t: Palette;
	 j: integer;
BEGIN
	FOR j:=1 TO n DO
		t[color16map[j+c-1]]:=p[j+i-1];
	SetColors(t,color16map[i],color16map[c],color16map[c+n-1]-color16map[c]+1)
END;

{$I-}
PROCEDURE LoadColors;
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

PROCEDURE SetRGB;
BEGIN
	c.r:=r*63 div 100;  { rather simple, really -- just convert % into }
	c.g:=g*63 div 100;  { BIOS mapping 0-63 }
	c.b:=b*63 div 100
END;

PROCEDURE GetRGB;
BEGIN
	r:=c.r*100 div 63;
	g:=c.g*100 div 63;
	b:=c.b*100 div 63
END;

PROCEDURE SetHSI;
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

PROCEDURE Mix;
BEGIN
	p.r:=(c1.r*p1+c2.r*p2) div 100; { just do a weighted average }
	p.g:=(c1.g*p1+c2.g*p2) div 100;
	p.b:=(c1.b*p1+c2.b*p2) div 100
END;

PROCEDURE Tint;
BEGIN
	p.r:=c.r*t.r div 63;   { brings out components, really }
	p.g:=c.g*t.g div 63;
	p.b:=c.b*t.b div 63
END;

FUNCTION Intensity;
BEGIN
	Intensity:=(c.r+c.g+c.b)*100 div 191 { really dumb function }
END;

PROCEDURE Contrast;
VAR i: byte;
BEGIN
	i:=Intensity(c)*63 div 100;
	p.r:=c.r+(i-c.r)*pt div 100;  { just moves away/closer to grey }
	p.g:=c.g+(i-c.g)*pt div 100;
	p.b:=c.b+(i-c.b)*pt div 100
END;

PROCEDURE Range;
VAR i: byte;
BEGIN
	FOR i:=i1 TO i2 DO { simple averaging loop }
		Mix(p[i],p[i1],(i2-i)*100 div (i2-i1),p[i2],(i-i1)*100 div (i2-i1))
END;

PROCEDURE SetBorder;
BEGIN
	r.ax:=$1001;
	r.bh:=c;
	intr($10,r);
END;

END.