{$A-,B-,D+,E+,F-,G+,I-,L+,N-,O-,R+,S+,V+,X-}
{$M 46384,0,655360}

Unit editor;

interface

uses crt,graph,dos,alles;

procedure intro;
procedure test;
procedure pixelf(nummer:Word;c:Byte);

implementation

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

label ende;

begin
 z:=0;
 c:=0;
 FOR z := 0 to 16000 DO
 begin
  if c = 255 then c:=0;
  c := c+1;
  if round(z/160) = z/160 then
  pixelf(z,c);
  if keypressed then goto ende;
 end;
 mousehide;
 ende:
 mouseshow;
 z:=0;
end;

procedure Intro;
Var x,y, x1, y1 :Integer;
Begin
 X:=round(getmaxx/2);
 y:=getmaxy;
 x1:=1;
 y1:=1;
 setcolor(zufall(1,16));
 repeat
  line(x,y,x1,y1);
  x1:=x1+3;
 until x1 >= 1024;
 X:=round(getmaxx/2);
 y:=0;
 x1:=1;
 y1:=getmaxy;
 setcolor(zufall(1,16));
 repeat
  line(x,y,x1,y1);
  x1:=x1+3;
 until x1 >= 1024;
 X:=0;
 y:=round(getmaxy / 2);
 x1:=getmaxx;
 y1:=1;
 setcolor(zufall(1,16));
 repeat
  line (x,y,x1,y1);
  y1:=Y1+5;
 until y1 >= 768;
 X:=getmaxx;
 y:=round (getmaxy / 2);
 x1:=1;
 y1:=1;
 setcolor(zufall(1,16));
 repeat
  line (x,y,x1,y1);
  y1:=Y1+5;
 until y1 >= 768;
 setcolor (black);
 settextstyle (3,0,9);
 OutTextXY((GetMaxX div 2) - 400,(GetMaxY div 2)-60,'Background-Maker');
end;

end.