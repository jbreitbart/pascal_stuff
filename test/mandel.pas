{$R+}
Program Mandelbrot;

uses crt,graph;

type xpos   = 0..560;
     ypos   = 0..480;
     itcount = 0..101;

var f:file of byte;
    ik,rk,ikn,rkn,xn,yn,zoomvar :real;
            rk1,ik1,lv1,lv ,pc  :integer;
                        saveint : array[1..560] of byte;
                    itanz       :itcount;
                    x           :xpos;
                    y           :ypos;
                    farbe       :byte;
                    choose      :char;
                    ikt,rkt     :string[15];

{********* Prozeduren ********* }

Procedure Completemenu;

Begin
 Setfillstyle(solidfill,0);
 Bar(466,6,634,151);
 Window(60,2,80,10);
 drawbutton(466,157,546,187);
 drawbutton(548,157,634,187);
 drawbutton(466,189,546,219);
 drawbutton(548,189,634,219);
 drawbutton(466,221,546,251);
 drawbutton(548,221,634,251);
 drawbutton(466,253,634,283);
 drawbutton(466,285,634,315);
 drawbutton(466,318,634,348);
 drawbutton(466,350,634,380);
 drawbutton(466,382,634,412);
 drawbutton(466,415,634,445);
 settextstyle(2,0,4);
 setcolor(0);
 Outtextxy(470,166,'Y ranzoomen');
 Outtextxy(552,166,'Z wegzoomen');
 Outtextxy(470,197,'N hell(s/w)');
 Outtextxy(552,197,'W dunkel(s/w)');
 Outtextxy(470,228,'S speichern');
 Outtextxy(552,228,'L laden');
 Outtextxy(470,261,'G nur GrÅntîne');
 Outtextxy(470,293,'R nur Rottîne');
 Outtextxy(470,326,'B nur Blautîne');
 Outtextxy(470,358,'P Palettenfluktuation');
 Outtextxy(470,390,'K Konstanten definieren');
 Outtextxy(470,423,'X Programm beenden');
 settextstyle(4,0,1);
 Outtextxy(470,450,'written by David W.');
 Settextstyle(2,0,4);
 setcolor(15);
end;

Procedure itteration;
var aneu,a,b:real;

Begin
 a:=0;
 B:=0;
 itanz:=0;
 repeat
   aneu:=a*a-b*b+rk;
   b:=2*a*b+ik;
   a:=aneu;
   itanz:=itanz+1;
 until ((a*a+b*b)>=4)
 or(itanz>100);
 farbe:=round(itanz/getmaxcolor*100+15);
end;

procedure drawmbg;

begin
 x:=0;
 RK:=rkn;
 y:=0;
 IK:=ikn;
 farbe:=0;
 repeat
  repeat
   itteration;
   putpixel(x,y,farbe);
   RK:=RK+xn;
   x:=x+1;
  until x=460;
  RK:=rkn;
  x:=0;
  IK:=IK-yn;
  y:=y+1;
 until y=480;
 Ik:=ikn;
 completemenu;
end;

Procedure zoomout;

Begin
 xn:=3/(getmaxx+1)/zoomvar;
 yn:=2/(getmaxy+1)/zoomvar;
 zoomvar:=zoomvar/10;
 drawmbg;
end;

Procedure zoomin;

begin
 xn:=3/(getmaxx+1)/zoomvar;
 yn:=2/(getmaxy+1)/zoomvar;
 zoomvar:=zoomvar*10;
 drawmbg;
end;

Procedure Defkonst;

Begin
 setcolor(15);
 str(ik:1:9,ikt);
 Outtextxy(470,10,'Alte IK : ');
 Outtextxy(550,10,ikt);
 str(rk:1:9,rkt);
 Outtextxy(470,20,'Alte RK : ');
 Outtextxy(550,20,rkt);
 outtextxy(470,30,'Neue Ik : ');Gotoxy(7,2);
 readln(ikn);
 outtextxy(470,40,'Neue Rk : ');Gotoxy(7,3);
 readln(rkn);
 drawmbg;
end;

Procedure Exit;

Begin
 closegraph;
 clrscr;
 writeln('Danke, dass sie dieses Programm genutzt haben.');
 halt;
end;

Procedure graphstart;

var tr,md : integer;

Begin
 tr:=Installuserdriver('svga256',NIL);
 md:=2;
 initgraph(tr,md,'');
end;

Procedure Fluktuationr;

var r : Integer;

Begin
 For r:=1 to 63 do
  Setrgbpalette(r,r,0,0);
end;

Procedure Fluktuationg;

var g : Integer;
Begin
 For g:=1 to 63 do
  Setrgbpalette(g,0,g,0);
end;

Procedure Fluktuationb;

var b : Integer;
Begin
 For b:=1 to 63 do
  Setrgbpalette(b,0,0,b-1);
end;
Procedure Pfluktuation;

var lv1: Integer;

Begin
 repeat
  For lv1:= 1 to 256 do
   Begin
    Setrgbpalette(lv1,random(63),random(63),random(63));
   end;
 until keypressed;
end;

Procedure Fluktuationw;

var lv1:integer;

Begin
 For lv1:= 1 to 63 do
  Setrgbpalette(lv1,lv1+1,lv1+1,lv1+1);
end;

Procedure Fluktuations;

var lv1,r:integer;

Begin
 r:=0;
 For lv1:= 63 downto 1 do
  Begin
   Setrgbpalette(lv1,r+1,r+1,r+1);
   r:=r+1;
  end;
end;

Procedure save;
var lvx,lvy : Integer;
    saver : array[1..560] of byte;
    Name : string;

Begin
 Settextstyle(2,0,4);
 Setcolor(white);
 Outtextxy(470,10,'SPEICHERN');
 Outtextxy(470,20,'Bitte Dateiname eingeben: ');
 gotoxy(1,3);
 readln(name);
 assign(f,name);
 rewrite(f);
 For lvy := 1 to 480 do
  Begin
   For lvx:= 1 to 460 do
    Begin
     saver[lvx]:=getpixel(lvx,lvy);
     write(f,saver[lvx]);
    end;
  end;
 close(f);
 completemenu;
end;

Procedure load;
var lvx,lvy : Integer;
    saver : array[1..560] of byte;
    Name : string;

Begin
Settextstyle(2,0,4);
 Setcolor(white);
 Outtextxy(470,10,'LADEN');
 Outtextxy(470,20,'Bitte Dateiname eingeben: ');
 gotoxy(1,3);
 readln(name);
 assign(f,name);
 reset(f);
 For lvy := 1 to 480 do
  Begin
   For lvx:= 1 to 460 do
    Begin
     read(f,saver[lvx]);
     putpixel(lvx,lvy,saver[lvx]);
    end;
  end;
 close(f);
 completemenu;
end;

{********* Hauptprogramm ********* }

Begin
 graphstart;
 cleardevice;
 randomize;
 drawmenu;
 completemenu;
 zoomvar :=1;
 rkn:=-1.5;
 ikn:=1;
 xn:=3/(getmaxx+1);
 yn:=2/(getmaxy+1);
 Outtextxy(1,1,'Mit E starten sie die Berechnung des Bereichs von -1.5 bis 1');
 repeat
  choose:=readkey;
   case choose of
    'x','X':Exit;
    'r','R':Fluktuationr;
    'g','G':Fluktuationg;
    'b','B':Fluktuationb;
    'w','W':Fluktuationw;
    'n','N':fluktuationS;
    'p','P':Pfluktuation;
    'z','Z':zoomout;
    'y','y':zoomin;
    'k','K':defkonst;
    'l','L':load;
    's','S':save;
    'e','E':drawmbg;
   end;
 until 2=3;
end.
{ Die Mausfunktionen  sind leider nicht rechtzeitig fertiggeworden.(Falscher Bgi-Treiber.)
  TIP:
  Wenn sie interessante Bereiche Finden drÅcken sie 'K' und schreiben sie einfach die alten
  Konstanten ab.TschÅss!Viel Spa· beim Testen!!}
