uses crt,dos,alles,graph;

var reg : Registers;
    x,y : Word;

procedure putpixel(x,y : Word;farbe : Byte);

begin
 if (x<320) and (y<200) then mem[$A000:(y*320)+x]:=farbe;
end;

procedure e (x,y : Word;farbe : Byte);
var x1,y1 : Word;
begin
 x1:=x;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+1;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+2;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x;
 y1:=y+1;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x;
 y1:=y+2;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+1;
 y1:=y+2;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x;
 y1:=y+3;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+1;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+2;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
end;

procedure eweg (x,y : Word);
var x1,y1 : Word;
begin
 x1:=x;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+1;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+2;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x;
 y1:=y+1;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x;
 y1:=y+2;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+1;
 y1:=y+2;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x;
 y1:=y+3;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+1;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+2;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
end;

procedure J (x,y : Word;farbe : Byte);

var x1,y1 : Word;

begin
 x1:=x;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+1;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+2;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+3;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+3;
 y1:=y+1;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+3;
 y1:=y+2;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+3;
 y1:=y+3;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+2;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x+1;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
 x1:=x;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=farbe;
end;

procedure Jweg (x,y : Word);

var x1,y1 : Word;

begin
 x1:=x;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+1;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+2;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+3;
 y1:=y;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+3;
 y1:=y+1;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+3;
 y1:=y+2;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+3;
 y1:=y+3;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+2;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x+1;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
 x1:=x;
 y1:=y+4;
 if (x1<320) and (y1<200) then mem[$A000:(y1*320)+x1]:=0;
end;

begin
 reg.ah := $00;
 reg.al := $13;
 Intr($10,reg);
 x:=100;
 y:=200;
 repeat
  e (x,y,red);
  delay(300);
  if y<>1 then eweg(x,y);
  y:=y-1;
 until y=0;
 x:=1;
 y:=1;
 repeat
  j (x,y,red);
  delay(200);
  if x<>90 then jweg(x,y);
  x:=x+1;
 until x=91;
 waitkey;
end.