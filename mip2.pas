uses crt,graph,alles;

procedure laden;
var a,b : Word;
    farbe: byte;
    f : File of byte;

begin
 assign(f,'C:\pascal\data\menu.mip');
 reset(f);
 for a:= 1 to getmaxx DO
 for b:= 240 to getmaxy DO begin
  read(f,farbe);
  putpixel(a,b,farbe);
 end;
 readln;
end;

procedure speichern;

var f : File;
    farbe : Byte;
    a     : Array [1..1278] of byte;
    x,y,lauf : Word;

begin
 assign(f,'C:\pascal\data\menu.mip');
 rewrite(f,1);
 lauf:=1;
 for y:=240 to getmaxy DO
 for x:=1 to getmaxx DO begin
  farbe:=getpixel(x,y);
  a[lauf]:=farbe;
  lauf:=lauf+1;
  if (lauf=1279) or (y=479) then begin
   lauf:=1;
   blockwrite(f,a,1278);
  end;
 end;
 close(f);
end;

procedure neuladen;
var farbe : Byte;
    x,y,x1,y1 : Word;
    f : File;
    ar : Array [0..639] of Byte;
    lv1 : Laufvar;
begin
 assign(f,'c:\pascal\data\menu1.mip');
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

begin
 grd:=detect;
 initgraph(grd,grm,'');
{ laden;
 speichern;
 cleardevice;}
 readln;
 neuladen;
 readln;
 closegraph;
end.
