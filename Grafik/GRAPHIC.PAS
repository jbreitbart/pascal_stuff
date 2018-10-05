PROGRAM Grafik;

uses Graph, Crt;

var grDriver, grMode : Integer;
var x, x1, y, y1, a, b, c,d, z, w, color1, color2, color3, color4, e, f, g, h : Integer;
var StAngle,EndAngle, Pattern,Color, StAngel1, EndAngel1, Radius : WORD;
var Frage : String;

label alles, Balken, Recht, Kreis, Ell, Pack, anfang, Linien, Ende, Progra, linto, linie4, linien3, Pixel;

begin
 checkbreak:=false;
 anfang:
 CLOSEGRAPH;
 CLRSCR;
 writeln ('1 = Alles');
 writeln ('2 = Balken');
 writeln ('3 = Linien');
 writeln ('4 = Rechtecke');
 writeln ('5 = Kreise');
 writeln ('6 = Ellipsen');
 writeln ('7 = Packmans');
 writeln ('8 = Verbundene Linien');
 writeln ('9 = Criss Cross');
 writeln ('10 = Linien 2');
 writeln ('11 = Pixel');
 writeln ('P = Programmierer');
 writeln ('E = Ende');
 write ('Womit soll der Bildschirm gefÅllt werden : ');
 readln (Frage);
 grdriver:= InstallUserDriver('vesa',NIL);
 grmode:=7;
 InitGraph(grDriver,grMode,'');
 RANDOMIZE;
 if Frage = ('1') then goto alles;
 if Frage = ('2') then goto Balken;
 if Frage = ('3') then goto Linien;
 if Frage = ('4') then goto Recht;
 if Frage = ('5') then goto Kreis;
 if Frage = ('6') then goto Ell;
 if Frage = ('7') then goto Pack;
 if frage = ('8') then goto linto;
 if frage = ('9') then goto linie4;
 if Frage = ('10') then goto linien3;
 if frage = ('11') then goto pixel;
 if Frage = ('E') then goto Ende;
 if Frage = ('e') then goto Ende;
 if frage = ('p') then goto Progra;
 if frage = ('P') then goto Progra;
 goto anfang;
  Pixel:
  repeat;
   c := RANDOM(256);
   x := RANDOM(1024);
   y := RANDOM(768);
   putpixel (x,y,c);
{   delay (50);}
  until keypressed;
  readln;
  repeat;
   X:= RANDOM(1024);
   y:= RANDOM(768);
   putpixel (x,y,black);
  until keypressed;
  goto anfang;
  linien3:
   repeat;
    BEGIN
    setcolor (RANDOM(256));
    x := RANDOM(1024);
    y := RANDOM (768);
    line (512,384
    ,x,y);
    delay (50);
    END;
    Until keypressed;
    goto anfang;
  linie4:
   color1 := RANDOM(256);
   color2 := RANDOM(256);
   color3 := RANDOM(256);
   color4 := RANDOM(256);
   repeat;
   x := 1024;
   y := 768;
   z := Random(1024);
   w := Random(768);
   c := 0;
   d := 0;
   a := Random(1024);
   b := Random(768);
   e := Random(1024);
   f := Random(768);
   g := RANDOM(1024);
   h := RANDOM(768);
   setcolor(color1);
   line (c,d,a,b);
   delay (50);
   setcolor (color2);
   line (x,y,z,w);
   delay (50);
   setcolor (color3);
   line (x,0,e,f);
   delay (50);
   setcolor (color4);
   line (0,y,g,h);
   delay (50);
   until keypressed;
  goto anfang;
  Linto:
   delay (500);
   Repeat;
   Setcolor (RANDOM(256));
   x := RANDOM (1024);
   y := RANDOM (768);
   lineto (x,y);
   delay (500);
   until keypressed;
   goto anfang;
  Linien:
   REPEAT;
   BEGIN

    {Variablen}
    SETCOLOR (RANDOM (256));
    a        := RANDOM (1024);
    b        := RANDOM (768);
    X1       := RANDOM (1024);
    Y1       := RANDOM (768);

    {Linie}
    Line(a,b,X1,Y1);
    delay (500);

   END;
  UNTIL KeyPressed;
   goto anfang;
  Pack:
   REPEAT;
    BEGIN

    {Variablen}
    SETCOLOR (RANDOM (256));
    X1       := RANDOM (1024);
    Y1       := RANDOM (768);
    Pattern  := 1;
    StAngel1 := RANDOM (180);
    EndAngel1:= RANDOM (360);
    Radius   := RANDOM (50);
    color    := RANDOM (100);
    SetFillStyle(Pattern,Color);
    endangel1 := endangel1 + 180;
    stangel1 := stangel1 + 180;

    {Packmans}
    PieSlice (X1,Y1,StAngel1,EndAngel1,Radius);
    delay (500);
   END;
  UNTIL KeyPressed;
  goto anfang;

  Ell:
   REPEAT;
   BEGIN

    {Variablen}
    SETCOLOR (RANDOM (256));
    b        := RANDOM (768);
    a        := RANDOM (1024);
    StAngle  := RANDOM (900);
    Endangle := RANDOM (900);
    x1       := RANDOM (300);
    y1       := RANDOM (400);

    {Elipsen}
    ELLIPSE (a,b,Stangle,ENDAngle,X1,Y1);
    delay (500);
   END;
  UNTIL KeyPressed;
   goto anfang;
  Kreis:

   REPEAT;
   BEGIN

    {Variablen}
    SETCOLOR (RANDOM (256));
    X1       := RANDOM (1024);
    Y        := RANDOM (768);
    X        := RANDOM (1024);
    Pattern  := 1;
    SetFillStyle(Pattern,Color);

    {Kreise}
    CIRCLE (X,Y,X1);
    delay (500);

   END;
  UNTIL KeyPressed;
  goto anfang;
  Recht:

  REPEAT;
   BEGIN

    {Variablen}
    SETCOLOR (RANDOM (256));
    X1       := RANDOM (1024);
    Y        := RANDOM (768);
    Y1       := RANDOM (768);
    X        := RANDOM (1024);
    Pattern  := 1;
    SetFillStyle(Pattern,Color);

    {Rechteck}
    Rectangle (X,Y,X1,Y1);
    delay (500);
   END;
  UNTIL KeyPressed;
  goto anfang;

  Balken:

   REPEAT;
   BEGIN

    {Variablen}
    SETCOLOR (RANDOM (256));
    X1       := RANDOM (1024);
    Y        := RANDOM (768);
    Y1       := RANDOM (768);
    X        := RANDOM (1024);
    Pattern  := 1;
    COLOR    := RANDOM (100);
    SetFillStyle(Pattern,Color);

    {Balken}
    BAR (x,y,x1,y1);
    delay (2000);
  
   END;
  UNTIL KeyPressed;
   goto anfang;

  
  alles:
  REPEAT;
   BEGIN

    {Variablen}
    SETCOLOR (RANDOM (256));
    a        := RANDOM (1024);
    b        := RANDOM (1024);
    X1       := RANDOM (1024);
    Y        := RANDOM (768);
    Y1       := RANDOM (768);
    X        := RANDOM (1024);
    StAngle  := RANDOM (900);
    Endangle := RANDOM (900);
    Pattern  := 1;
    Color    := RANDOM (40);
    StAngel1 := RANDOM (900);
    EndAngel1:= RANDOM (900);
    Radius   := RANDOM (30);
    a := RANDOM(768);
    b := RANDOM(1024);
    SetFillStyle(Pattern,Color);

    {Balken}
    BAR (x,y,x1,y1);
    delay (500);

    {Linie}
    Line(a,b,X1,Y1);
    delay (500);

    {Rechteck}
    Rectangle (X,Y,X1,Y1);
    delay (500);

    {Kreise}
    CIRCLE (X,Y,X1);
    delay (500);

    {Elipsen}
    ELLIPSE (X,Y,Stangle,ENDAngle,X1,Y1);
    delay (500);

    {Packmans}
    PieSlice (b,a,StAngel1,EndAngel1,Radius);
    delay (500);
   END;
  UNTIL KeyPressed;
  goto Anfang;
 Progra:
  Repeat;
   Setcolor (RANDOM(256));
   x := RANDOM (1024);
   y := RANDOM (768);
   settextstyle (1,0,1);
   outtextxy (x,y, 'Programmiert von Jensman !');
   delay (500);
   until Keypressed;
   goto ANFANG;
 Ende:
  Repeat;
  SETCOLOR (RANDOM(256));
  x := RANDOM (1024);
  y := RANDOM (768);
  settextstyle (1,0,1);
  outtextxy (x,y, 'ENDE');
  delay (500);
  Until Keypressed;
  CLOSEGRAPH;
end.